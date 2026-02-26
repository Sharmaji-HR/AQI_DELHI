# 🌍 AI Air Quality Forecast Platform

A production-ready full-stack web application for predicting Air Quality Index (AQI) using machine learning. Built with Flask (backend) and React (frontend), this platform provides real-time AQI predictions and trend analysis for environmental intelligence.

![Platform Preview](https://img.shields.io/badge/Status-Ready-success)
![Python](https://img.shields.io/badge/Python-3.8+-blue)
![React](https://img.shields.io/badge/React-18.2-blue)
![Flask](https://img.shields.io/badge/Flask-2.3-green)

---

## 🎯 Key Features

### 🔮 **Instant Today's AQI Prediction**
- Automatic prediction on app load
- Real-time pollutant analysis
- Color-coded severity indicators
- Beautiful gradient display

### 📅 **Date Range Forecasting**
- Custom date range selection
- Multi-day trend visualization
- Statistical analysis (average, peak, worst day)
- Interactive charts

### 🧪 **Custom Pollutant Input**
- Adjustable PM2.5, PM10, NO2, CO values
- Real-time sliders
- Instant prediction updates

### 💚 **Health Recommendations**
- AQI-based health guidelines
- Activity recommendations
- Reference scale viewer

### 📜 **Prediction History**
- Persistent storage in SQLite
- Beautiful data table
- Recent predictions tracking

---

## 🏗️ Project Structure

```
AirPollution/
├── backend/
│   ├── app.py                    # Flask application
│   ├── models.py                 # SQLAlchemy models
│   ├── requirements.txt          # Python dependencies
│   ├── AQI_Foracting_Delhi (1).ipynb  # Your training notebook
│   ├── delhi_aqi_xgb.pkl        # ML model (created from notebook)
│   ├── feature_order.pkl        # Feature configuration
│   └── database.db              # SQLite database (auto-created)
│
└── frontend/
    ├── public/
    │   └── index.html
    ├── src/
    │   ├── components/
    │   │   ├── TodayAQI.js
    │   │   ├── DateRangeForecast.js
    │   │   ├── PollutantInput.js
    │   │   ├── HealthRecommendation.js
    │   │   └── HistorySection.js
    │   ├── services/
    │   │   └── api.js           # API integration layer
    │   ├── App.js
    │   ├── App.css
    │   └── index.js
    └── package.json
```

---

## 🚀 Installation & Setup

> 💡 **See [REQUIREMENTS_GUIDE.md](REQUIREMENTS_GUIDE.md) for detailed package information**  
> 📦 **See [INSTALLATION.md](INSTALLATION.md) for complete installation guide**

### **Prerequisites**

- Python 3.8 or higher
- Node.js 14 or higher
- npm or yarn

### **Step 1: Clone or Navigate to Project**

```bash
cd e:\AirPollution
```

### **Step 2: Backend Setup**

```bash
# Navigate to backend folder
cd backend

# Create virtual environment (recommended)
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On Mac/Linux:
# source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create model files from your trained notebook
# Open: AQI_Foracting_Delhi (1).ipynb
# Run the last 2 cells to save delhi_aqi_xgb.pkl and feature_order.pkl
```

### **Step 3: Frontend Setup**

```bash
# Navigate to frontend folder
cd ..\frontend

# Install dependencies
npm install
```

---

## ▶️ Running the Application

### **Terminal 1 - Start Backend Server**

```bash
cd backend
# Activate virtual environment if not already active
venv\Scripts\activate

# Run Flask server
python app.py
```

The backend will start on **http://localhost:5000**

You should see:
```
✓ Model loaded successfully
✓ Database initialized
🚀 Flask server starting on http://localhost:5000
```

### **Terminal 2 - Start Frontend Development Server**

```bash
cd frontend

# Start React app
npm start
```

The frontend will automatically open in your browser at **http://localhost:3000**

---

## 🎨 UI Features

### **Dashboard Components**

1. **Today's AQI Panel**
   - Large animated AQI display
   - Dynamic gradient backgrounds based on severity
   - Real-time pollutant values
   - Auto-loads on startup

2. **Pollutant Input Card**
   - Interactive sliders and inputs
   - PM2.5, PM10, NO2, CO controls
   - Instant prediction button

3. **Date Range Forecast**
   - Calendar date pickers
   - Beautiful area charts
   - Statistics cards (Average, Peak, Worst Day)
   - Multi-day trend analysis

4. **Health Recommendations**
   - Dynamic health messages
   - Activity guidelines
   - AQI reference scale
   - Color-coded warnings

5. **Prediction History**
   - Scrollable data table
   - Timestamp tracking
   - Color-coded categories
   - Recent predictions storage

---

## 🔌 API Endpoints

### **GET /predict-today**
Get AQI prediction for today

**Query Parameters:**
- `pm25` (optional): PM2.5 value
- `pm10` (optional): PM10 value
- `no2` (optional): NO2 value
- `co` (optional): CO value

**Response:**
```json
{
  "success": true,
  "date": "2024-02-16",
  "aqi": 156.8,
  "category": "Poor",
  "color": "orange",
  "health_message": "Sensitive groups should limit outdoor exposure",
  "pollutants": {
    "pm25": 85.5,
    "pm10": 150.2,
    "no2": 45.3,
    "co": 1.2
  }
}
```

### **POST /predict-range**
Get predictions for date range

**Request Body:**
```json
{
  "start_date": "2024-02-16",
  "end_date": "2024-02-23",
  "pm25": 85.5,
  "pm10": 150.2,
  "no2": 45.3,
  "co": 1.2
}
```

**Response:**
```json
{
  "success": true,
  "predictions": [...],
  "statistics": {
    "average_aqi": 158.3,
    "max_aqi": 189.5,
    "worst_day": "2024-02-19",
    "total_days": 8
  }
}
```

### **GET /history**
Get recent prediction history

**Query Parameters:**
- `limit` (optional): Number of records (default: 20)

**Response:**
```json
{
  "success": true,
  "history": [...]
}
```

### **GET /health**
Health check endpoint

---

## 🤖 Using Your Own ML Model

### **Create Model Files from Your Notebook**

You have a trained model in `AQI_Foracting_Delhi (1).ipynb`:

1. Open the notebook in Jupyter/VS Code
2. Run the **last 2 Python cells** (marked "Save Model for Flask Backend")
3. This creates `delhi_aqi_xgb.pkl` and `feature_order.pkl` in the backend folder
4. Start the Flask server - it will use your real trained model!

### **Model Requirements**

Your model should:
- Accept 4 features: PM2.5, PM10, NO2, CO
- Return AQI prediction (0-500 range)
- Be serialized with pickle

---

## 🎨 Customization

### **Change Color Schemes**

Edit the gradient colors in:
- `frontend/src/components/TodayAQI.css`
- `frontend/src/App.css`

### **Modify AQI Categories**

Update the category thresholds in:
- `backend/app.py` (function `get_aqi_category`)
- `frontend/src/components/HealthRecommendation.js`

### **Add More Pollutants**

1. Update the database model in `backend/models.py`
2. Modify prediction logic in `backend/app.py`
3. Update input form in `frontend/src/components/PollutantInput.js`

---

## 📦 Dependencies

### **Backend**
- Flask 2.3.3
- Flask-SQLAlchemy 3.0.5
- Flask-CORS 4.0.0
- NumPy 1.24.3
- scikit-learn 1.3.0
- XGBoost 1.7.6

### **Frontend**
- React 18.2.0
- Recharts 2.7.2
- Axios 1.4.0
- React-DatePicker 4.16.0

---

## 🐛 Troubleshooting

### **Backend won't start**
- Ensure all dependencies are installed: `pip install -r requirements.txt`
- Check if port 5000 is available
- Verify Python version (3.8+)

### **Frontend can't connect to backend**
- Ensure backend is running on http://localhost:5000
- Check CORS configuration in `backend/app.py`
- Verify API base URL in `frontend/src/services/api.js`

### **Model not loading**
- Open `AQI_Foracting_Delhi (1).ipynb` and run the last 2 cells to create model files
- Ensure `delhi_aqi_xgb.pkl` exists in backend folder
- Check file permissions

---

## 🏆 Hackathon Ready Features

✅ Professional UI with smooth animations  
✅ Real-time predictions  
✅ Interactive visualizations  
✅ Persistent data storage  
✅ RESTful API architecture  
✅ Responsive design  
✅ Production-quality code structure  
✅ Health-based recommendations  
✅ Historical data tracking  

---

## 📄 License

This project is open-source and available for educational and hackathon purposes.

---

## 🙏 Credits

Built with passion for environmental intelligence using:
- **Flask** - Backend framework
- **React** - Frontend framework
- **XGBoost** - Machine learning
- **Recharts** - Data visualization

---

## 📞 Support

For questions or issues:
1. Check the troubleshooting section
2. Verify all dependencies are installed
3. Ensure both servers are running

---

**Made with ❤️ for Hackathons | 2024**
