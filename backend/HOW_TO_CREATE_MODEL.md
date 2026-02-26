# 🤖 How to Create Model Files

Your Flask backend needs 2 files to make accurate predictions:
- `delhi_aqi_xgb.pkl` (Trained XGBoost model)
- `feature_order.pkl` (Feature names in correct order)

## ✅ Create from Your Trained Model

You already have a trained model in your notebook! Just save it:

### Steps:

1. **Open the notebook:**
   - File: `backend/AQI_Foracting_Delhi (1).ipynb`

2. **Scroll to the bottom**
   - Find the section: **"Save Model for Flask Backend (Real-time Prediction)"**

3. **Run the last 2 Python cells:**
   - Cell 1: Trains simplified model (uses PM2.5, PM10, NO2, CO only)
   - Cell 2: Saves the model files

4. **Verify files created:**
   ```
   backend/
   ├── delhi_aqi_xgb.pkl     ✓ Created
   ├── feature_order.pkl     ✓ Created
   ```

5. **Restart Flask server:**
   ```bash
   python app.py
   ```

You should now see:
```
✓ Model loaded successfully
✓ Feature order loaded successfully
```

---

## 🎯 Why These Files?

- **delhi_aqi_xgb.pkl**: Your actual trained XGBoost model with real Delhi pollution data
- **feature_order.pkl**: Ensures features are passed in correct order (PM2.5, PM10, NO2, CO)

---

## 📊 Model Features

The saved model uses only **real-time available data**:
- PM2.5 (µg/m³)
- PM10 (µg/m³)
- NO2 (ppb)
- CO (ppm)

No historical data or lags needed - perfect for API predictions!

---

## ⚠️ If Files Don't Exist

The Flask backend will still work using a **fallback formula**, but predictions will be less accurate.

Always create the real model files for best results! 🌍
