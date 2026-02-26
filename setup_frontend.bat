@echo off
echo ========================================
echo  AQI Forecast Platform - Frontend Setup
echo ========================================
echo.

cd frontend

echo Installing dependencies (this may take a few minutes)...
call npm install
if %errorlevel% neq 0 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo.
echo ========================================
echo   Frontend Setup Complete!
echo ========================================
echo.
echo Next step:
echo Run start_frontend.bat to start the React app
echo.
pause
