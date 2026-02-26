# Weather API Setup Guide

## Overview
The application now includes weather information using the **OpenWeatherMap API** (free tier).

## Features Added
- Real-time weather data for Delhi
- Temperature, humidity, wind speed, visibility
- Weather icons and descriptions
- Auto-refresh every 30 minutes

## Setup Instructions

### Option 1: Use Demo Data (No Setup Required)
The application will automatically use demo weather data if no API key is configured.

### Option 2: Get Live Weather Data (Recommended)

1. **Sign up for OpenWeatherMap** (Free):
   - Visit: https://openweathermap.org/api
   - Click "Sign Up" and create a free account
   - Go to "API keys" section in your profile
   - Copy your API key

2. **Set Environment Variable**:
   
   **Windows (Command Prompt):**
   ```cmd
   set OPENWEATHER_API_KEY=your_api_key_here
   python app.py
   ```
   
   **Windows (PowerShell):**
   ```powershell
   $env:OPENWEATHER_API_KEY="your_api_key_here"
   python app.py
   ```
   
   **Linux/Mac:**
   ```bash
   export OPENWEATHER_API_KEY=your_api_key_here
   python app.py
   ```

3. **Or Create a .env file** (Recommended for permanent setup):
   - Create a file named `.env` in the `backend` folder
   - Add: `OPENWEATHER_API_KEY=your_api_key_here`
   - Install python-dotenv: `pip install python-dotenv`
   - The API key will be loaded automatically

## Free Tier Limits
- **60 calls/minute**
- **1,000,000 calls/month**
- More than enough for this application!

## API Endpoint
- **GET** `/weather` - Returns current weather data for Delhi

## Response Format
```json
{
  "success": true,
  "weather": {
    "temperature": 28.5,
    "feels_like": 30.2,
    "humidity": 65,
    "wind_speed": 3.5,
    "description": "Hazy",
    "icon": "50d",
    "pressure": 1013,
    "visibility": 4000
  }
}
```

## Troubleshooting
- If you see "Using demo data" message, it means no API key is set
- API keys can take 10-15 minutes to activate after signup
- Check your API key is correctly set in environment variables
