# 🚀 Quick Deployment Reference

## Environment Variables

### Backend (Render)
```bash
FLASK_ENV=production
PORT=10000  # Auto-set by Render
FRONTEND_URL=https://your-vercel-app.vercel.app
OPENWEATHER_API_KEY=your_key_here  # Optional
```

### Frontend (Vercel)
```bash
REACT_APP_API_URL=https://your-render-app.onrender.com
```

---

## Deployment URLs

### Render (Backend)
- Dashboard: https://dashboard.render.com/
- Docs: https://render.com/docs

### Vercel (Frontend)
- Dashboard: https://vercel.com/dashboard
- Docs: https://vercel.com/docs

---

## Quick Commands

### Test Backend Locally with Production Config
```bash
cd backend
export FLASK_ENV=production
gunicorn app:app --bind 0.0.0.0:8000
```

### Test Frontend Build
```bash
cd frontend
npm run build
npx serve -s build
```

### Check Deployment Readiness
```bash
# Linux/Mac
chmod +x check_deployment.sh
./check_deployment.sh

# Windows
check_deployment.bat
```

---

## API Health Check

After deployment, test:
```bash
# Backend health
curl https://your-app.onrender.com/health

# Today's prediction
curl https://your-app.onrender.com/predict-today

# Should return JSON with AQI data
```

---

## Common Environment Variable Patterns

### Development (.env files)
```bash
# backend/.env
FLASK_ENV=development
FRONTEND_URL=http://localhost:3000

# frontend/.env
REACT_APP_API_URL=http://localhost:5000
```

### Production (Platform Settings)
```bash
# Render environment variables
FLASK_ENV=production
FRONTEND_URL=https://aqi-forecast.vercel.app

# Vercel environment variables
REACT_APP_API_URL=https://aqi-forecast-api.onrender.com
```

---

## Troubleshooting Quick Fixes

### CORS Error
```python
# Add to backend/app.py CORS config
FRONTEND_URL=https://your-exact-vercel-url.vercel.app
```

### API Connection Failed
```javascript
// Check frontend .env
REACT_APP_API_URL=https://your-backend.onrender.com
// No trailing slash!
```

### Build Failed (Frontend)
```bash
# Clear cache and rebuild
rm -rf node_modules package-lock.json
npm install
npm run build
```

### Build Failed (Backend)
```bash
# Check Python version
python --version  # Should be 3.11+

# Test requirements
pip install -r requirements.txt
```

---

## Deployment Checklist (Short Version)

- [ ] Push code to GitHub
- [ ] Create Render Web Service
- [ ] Set Render environment variables
- [ ] Wait for backend deploy (~5-10 min)
- [ ] Test: `curl https://your-backend.onrender.com/health`
- [ ] Create Vercel project
- [ ] Set Vercel environment variable
- [ ] Wait for frontend deploy (~2-3 min)
- [ ] Visit your Vercel URL
- [ ] Update backend FRONTEND_URL with Vercel URL
- [ ] Test full application

---

## Important Notes

⚠️ **Render Free Tier**: Backend sleeps after 15 minutes. First request after sleep takes 30-60 seconds.

✅ **Vercel**: Always active, no cold starts.

🔄 **Auto-Deploy**: Both platforms auto-deploy on git push to main branch.

📊 **Model Files**: Large `.pkl` files should be uploaded separately or hosted on cloud storage.

---

## Support Resources

- Render Status: https://status.render.com/
- Vercel Status: https://www.vercel-status.com/
- Project Issues: GitHub Issues tab

---

## Success Indicators

✅ Backend: Health endpoint returns `{"status": "healthy"}`
✅ Frontend: No console errors, all components load
✅ CORS: No CORS errors in browser console
✅ API: Predictions work correctly
✅ Database: History saves and displays

---

## Post-Deployment Tasks

1. Share deployed URL
2. Monitor logs for first 24 hours
3. Test on different devices
4. Set up custom domain (optional)
5. Enable analytics (optional)

---

**Last Updated**: 2024
**Deployment Ready**: ✅ YES
