from flask import Flask, request, jsonify
from flask_cors import CORS
from models import db, AQIPrediction
from datetime import datetime, date, timedelta
import pickle
import os
import numpy as np
import requests

app = Flask(__name__)

# Database configuration - use PostgreSQL in production, SQLite in development
app.config['SQLALCHEMY_DATABASE_URI'] = os.environ.get('DATABASE_URL', 'sqlite:///database.db')
if app.config['SQLALCHEMY_DATABASE_URI'].startswith('postgres://'):
    app.config['SQLALCHEMY_DATABASE_URI'] = app.config['SQLALCHEMY_DATABASE_URI'].replace('postgres://', 'postgresql://', 1)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

# Initialize extensions
db.init_app(app)

# CORS configuration - allow production domains
allowed_origins = [
    'http://localhost:3000',
    'http://localhost:5000',
    os.environ.get('FRONTEND_URL', '')
]
CORS(app, resources={r"/*": {"origins": [origin for origin in allowed_origins if origin]}})

# Global variables for model and feature order
model = None
feature_order = None

def load_model():
    """Load the pre-trained XGBoost model"""
    global model, feature_order
    
    model_path = 'delhi_aqi_xgb(1).pkl'
    feature_path = 'feature_order.pkl'
    
    try:
        with open(model_path, 'rb') as f:
            loaded_model = pickle.load(f)
        
        # Fix for XGBoost version compatibility - remove deprecated attributes
        if hasattr(loaded_model, 'gpu_id'):
            delattr(loaded_model, 'gpu_id')
        
        model = loaded_model
        print("✓ Model loaded successfully")
    except FileNotFoundError:
        print(f"⚠ Warning: {model_path} not found.")
        print("   To create it: Open AQI_Foracting_Delhi (1).ipynb and run the last 2 cells.")
        print("   Using fallback formula for now.")
        model = None
    except Exception as e:
        print(f"⚠ Error loading model: {e}")
        print("   Using fallback formula for now.")
        model = None
    
    try:
        with open(feature_path, 'rb') as f:
            feature_order = pickle.load(f)
        print("✓ Feature order loaded successfully")
    except FileNotFoundError:
        print(f"⚠ Warning: {feature_path} not found. Using default feature order.")
        feature_order = ['PM2.5', 'PM10', 'NO2', 'CO']

def predict_aqi(pm25, pm10, no2, co):
    """
    Predict AQI using the model
    If model not available, use a weighted formula approximation
    """
    global model, feature_order
    
    if model is not None:
        try:
            # Prepare input based on feature order
            if feature_order:
                feature_map = {
                    'PM2.5': pm25, 'PM10': pm10, 
                    'NO2': no2, 'CO': co
                }
                input_data = np.array([[feature_map.get(f, 0) for f in feature_order]])
            else:
                input_data = np.array([[pm25, pm10, no2, co]])
            
            prediction = model.predict(input_data)[0]
            # Clamp prediction to valid AQI range (0-500)
            prediction = max(0, min(500, float(prediction)))
            return prediction
        except Exception as e:
            print(f"Model prediction error: {e}")
    
    # Fallback: Use weighted formula approximation based on AQI sub-indices
    # PM2.5 typically dominates AQI in urban areas
    pm25_aqi = pm25 * 2.0  # PM2.5 contribution
    pm10_aqi = pm10 * 0.8  # PM10 contribution (less than PM2.5)
    no2_aqi = no2 * 0.6    # NO2 contribution
    co_aqi = co * 15       # CO contribution (CO is in mg/m³, scale up)
    
    # Take the maximum (standard AQI calculation principle)
    aqi = max(pm25_aqi, pm10_aqi, no2_aqi, co_aqi)
    return max(0, min(500, aqi))  # Clamp between 0-500

def get_aqi_category(aqi):
    """Return AQI category and color"""
    if aqi <= 50:
        return {'category': 'Good', 'color': 'green', 'message': 'Safe for outdoor activity'}
    elif aqi <= 100:
        return {'category': 'Moderate', 'color': 'yellow', 'message': 'Generally acceptable air quality'}
    elif aqi <= 200:
        return {'category': 'Poor', 'color': 'orange', 'message': 'Sensitive groups should limit outdoor exposure'}
    elif aqi <= 300:
        return {'category': 'Unhealthy', 'color': 'red', 'message': 'Everyone should reduce outdoor exposure'}
    else:
        return {'category': 'Severe', 'color': 'purple', 'message': 'Avoid outdoor exposure'}

@app.route('/predict-today', methods=['GET'])
def predict_today():
    """Get AQI prediction for today"""
    try:
        # Default/sample pollution values for Delhi (moderate pollution)
        pm25 = float(request.args.get('pm25', 65.0))
        pm10 = float(request.args.get('pm10', 110.0))
        no2 = float(request.args.get('no2', 35.0))
        co = float(request.args.get('co', 1.8))
        
        today = date.today()
        
        # Predict AQI
        aqi = predict_aqi(pm25, pm10, no2, co)
        
        # Store prediction
        prediction = AQIPrediction(
            input_date=today,
            pm25=pm25,
            pm10=pm10,
            no2=no2,
            co=co,
            predicted_aqi=aqi
        )
        db.session.add(prediction)
        db.session.commit()
        
        # Get category info
        category_info = get_aqi_category(aqi)
        
        return jsonify({
            'success': True,
            'date': today.isoformat(),
            'aqi': round(aqi, 2),
            'pollutants': {
                'pm25': pm25,
                'pm10': pm10,
                'no2': no2,
                'co': co
            },
            'category': category_info['category'],
            'color': category_info['color'],
            'health_message': category_info['message']
        })
    
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/predict-range', methods=['POST'])
def predict_range():
    """Get AQI predictions for a date range"""
    try:
        data = request.get_json()
        
        start_date = datetime.strptime(data['start_date'], '%Y-%m-%d').date()
        end_date = datetime.strptime(data['end_date'], '%Y-%m-%d').date()
        
        # Get pollutant values (use defaults if not provided)
        pm25 = float(data.get('pm25', 65.0))
        pm10 = float(data.get('pm10', 110.0))
        no2 = float(data.get('no2', 35.0))
        co = float(data.get('co', 1.8))
        
        predictions = []
        current_date = start_date
        total_aqi = 0
        max_aqi = 0
        worst_day = None
        
        while current_date <= end_date:
            # Add some variation for different dates (simulate realistic changes)
            variation = np.random.uniform(0.85, 1.15)
            daily_pm25 = pm25 * variation
            daily_pm10 = pm10 * variation
            daily_no2 = no2 * variation
            daily_co = co * variation
            
            # Predict AQI
            aqi = predict_aqi(daily_pm25, daily_pm10, daily_no2, daily_co)
            
            # Store prediction
            prediction = AQIPrediction(
                input_date=current_date,
                pm25=daily_pm25,
                pm10=daily_pm10,
                no2=daily_no2,
                co=daily_co,
                predicted_aqi=aqi
            )
            db.session.add(prediction)
            
            # Track statistics
            total_aqi += aqi
            if aqi > max_aqi:
                max_aqi = aqi
                worst_day = current_date
            
            category_info = get_aqi_category(aqi)
            
            predictions.append({
                'date': current_date.isoformat(),
                'aqi': round(aqi, 2),
                'category': category_info['category'],
                'color': category_info['color']
            })
            
            current_date += timedelta(days=1)
        
        db.session.commit()
        
        # Calculate statistics
        avg_aqi = total_aqi / len(predictions) if predictions else 0
        
        return jsonify({
            'success': True,
            'predictions': predictions,
            'statistics': {
                'average_aqi': round(avg_aqi, 2),
                'max_aqi': round(max_aqi, 2),
                'worst_day': worst_day.isoformat() if worst_day else None,
                'total_days': len(predictions)
            }
        })
    
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/history', methods=['GET'])
def get_history():
    """Get recent prediction history"""
    try:
        limit = int(request.args.get('limit', 20))
        
        predictions = AQIPrediction.query\
            .order_by(AQIPrediction.timestamp.desc())\
            .limit(limit)\
            .all()
        
        history = []
        for pred in predictions:
            category_info = get_aqi_category(pred.predicted_aqi)
            history.append({
                **pred.to_dict(),
                'category': category_info['category'],
                'color': category_info['color']
            })
        
        return jsonify({
            'success': True,
            'history': history
        })
    
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/weather', methods=['GET'])
def get_weather():
    """Get current weather data from OpenWeatherMap API"""
    try:
        # Use OpenWeatherMap free API
        API_KEY = os.getenv('OPENWEATHER_API_KEY', 'demo')  # Use environment variable or 'demo'
        CITY = 'Delhi'
        
        if API_KEY == 'demo':
            # Return demo weather data if no API key is set
            return jsonify({
                'success': True,
                'weather': {
                    'temperature': 28.5,
                    'feels_like': 30.2,
                    'humidity': 65,
                    'wind_speed': 3.5,
                    'description': 'Hazy',
                    'icon': '50d',
                    'pressure': 1013,
                    'visibility': 4000
                },
                'message': 'Using demo data. Set OPENWEATHER_API_KEY environment variable for live data.'
            })
        
        # Make API request to OpenWeatherMap
        url = f'https://api.openweathermap.org/data/2.5/weather?q={CITY}&appid={API_KEY}&units=metric'
        response = requests.get(url, timeout=5)
        
        if response.status_code == 200:
            data = response.json()
            weather_data = {
                'temperature': data['main']['temp'],
                'feels_like': data['main']['feels_like'],
                'humidity': data['main']['humidity'],
                'wind_speed': data['wind']['speed'],
                'description': data['weather'][0]['description'].title(),
                'icon': data['weather'][0]['icon'],
                'pressure': data['main']['pressure'],
                'visibility': data.get('visibility', 10000)
            }
            
            return jsonify({
                'success': True,
                'weather': weather_data
            })
        else:
            return jsonify({
                'success': False,
                'error': 'Failed to fetch weather data'
            }), response.status_code
    
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/health', methods=['GET'])
def health_check():
    """Health check endpoint"""
    return jsonify({
        'status': 'healthy',
        'model_loaded': model is not None,
        'timestamp': datetime.utcnow().isoformat()
    })

def init_database():
    """Initialize database"""
    with app.app_context():
        db.create_all()
        print("✓ Database initialized")

if __name__ == '__main__':
    load_model()
    init_database()
    port = int(os.environ.get('PORT', 5000))
    print(f"\n🚀 Flask server starting on port {port}")
    print("📊 API Endpoints:")
    print("   GET  /predict-today")
    print("   POST /predict-range")
    print("   GET  /history")
    print("   GET  /weather")
    print("   GET  /health\n")
    app.run(debug=os.environ.get('FLASK_ENV') != 'production', host='0.0.0.0', port=port)

# For production (Gunicorn)
load_model()
init_database()
