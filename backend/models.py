from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

class AQIPrediction(db.Model):
    """Model for storing AQI predictions"""
    __tablename__ = 'aqi_predictions'
    
    id = db.Column(db.Integer, primary_key=True)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow, nullable=False)
    input_date = db.Column(db.Date, nullable=False)
    pm25 = db.Column(db.Float, nullable=False)
    pm10 = db.Column(db.Float, nullable=False)
    no2 = db.Column(db.Float, nullable=False)
    co = db.Column(db.Float, nullable=False)
    predicted_aqi = db.Column(db.Float, nullable=False)
    
    def to_dict(self):
        """Convert model instance to dictionary"""
        return {
            'id': self.id,
            'timestamp': self.timestamp.isoformat(),
            'input_date': self.input_date.isoformat(),
            'pm25': self.pm25,
            'pm10': self.pm10,
            'no2': self.no2,
            'co': self.co,
            'predicted_aqi': round(self.predicted_aqi, 2)
        }
    
    def __repr__(self):
        return f'<AQIPrediction {self.input_date}: {self.predicted_aqi}>'
