# 🚀 Quick Render Deployment Guide

## Prerequisites
✅ GitHub account
✅ Render account (free tier: https://render.com)
✅ Code pushed to GitHub repository

## Deployment Steps (10 minutes)

### 1. Create Web Service on Render

1. Go to https://dashboard.render.com/
2. Click **"New +"** → **"Web Service"**
3. Click **"Connect GitHub"** (first time only)
4. Select your **AQI_DELHI** repository
5. Click **"Connect"**

### 2. Configure Service

Fill in the following settings:

```
Name: aqi-forecast-backend (or your preferred name)
Region: Oregon (US West) - or closest to your location
Branch: main
Root Directory: backend
Runtime: Python 3
Build Command: pip install -r requirements.txt
Start Command: gunicorn app:app
Instance Type: Free
```

### 3. Set Environment Variables

Click **"Advanced"** → **"Add Environment Variable"**

**Required:**
```
FLASK_ENV = production
FRONTEND_URL = (leave blank for now, update after frontend deployment)
```

**Optional (for weather features):**
```
OPENWEATHER_API_KEY = your_api_key_here
```

### 4. Deploy

1. Click **"Create Web Service"**
2. Wait 5-10 minutes for build to complete
3. Watch the logs for any errors

### 5. Test Your Backend

Once deployed, your backend URL will be:
```
https://your-service-name.onrender.com
```

Test the health endpoint:
```bash
curl https://your-service-name.onrender.com/health
```

Expected response:
```json
{
  "status": "healthy",
  "message": "Backend API is running"
}
```

### 6. Test Other Endpoints

```bash
# Today's AQI prediction
curl https://your-service-name.onrender.com/predict-today

# Weather data
curl https://your-service-name.onrender.com/weather
```

## ⚠️ Important Notes

### Free Tier Limitations
- **Sleeps after 15 minutes** of inactivity
- First request after sleep takes **30-60 seconds** to wake up
- **750 hours/month** of runtime (sufficient for demos)

### Database
- Uses **SQLite** by default (good for demos)
- For production, consider adding **PostgreSQL** addon

### Model Files
The ML model files (`.pkl`) are **NOT** in the repository (too large).

**Options:**
1. **Use fallback formula** (default behavior - works without model)
2. **Upload model files manually**:
   - Go to Shell tab in Render dashboard
   - Upload `delhi_aqi_xgb (1).pkl` and `feature_order.pkl`
3. **Use cloud storage**:
   - Store models in AWS S3 or Google Cloud Storage
   - Update app.py to download on startup

## 🔄 Updating CORS After Frontend Deployment

After deploying your frontend (e.g., on Vercel):

1. Go to Render dashboard
2. Select your web service
3. Go to **"Environment"** tab
4. Update **FRONTEND_URL** to your Vercel URL:
   ```
   FRONTEND_URL = https://your-app.vercel.app
   ```
5. Service will auto-redeploy (takes 2-3 minutes)

## 🐛 Troubleshooting

### Build Fails
- Check logs for specific error
- Verify `requirements.txt` is correct
- Ensure `runtime.txt` specifies valid Python version

### App Won't Start
- Check logs for port binding errors
- Verify `Procfile` has correct start command
- Test locally with: `gunicorn app:app`

### 502 Bad Gateway
- Service may be waking from sleep (wait 30-60 seconds)
- Check logs for application errors
- Verify environment variables are set

### CORS Errors
- Make sure `FRONTEND_URL` is set correctly
- No trailing slash in URL
- Must include `https://`

## ✅ Success Checklist

- [ ] Service deployed successfully
- [ ] Health endpoint returns 200
- [ ] Can access /predict-today endpoint
- [ ] No errors in Render logs
- [ ] Service URL saved for frontend configuration

## 📊 Monitoring

View real-time logs:
1. Go to Render dashboard
2. Select your service
3. Click **"Logs"** tab

Monitor metrics:
- CPU usage
- Memory usage
- Request count
- Response times

## 🔐 Security

✅ Environment variables stored securely
✅ HTTPS enabled by default
✅ No secrets in code
✅ CORS properly configured

## 💰 Cost

**Free Tier:**
- ✅ No credit card required
- ✅ 750 hours/month
- ✅ Sleeps after inactivity
- ✅ 512 MB RAM
- ✅ Perfect for demos

**Paid Plans:**
- Starter: $7/month
- No sleep
- Better performance
- More resources

## 🎉 Next Steps

1. ✅ Backend deployed on Render
2. 📝 Save your backend URL
3. 🌐 Deploy frontend on Vercel (see DEPLOYMENT.md)
4. 🔄 Update CORS settings
5. 🧪 Test full application

---

**Deployment Ready!** ✅

Your AQI Forecast backend is now running on Render with:
- ✅ Python 3.11+ compatible dependencies
- ✅ Gunicorn 22.0.0 (secure)
- ✅ Automatic HTTPS
- ✅ SQLite database
- ✅ Health monitoring
- ✅ Auto-deploy on git push

---

**Need Help?**
- Render Docs: https://render.com/docs
- Status Page: https://status.render.com
- Community: https://community.render.com
