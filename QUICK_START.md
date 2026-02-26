# 🚀 QUICK START GUIDE

## For First-Time Users

### 1️⃣ Setup Backend (5 minutes)

Open **Command Prompt** or **PowerShell**:

```bash
# Navigate to backend
cd e:\AirPollution\backend

# Create virtual environment
python -m venv venv

# Activate it (Windows)
venv\Scripts\activate

# Install everything
pip install -r requirements.txt

# Create the ML model from your notebook
# Open: AQI_Foracting_Delhi (1).ipynb
# Run the last 2 Python cells to save model files
```

### 2️⃣ Setup Frontend (5 minutes)

Open a **NEW** terminal:

```bash
# Navigate to frontend
cd e:\AirPollution\frontend

# Install packages (this takes a few minutes)
npm install
```

### 3️⃣ Run the Application

**Terminal 1 - Backend:**
```bash
cd e:\AirPollution\backend
venv\Scripts\activate
python app.py
```

Wait for: `🚀 Flask server starting on http://localhost:5000`

**Terminal 2 - Frontend:**
```bash
cd e:\AirPollution\frontend
npm start
```

Browser will auto-open to `http://localhost:3000` 🎉

---

## ⚡ Super Quick Test

After both servers start:

1. ✅ Dashboard loads with today's AQI automatically
2. ✅ Adjust pollutant sliders and click "Predict AQI"
3. ✅ Select date range and click "Forecast"
4. ✅ See chart and statistics appear
5. ✅ Check history table at bottom

---

## 🎯 For Hackathon Demo

### Opening Line:
*"This is an AI-powered environmental intelligence platform that predicts air quality using machine learning."*

### Demo Flow:
1. **Show auto-prediction** - "On load, it instantly shows today's AQI"
2. **Adjust inputs** - "Users can customize pollutant values"
3. **Date range** - "Forecast trends over any date range"
4. **Health info** - "Provides actionable health recommendations"
5. **History** - "All predictions are stored and tracked"

### Tech Stack Highlight:
- "Backend: Python Flask with SQLAlchemy ORM"
- "Frontend: Modern React with Recharts visualization"
- "ML Model: XGBoost for accurate predictions"
- "Database: SQLite for lightweight storage"

---

## 🔥 Common Issues & Fixes

### ❌ "pip not found"
**Fix:** Ensure Python is installed and in PATH

### ❌ "npm not found"
**Fix:** Install Node.js from nodejs.org

### ❌ Port 5000 already in use
**Fix:** Change port in `backend/app.py` line: `app.run(debug=True, port=5001)`

### ❌ Frontend can't connect
**Fix:** Ensure backend is running first, check http://localhost:5000/health

---

## 💡 Tips for Impressive Demo

1. **Pre-load data** - Run a few predictions before demo
2. **Use realistic values** - PM2.5: 80-200, PM10: 150-300
3. **Show date range** - Pick 7-14 days for best chart
4. **Highlight UI** - Mention gradients, animations, responsive design
5. **Explain ML** - "Model trained on Delhi air quality patterns"

---

## 📸 Screenshot Points

- Dashboard on load (Today's AQI)
- Pollutant input sliders
- Date range chart
- Health recommendations
- History table

---

**Ready to impress! 🌍✨**
