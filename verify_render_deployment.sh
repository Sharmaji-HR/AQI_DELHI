#!/bin/bash

# Render Deployment Verification Script
# This script verifies that all files and configurations are ready for Render deployment

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║        Render Deployment Verification Script                  ║"
echo "║        AQI Forecast Platform                                   ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Track errors
ERRORS=0
WARNINGS=0

echo "📋 Checking Backend Files..."
echo "─────────────────────────────────────────────────────────────────"

# Check if backend directory exists
if [ -d "backend" ]; then
    echo -e "${GREEN}✓${NC} backend/ directory found"
else
    echo -e "${RED}✗${NC} backend/ directory NOT found"
    ERRORS=$((ERRORS + 1))
    exit 1
fi

cd backend

# Check Procfile
if [ -f "Procfile" ]; then
    echo -e "${GREEN}✓${NC} Procfile exists"
    if grep -q "gunicorn app:app" Procfile; then
        echo -e "${GREEN}  ✓${NC} Procfile contains correct command"
    else
        echo -e "${RED}  ✗${NC} Procfile does not contain 'gunicorn app:app'"
        ERRORS=$((ERRORS + 1))
    fi
else
    echo -e "${RED}✗${NC} Procfile NOT found"
    ERRORS=$((ERRORS + 1))
fi

# Check runtime.txt
if [ -f "runtime.txt" ]; then
    echo -e "${GREEN}✓${NC} runtime.txt exists"
    PYTHON_VERSION=$(cat runtime.txt)
    echo -e "  ${BLUE}→${NC} Python version: $PYTHON_VERSION"
else
    echo -e "${RED}✗${NC} runtime.txt NOT found"
    ERRORS=$((ERRORS + 1))
fi

# Check requirements.txt
if [ -f "requirements.txt" ]; then
    echo -e "${GREEN}✓${NC} requirements.txt exists"
    
    # Check for gunicorn
    if grep -q "gunicorn" requirements.txt; then
        GUNICORN_VERSION=$(grep "gunicorn" requirements.txt)
        echo -e "${GREEN}  ✓${NC} gunicorn found: $GUNICORN_VERSION"
        
        # Check if it's version 22.0.0 or higher (security fix)
        if grep -q "gunicorn==22.0.0\|gunicorn>=22" requirements.txt; then
            echo -e "${GREEN}    ✓${NC} Using secure gunicorn version (22.0.0+)"
        else
            echo -e "${YELLOW}    ⚠${NC} Consider upgrading gunicorn to 22.0.0+ for security"
            WARNINGS=$((WARNINGS + 1))
        fi
    else
        echo -e "${RED}  ✗${NC} gunicorn NOT found in requirements.txt"
        ERRORS=$((ERRORS + 1))
    fi
    
    # Check for Flask
    if grep -q "Flask" requirements.txt; then
        echo -e "${GREEN}  ✓${NC} Flask found"
    else
        echo -e "${RED}  ✗${NC} Flask NOT found"
        ERRORS=$((ERRORS + 1))
    fi
    
    # Check for ML dependencies
    if grep -q "numpy\|scikit-learn\|xgboost" requirements.txt; then
        echo -e "${GREEN}  ✓${NC} ML dependencies found"
    else
        echo -e "${YELLOW}  ⚠${NC} ML dependencies missing (app may use fallback)"
        WARNINGS=$((WARNINGS + 1))
    fi
else
    echo -e "${RED}✗${NC} requirements.txt NOT found"
    ERRORS=$((ERRORS + 1))
fi

# Check render.yaml
if [ -f "render.yaml" ]; then
    echo -e "${GREEN}✓${NC} render.yaml exists (optional but recommended)"
else
    echo -e "${YELLOW}⚠${NC} render.yaml NOT found (optional)"
fi

# Check app.py
if [ -f "app.py" ]; then
    echo -e "${GREEN}✓${NC} app.py exists"
    
    # Check for Flask app initialization
    if grep -q "app = Flask" app.py; then
        echo -e "${GREEN}  ✓${NC} Flask app initialized"
    else
        echo -e "${RED}  ✗${NC} Flask app initialization not found"
        ERRORS=$((ERRORS + 1))
    fi
    
    # Check for CORS configuration
    if grep -q "CORS\|cors" app.py; then
        echo -e "${GREEN}  ✓${NC} CORS configured"
    else
        echo -e "${YELLOW}  ⚠${NC} CORS not configured (may cause frontend issues)"
        WARNINGS=$((WARNINGS + 1))
    fi
else
    echo -e "${RED}✗${NC} app.py NOT found"
    ERRORS=$((ERRORS + 1))
fi

# Check .env.example
if [ -f ".env.example" ]; then
    echo -e "${GREEN}✓${NC} .env.example exists"
else
    echo -e "${YELLOW}⚠${NC} .env.example NOT found (recommended for documentation)"
    WARNINGS=$((WARNINGS + 1))
fi

# Check .gitignore
cd ..
if [ -f ".gitignore" ]; then
    echo -e "${GREEN}✓${NC} .gitignore exists"
    if grep -q ".env" .gitignore; then
        echo -e "${GREEN}  ✓${NC} .env files are ignored"
    else
        echo -e "${YELLOW}  ⚠${NC} .env files should be in .gitignore"
        WARNINGS=$((WARNINGS + 1))
    fi
else
    echo -e "${YELLOW}⚠${NC} .gitignore NOT found"
    WARNINGS=$((WARNINGS + 1))
fi

echo ""
echo "📝 Checking Documentation..."
echo "─────────────────────────────────────────────────────────────────"

# Check deployment documentation
if [ -f "DEPLOYMENT.md" ] || [ -f "README.md" ]; then
    echo -e "${GREEN}✓${NC} Deployment documentation found"
else
    echo -e "${YELLOW}⚠${NC} Consider adding deployment documentation"
    WARNINGS=$((WARNINGS + 1))
fi

echo ""
echo "🔍 Python Environment Check..."
echo "─────────────────────────────────────────────────────────────────"

# Check Python version
if command -v python3 &> /dev/null; then
    PYTHON_VER=$(python3 --version 2>&1)
    echo -e "${GREEN}✓${NC} Python installed: $PYTHON_VER"
else
    echo -e "${RED}✗${NC} Python3 not found"
    ERRORS=$((ERRORS + 1))
fi

# Check pip
if command -v pip3 &> /dev/null; then
    echo -e "${GREEN}✓${NC} pip3 installed"
else
    echo -e "${YELLOW}⚠${NC} pip3 not found (needed for local testing)"
    WARNINGS=$((WARNINGS + 1))
fi

echo ""
echo "═══════════════════════════════════════════════════════════════"
echo "                    VERIFICATION SUMMARY"
echo "═══════════════════════════════════════════════════════════════"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    echo -e "${GREEN}🎉 PERFECT!${NC} All checks passed!"
    echo ""
    echo "✅ Your application is ready for Render deployment!"
    echo ""
    echo "Next steps:"
    echo "1. Commit and push your code to GitHub"
    echo "2. Go to https://dashboard.render.com/"
    echo "3. Create a new Web Service"
    echo "4. Connect your GitHub repository"
    echo "5. Set root directory to 'backend'"
    echo "6. Add environment variables (FLASK_ENV, FRONTEND_URL)"
    echo "7. Deploy!"
    echo ""
    echo "📖 See RENDER_DEPLOYMENT.md for detailed instructions"
    exit 0
elif [ $ERRORS -eq 0 ]; then
    echo -e "${YELLOW}⚠ WARNINGS:${NC} $WARNINGS warning(s) found"
    echo ""
    echo "Your application can be deployed, but review the warnings above."
    echo "These are optional improvements that may enhance your deployment."
    exit 0
else
    echo -e "${RED}✗ ERRORS:${NC} $ERRORS error(s) found"
    if [ $WARNINGS -gt 0 ]; then
        echo -e "${YELLOW}⚠ WARNINGS:${NC} $WARNINGS warning(s) found"
    fi
    echo ""
    echo "Please fix the errors above before deploying to Render."
    echo "Review the output and make necessary corrections."
    exit 1
fi
