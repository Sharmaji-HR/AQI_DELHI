@echo off
echo ========================================
echo   Verify Backend Installation
echo ========================================
echo.

cd backend

if not exist venv (
    echo ERROR: Virtual environment not found!
    echo Run setup_backend.bat first
    pause
    exit /b 1
)

call venv\Scripts\activate.bat
python verify_installation.py

pause
