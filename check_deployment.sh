#!/bin/bash

# Deployment Readiness Script
# Checks if all files are ready for deployment

echo "🔍 Checking Deployment Readiness..."
echo ""

# Backend Checks
echo "📦 BACKEND CHECKS"
echo "=================="

check_file() {
    if [ -f "$1" ]; then
        echo "✅ $1"
        return 0
    else
        echo "❌ $1 - MISSING"
        return 1
    fi
}

cd backend

check_file "Procfile"
check_file "runtime.txt"
check_file "requirements.txt"
check_file "render.yaml"
check_file ".env.example"
check_file "app.py"
check_file "models.py"

echo ""
echo "🔍 Checking requirements.txt for gunicorn..."
if grep -q "gunicorn" requirements.txt; then
    echo "✅ gunicorn found in requirements.txt"
else
    echo "❌ gunicorn NOT found in requirements.txt"
fi

echo ""
echo "🔍 Checking app.py for production config..."
if grep -q "os.environ.get('PORT'" app.py; then
    echo "✅ PORT environment variable configured"
else
    echo "❌ PORT environment variable NOT configured"
fi

if grep -q "FRONTEND_URL" app.py; then
    echo "✅ FRONTEND_URL for CORS configured"
else
    echo "❌ FRONTEND_URL for CORS NOT configured"
fi

cd ..

# Frontend Checks
echo ""
echo "🌐 FRONTEND CHECKS"
echo "=================="

cd frontend

check_file "vercel.json"
check_file ".env.example"
check_file "package.json"

echo ""
echo "🔍 Checking package.json for vercel-build..."
if grep -q "vercel-build" package.json; then
    echo "✅ vercel-build script found"
else
    echo "❌ vercel-build script NOT found"
fi

echo ""
echo "🔍 Checking API configuration..."
if grep -q "process.env.REACT_APP_API_URL" src/services/api.js; then
    echo "✅ API URL using environment variable"
else
    echo "❌ API URL NOT using environment variable"
fi

cd ..

echo ""
echo "📋 DOCUMENTATION CHECKS"
echo "======================"

check_file "DEPLOYMENT.md"
check_file "DEPLOYMENT_CHECKLIST.md"
check_file ".gitignore"

echo ""
echo "✨ Deployment Readiness Check Complete!"
echo ""
echo "Next steps:"
echo "1. Review DEPLOYMENT.md for detailed instructions"
echo "2. Push code to GitHub"
echo "3. Deploy backend on Render"
echo "4. Deploy frontend on Vercel"
echo "5. Set environment variables on both platforms"
echo ""
