@echo off
echo ========================================
echo   Starting Flask Backend Server
echo ========================================
echo.

cd backend
call venv\Scripts\activate.bat
python app.py

pause
