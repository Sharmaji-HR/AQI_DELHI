@echo off
REM Deployment Readiness Script for Windows
REM Checks if all files are ready for deployment

echo 🔍 Checking Deployment Readiness...
echo.

REM Backend Checks
echo 📦 BACKEND CHECKS
echo ==================
echo.

cd backend

if exist "Procfile" (echo ✅ Procfile) else (echo ❌ Procfile - MISSING)
if exist "runtime.txt" (echo ✅ runtime.txt) else (echo ❌ runtime.txt - MISSING)
if exist "requirements.txt" (echo ✅ requirements.txt) else (echo ❌ requirements.txt - MISSING)
if exist "render.yaml" (echo ✅ render.yaml) else (echo ❌ render.yaml - MISSING)
if exist ".env.example" (echo ✅ .env.example) else (echo ❌ .env.example - MISSING)
if exist "app.py" (echo ✅ app.py) else (echo ❌ app.py - MISSING)
if exist "models.py" (echo ✅ models.py) else (echo ❌ models.py - MISSING)

echo.
echo 🔍 Checking requirements.txt for gunicorn...
findstr /C:"gunicorn" requirements.txt >nul 2>&1
if %ERRORLEVEL% EQU 0 (echo ✅ gunicorn found in requirements.txt) else (echo ❌ gunicorn NOT found)

echo.
echo 🔍 Checking app.py for production config...
findstr /C:"os.environ.get('PORT'" app.py >nul 2>&1
if %ERRORLEVEL% EQU 0 (echo ✅ PORT environment variable configured) else (echo ❌ PORT NOT configured)

findstr /C:"FRONTEND_URL" app.py >nul 2>&1
if %ERRORLEVEL% EQU 0 (echo ✅ FRONTEND_URL for CORS configured) else (echo ❌ FRONTEND_URL NOT configured)

cd ..

REM Frontend Checks
echo.
echo 🌐 FRONTEND CHECKS
echo ==================
echo.

cd frontend

if exist "vercel.json" (echo ✅ vercel.json) else (echo ❌ vercel.json - MISSING)
if exist ".env.example" (echo ✅ .env.example) else (echo ❌ .env.example - MISSING)
if exist "package.json" (echo ✅ package.json) else (echo ❌ package.json - MISSING)

echo.
echo 🔍 Checking package.json for vercel-build...
findstr /C:"vercel-build" package.json >nul 2>&1
if %ERRORLEVEL% EQU 0 (echo ✅ vercel-build script found) else (echo ❌ vercel-build NOT found)

echo.
echo 🔍 Checking API configuration...
findstr /C:"process.env.REACT_APP_API_URL" src\services\api.js >nul 2>&1
if %ERRORLEVEL% EQU 0 (echo ✅ API URL using environment variable) else (echo ❌ API URL NOT using env var)

cd ..

echo.
echo 📋 DOCUMENTATION CHECKS
echo ======================
echo.

if exist "DEPLOYMENT.md" (echo ✅ DEPLOYMENT.md) else (echo ❌ DEPLOYMENT.md - MISSING)
if exist "DEPLOYMENT_CHECKLIST.md" (echo ✅ DEPLOYMENT_CHECKLIST.md) else (echo ❌ DEPLOYMENT_CHECKLIST.md - MISSING)
if exist ".gitignore" (echo ✅ .gitignore) else (echo ❌ .gitignore - MISSING)

echo.
echo ✨ Deployment Readiness Check Complete!
echo.
echo Next steps:
echo 1. Review DEPLOYMENT.md for detailed instructions
echo 2. Push code to GitHub
echo 3. Deploy backend on Render
echo 4. Deploy frontend on Vercel
echo 5. Set environment variables on both platforms
echo.

pause
