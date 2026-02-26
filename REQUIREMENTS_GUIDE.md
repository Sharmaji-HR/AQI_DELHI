# 🎯 Requirements Summary

## Backend (Flask API)

### `requirements.txt` - **REQUIRED**
Core dependencies to run the Flask server:

```txt
Flask==2.3.3           # Web framework
Flask-SQLAlchemy==3.0.5  # Database ORM
Flask-CORS==4.0.0      # CORS handling
numpy==1.24.3          # Numerical operations
scikit-learn==1.3.0    # ML utilities
xgboost==1.7.6         # Model loading
pandas==2.0.3          # Data handling
```

**Install:**
```bash
pip install -r requirements.txt
```

---

### `requirements-notebook.txt` - **OPTIONAL**
Additional packages for Jupyter notebook model training:

```txt
jupyter==1.0.0         # Notebook environment
matplotlib==3.7.2      # Plotting
seaborn==0.12.2        # Statistical visualization
statsmodels==0.14.0    # Time series analysis
```

**Install only if training model:**
```bash
pip install -r requirements-notebook.txt
```

---

## Frontend (React Dashboard)

### `package.json` - **REQUIRED**
All frontend dependencies:

```json
{
  "react": "^18.2.0",           // UI framework
  "react-dom": "^18.2.0",       // React rendering
  "axios": "^1.4.0",            // API calls
  "recharts": "^2.7.2",         // Charts
  "react-datepicker": "^4.16.0" // Date selection
}
```

**Install:**
```bash
npm install
```

---

## 📌 Which Requirements Do I Need?

### Scenario 1: Just Run the App
✅ `backend/requirements.txt`  
✅ `frontend/package.json`  
❌ `backend/requirements-notebook.txt` (skip)

### Scenario 2: Train Model + Run App
✅ `backend/requirements.txt`  
✅ `backend/requirements-notebook.txt`  
✅ `frontend/package.json`

### Scenario 3: Development/Hackathon Demo
✅ All files
- Allows full flexibility
- Can modify and retrain model
- Complete development environment

---

## ⚡ Quick Commands

### Complete Setup (Recommended):
```bash
# Backend
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt
pip install -r requirements-notebook.txt

# Frontend
cd frontend
npm install
```

### Minimal Setup (Just to run):
```bash
# Backend
cd backend
python -m venv venv
venv\Scripts\activate
pip install -r requirements.txt

# Frontend
cd frontend
npm install
```

---

## 🔍 Verify Installation

```bash
# Check Python packages
pip list | grep -E "(Flask|xgboost|numpy|pandas)"

# Check Node packages
npm list --depth=0
```

---

## 💾 Total Size
- Backend minimal: ~400 MB
- Backend full: ~600 MB
- Frontend: ~300 MB
- **Total: ~900 MB**

---

See [INSTALLATION.md](INSTALLATION.md) for detailed guide.
