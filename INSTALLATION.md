# 📦 Complete Installation Guide

This guide covers all dependencies for both **running the application** and **training the model**.

---

## 🎯 Quick Install (Just to Run the App)

If you just want to run the pre-built application:

### Backend:
```bash
cd backend
python -m venv venv
venv\Scripts\activate  # Windows
pip install -r requirements.txt
```

### Frontend:
```bash
cd frontend
npm install
```

---

## 🧪 Full Install (Including Model Training)

If you want to train the model yourself from the notebook:

### Backend + Notebook Training:
```bash
cd backend
python -m venv venv
venv\Scripts\activate  # Windows

# Install backend dependencies
pip install -r requirements.txt

# Install notebook training dependencies
pip install -r requirements-notebook.txt
```

### Frontend:
```bash
cd frontend
npm install
```

---

## 📋 Requirements Files Explained

### `backend/requirements.txt`
**Purpose:** Run the Flask API server  
**Contains:**
- Flask web framework
- Database (SQLAlchemy)
- CORS handling
- XGBoost model loading
- NumPy for predictions

**When to use:** Always needed to run the backend server

---

### `backend/requirements-notebook.txt`
**Purpose:** Train ML model in Jupyter notebook  
**Contains:**
- Jupyter notebook environment
- Data analysis (pandas, matplotlib, seaborn)
- Machine learning (scikit-learn, XGBoost)
- Statistical modeling

**When to use:** Only if you want to:
- Open `AQI_Foracting_Delhi (1).ipynb`
- Retrain the model with new data
- Experiment with model parameters

---

### `frontend/package.json`
**Purpose:** React dashboard dependencies  
**Contains:**
- React framework
- Chart visualization (Recharts)
- API calls (Axios)
- Date picker components

**When to use:** Always needed for frontend

---

## 🚀 Recommended Installation Order

### For First-Time Setup:

1. **Backend environment:**
   ```bash
   cd backend
   python -m venv venv
   venv\Scripts\activate
   pip install -r requirements.txt
   ```

2. **Create model files from notebook:**
   ```bash
   # Only if training the model
   pip install -r requirements-notebook.txt
   jupyter notebook AQI_Foracting_Delhi\ (1).ipynb
   # Run last 2 cells to create model files
   ```

3. **Frontend setup:**
   ```bash
   cd frontend
   npm install
   ```

---

## ✅ Verify Installation

### Backend:
```bash
cd backend
venv\Scripts\activate
python -c "import flask, xgboost, numpy; print('✓ All imports successful')"
```

### Frontend:
```bash
cd frontend
npm list react axios recharts
```

---

## 🐛 Common Issues

### "No module named 'xgboost'"
```bash
pip install xgboost==1.7.6
```

### "npm install fails"
```bash
rm -rf node_modules package-lock.json
npm install
```

### "Python version error"
Requires Python 3.8 or higher:
```bash
python --version
```

### "Node version error"
Requires Node.js 14 or higher:
```bash
node --version
```

---

## 💡 Development vs Production

### Development (Current Setup):
- Uses development servers
- Debug mode enabled
- Not optimized for production

### Production Deployment:
Would need additional packages:
- **Backend:** gunicorn, python-dotenv
- **Frontend:** Build files (npm run build)

---

## 🔄 Updating Dependencies

### Backend:
```bash
pip install --upgrade -r requirements.txt
```

### Frontend:
```bash
npm update
```

---

## 📊 Disk Space Requirements

- **Backend venv:** ~500 MB
- **Frontend node_modules:** ~300 MB
- **Notebook dependencies:** ~200 MB additional
- **Total:** ~1 GB

---

**Need help?** Check [README.md](README.md) for troubleshooting or [QUICK_START.md](QUICK_START.md) for fastest setup.
