# Deployment Guide

## 🚀 AQI Forecast Platform Deployment

This guide will help you deploy the backend on Render and frontend on Vercel.

---

## 📦 Backend Deployment (Render)

### Prerequisites
- GitHub account
- Render account (free tier available)
- Your code pushed to GitHub

### Step 1: Prepare Backend Files
All necessary files are already created:
- ✅ `Procfile` - Gunicorn web server configuration
- ✅ `runtime.txt` - Python version specification
- ✅ `requirements.txt` - Python dependencies (includes gunicorn)
- ✅ `render.yaml` - Render configuration (optional)

### Step 2: Deploy on Render

1. **Go to Render Dashboard**
   - Visit: https://dashboard.render.com/
   - Click "New +" → "Web Service"

2. **Connect Your Repository**
   - Connect your GitHub account
   - Select your AQI Forecast repository
   - Give Render permission to access the repo

3. **Configure the Service**
   ```
   Name: aqi-forecast-backend
   Region: Oregon (US West) or closest to you
   Branch: main
   Root Directory: backend
   Environment: Python 3
   Build Command: pip install -r requirements.txt
   Start Command: gunicorn app:app
   ```

4. **Set Environment Variables**
   - Click "Advanced" → "Add Environment Variable"
   - Add these:
   ```
   FLASK_ENV=production
   FRONTEND_URL=https://your-vercel-app.vercel.app
   ```
   - Optional (for weather features):
   ```
   OPENWEATHER_API_KEY=your_api_key_here
   ```

5. **Deploy**
   - Click "Create Web Service"
   - Wait 5-10 minutes for first deployment
   - Your backend URL will be: `https://your-app-name.onrender.com`

6. **Test Your Backend**
   - Visit: `https://your-app-name.onrender.com/health`
   - Should return: `{"status": "healthy", ...}`

### Important Notes for Render:
- ⚠️ **Free tier sleeps after 15 minutes of inactivity**
- First request after sleep takes ~30 seconds to wake up
- Database: Using SQLite (sufficient for demos)
- For production: Consider PostgreSQL database addon

---

## 🌐 Frontend Deployment (Vercel)

### Prerequisites
- GitHub account
- Vercel account (free tier available)
- Backend deployed on Render

### Step 1: Prepare Frontend Files
All necessary files are already created:
- ✅ `vercel.json` - Vercel configuration
- ✅ `.env.example` - Environment variables template
- ✅ Updated `package.json` with vercel-build script
- ✅ Updated API calls to use environment variables

### Step 2: Deploy on Vercel

1. **Go to Vercel Dashboard**
   - Visit: https://vercel.com/dashboard
   - Click "Add New..." → "Project"

2. **Import Your Repository**
   - Click "Import Git Repository"
   - Select your AQI Forecast repository
   - Click "Import"

3. **Configure the Project**
   ```
   Framework Preset: Create React App
   Root Directory: frontend
   Build Command: npm run build
   Output Directory: build
   Install Command: npm install
   ```

4. **Set Environment Variables**
   - Expand "Environment Variables"
   - Add:
   ```
   Name: REACT_APP_API_URL
   Value: https://your-app-name.onrender.com
   ```
   (Use your actual Render backend URL)

5. **Deploy**
   - Click "Deploy"
   - Wait 2-5 minutes for build
   - Your frontend URL will be: `https://your-project.vercel.app`

6. **Update Backend CORS**
   - Go back to Render dashboard
   - Update `FRONTEND_URL` environment variable
   - Set it to: `https://your-project.vercel.app`
   - Backend will auto-redeploy

### Important Notes for Vercel:
- ✅ Auto-deploys on every git push
- ✅ Provides preview URLs for branches
- ✅ Custom domains supported (even on free tier)
- ✅ Global CDN for fast loading

---

## 🔄 Post-Deployment Checklist

### 1. Test Backend Endpoints
```bash
# Health check
curl https://your-app-name.onrender.com/health

# Today's prediction
curl https://your-app-name.onrender.com/predict-today

# Weather data
curl https://your-app-name.onrender.com/weather
```

### 2. Test Frontend
- Visit your Vercel URL
- Try predicting AQI with custom pollutant values
- Check 10-day forecast
- Verify all components load properly

### 3. CORS Issues?
If you see CORS errors:
1. Double-check `FRONTEND_URL` in Render environment variables
2. Make sure it matches your Vercel URL exactly (no trailing slash)
3. Restart Render service if needed

### 4. API Connection Issues?
If frontend can't connect to backend:
1. Check browser console for errors
2. Verify `REACT_APP_API_URL` in Vercel environment variables
3. Test backend health endpoint directly
4. Check Render logs for errors

---

## 🎯 Quick Deployment Commands

### Local Development
```bash
# Backend
cd backend
pip install -r requirements.txt
python app.py

# Frontend (new terminal)
cd frontend
npm install
npm start
```

### Production URLs
```
Backend:  https://your-app-name.onrender.com
Frontend: https://your-project.vercel.app
```

---

## 🔐 Environment Variables Summary

### Backend (.env)
```env
FLASK_ENV=production
PORT=5000
FRONTEND_URL=https://your-project.vercel.app
OPENWEATHER_API_KEY=optional_key
```

### Frontend (.env)
```env
REACT_APP_API_URL=https://your-app-name.onrender.com
```

---

## 📊 Model Files

⚠️ **Important**: The ML model files (`.pkl`) are large and should not be committed to git.

### For Deployment:
1. Train your model locally
2. Upload `.pkl` files directly to Render:
   - Go to Shell tab in Render dashboard
   - Use `curl` to download from cloud storage
   - Or manually upload via dashboard

### Alternative: Model as a Service
- Store models in AWS S3 / Google Cloud Storage
- Update `app.py` to download from cloud on startup
- Add credentials to Render environment variables

---

## 🐛 Troubleshooting

### Backend Issues

**Problem**: "Application failed to bind to $PORT"
- Solution: Check that `app.run(port=os.environ.get('PORT', 5000))` is set

**Problem**: "Model not found"
- Solution: Upload `.pkl` files to Render or use fallback formula

**Problem**: Database errors
- Solution: Render creates `database.db` automatically on first run

### Frontend Issues

**Problem**: Blank page after deployment
- Solution: Check Vercel build logs, ensure `build` folder is generated

**Problem**: API calls return 404
- Solution: Verify `REACT_APP_API_URL` is set correctly

**Problem**: CORS errors
- Solution: Add your Vercel URL to `FRONTEND_URL` in Render

---

## 📈 Performance Tips

1. **Backend (Render)**
   - Use persistent storage for database
   - Implement caching for predictions
   - Monitor logs for errors

2. **Frontend (Vercel)**
   - Images are auto-optimized
   - Code splitting enabled by default
   - Use Vercel Analytics (optional)

---

## 🎉 Success!

Once deployed:
- ✅ Backend API running on Render
- ✅ Frontend app running on Vercel
- ✅ CORS configured properly
- ✅ All features working

Share your deployed app with the world! 🌍

---

## 💡 Next Steps

1. **Custom Domain**
   - Add custom domain in Vercel settings
   - Update backend CORS accordingly

2. **Monitoring**
   - Set up Render alerts
   - Use Vercel Analytics

3. **Database Upgrade**
   - Consider PostgreSQL for production
   - Add Redis for caching

4. **CI/CD**
   - Both platforms auto-deploy on git push
   - Add GitHub Actions for tests (optional)

---

## 📞 Support

- Render Docs: https://render.com/docs
- Vercel Docs: https://vercel.com/docs
- GitHub Issues: [Your Repo]

---

**Made with ❤️ | AQI Forecast Platform 2024**
