"""
Verify Backend Dependencies Installation
Run this to check if all required packages are installed correctly
"""

import sys

def check_python_version():
    """Check Python version"""
    version = sys.version_info
    print(f"🐍 Python Version: {version.major}.{version.minor}.{version.micro}")
    
    if version.major >= 3 and version.minor >= 8:
        print("   ✅ Python version is compatible (3.8+)")
        return True
    else:
        print("   ❌ Python 3.8+ required")
        return False

def check_package(package_name, import_name=None):
    """Check if a package is installed"""
    if import_name is None:
        import_name = package_name
    
    try:
        __import__(import_name)
        print(f"   ✅ {package_name}")
        return True
    except ImportError:
        print(f"   ❌ {package_name} - NOT INSTALLED")
        return False

def main():
    print("=" * 60)
    print("   🔍 Backend Dependencies Verification")
    print("=" * 60)
    print()
    
    # Check Python version
    python_ok = check_python_version()
    print()
    
    # Check required packages
    print("📦 Required Packages:")
    required_packages = [
        ('Flask', 'flask'),
        ('Flask-SQLAlchemy', 'flask_sqlalchemy'),
        ('Flask-CORS', 'flask_cors'),
        ('NumPy', 'numpy'),
        ('scikit-learn', 'sklearn'),
        ('XGBoost', 'xgboost'),
        ('pandas', 'pandas'),
    ]
    
    all_ok = True
    for package, import_name in required_packages:
        if not check_package(package, import_name):
            all_ok = False
    
    print()
    
    # Check optional packages
    print("📚 Optional Packages (for notebook training):")
    optional_packages = [
        ('Jupyter', 'jupyter'),
        ('matplotlib', 'matplotlib'),
        ('seaborn', 'seaborn'),
    ]
    
    for package, import_name in optional_packages:
        check_package(package, import_name)
    
    print()
    
    # Check model files
    print("📁 Model Files:")
    import os
    
    model_file = 'delhi_aqi_xgb.pkl'
    feature_file = 'feature_order.pkl'
    
    if os.path.exists(model_file):
        size = os.path.getsize(model_file) / 1024  # KB
        print(f"   ✅ {model_file} ({size:.1f} KB)")
    else:
        print(f"   ⚠️  {model_file} - NOT FOUND")
        print("      Create it: Run last 2 cells in AQI_Foracting_Delhi (1).ipynb")
    
    if os.path.exists(feature_file):
        print(f"   ✅ {feature_file}")
    else:
        print(f"   ⚠️  {feature_file} - NOT FOUND")
    
    print()
    print("=" * 60)
    
    if python_ok and all_ok:
        print("   🎉 All required dependencies are installed!")
        print("   ✅ Backend is ready to run: python app.py")
    else:
        print("   ⚠️  Some dependencies are missing")
        print("   📝 Install them: pip install -r requirements.txt")
    
    print("=" * 60)

if __name__ == '__main__':
    main()
