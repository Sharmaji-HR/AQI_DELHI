@echo off
echo ========================================
echo   AQI Forecast Platform - Backend Setup
echo ========================================
echo.

cd backend

echo [1/4] Creating virtual environment...
python -m venv venv
if %errorlevel% neq 0 (
    echo ERROR: Failed to create virtual environment
    pause
    exit /b 1
)

echo [2/4] Activating virtual environment...
call venv\Scripts\activate.bat

echo [3/4] Installing dependencies...
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Backend Setup Complete!
echo ========================================
echo.
echo IMPORTANT: Before starting the server, you need the ML model files!
echo.
echo To create them:
echo 1. Open: backend\AQI_Foracting_Delhi (1).ipynb
echo 2. Run the LAST 2 cells to save the trained model
echo 3. This creates: delhi_aqi_xgb.pkl and feature_order.pkl
echo.
echo Next steps:
echo 1. Create model files from notebook (see above)
echo 2. Run start_backend.bat to start the server
echo 3. Run setup_frontend.bat in another terminal
echo.
pause
