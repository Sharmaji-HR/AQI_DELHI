# ✅ Render Deployment Quick Checklist

Use this checklist while deploying to Render.

## Pre-Deployment

- [ ] All code committed to GitHub
- [ ] Run `./verify_render_deployment.sh` - all checks pass
- [ ] Have Render account (sign up at https://render.com if needed)
- [ ] GitHub account connected to Render

## During Render Setup

### Step 1: Create Web Service
- [ ] Logged into Render dashboard
- [ ] Clicked "New +" → "Web Service"
- [ ] Selected GitHub repository: **AQI_DELHI**
- [ ] Clicked "Connect"

### Step 2: Configure Service
- [ ] **Name**: aqi-forecast-backend (or custom name)
- [ ] **Region**: Oregon (US West) or closest
- [ ] **Branch**: main
- [ ] **Root Directory**: backend
- [ ] **Environment**: Python 3
- [ ] **Build Command**: `pip install -r requirements.txt`
- [ ] **Start Command**: `gunicorn app:app`
- [ ] **Instance Type**: Free

### Step 3: Environment Variables
- [ ] Clicked "Advanced" → "Add Environment Variable"
- [ ] Added `FLASK_ENV` = `production`
- [ ] Added `FRONTEND_URL` = (leave empty for now, or add frontend URL if known)
- [ ] (Optional) Added `OPENWEATHER_API_KEY` = your_key

### Step 4: Deploy
- [ ] Clicked "Create Web Service"
- [ ] Watching logs for deployment progress
- [ ] Deployment completed successfully (5-10 minutes)

## Post-Deployment Verification

### Step 5: Test Backend
- [ ] Saved backend URL: `https://________.onrender.com`
- [ ] Tested health endpoint:
  ```bash
  curl https://your-backend.onrender.com/health
  ```
  Expected: `{"status": "healthy", ...}`
- [ ] Tested predict endpoint:
  ```bash
  curl https://your-backend.onrender.com/predict-today
  ```
- [ ] No errors in Render logs

### Step 6: Update Configuration
- [ ] Copied backend URL for frontend configuration
- [ ] Updated documentation with actual URL (optional)

## Common Issues & Quick Fixes

### If Build Fails
- [ ] Check Render logs for specific error
- [ ] Verify `requirements.txt` syntax
- [ ] Ensure `runtime.txt` has valid Python version
- [ ] Check that `backend/` directory structure is correct

### If App Won't Start
- [ ] Verify `Procfile` contains: `web: gunicorn app:app`
- [ ] Check logs for port binding errors
- [ ] Ensure environment variables are set correctly

### If Getting 502 Errors
- [ ] Wait 30-60 seconds (service may be waking from sleep)
- [ ] Check Render logs for application errors
- [ ] Verify app.py doesn't have syntax errors

## Success Criteria

Deployment is successful when:
- [ ] ✅ Service shows "Live" status in Render dashboard
- [ ] ✅ Health endpoint returns 200 OK
- [ ] ✅ Can access predict-today endpoint
- [ ] ✅ No errors in logs
- [ ] ✅ Backend URL saved for frontend deployment

## Next Steps After Backend Deployment

1. [ ] Deploy frontend on Vercel (see DEPLOYMENT.md)
2. [ ] Update `FRONTEND_URL` in Render with Vercel URL
3. [ ] Test complete application flow
4. [ ] Share your deployed app! 🎉

---

## Notes

**Free Tier Reminders:**
- ⚠️ Service sleeps after 15 minutes of inactivity
- ⏱️ First request after sleep: 30-60 seconds wake-up time
- ⏰ 750 hours/month runtime limit

**Auto-Deploy:**
- ✅ Render auto-deploys on every git push to main branch
- 🔄 Takes 5-10 minutes per deployment

**Model Files:**
- ℹ️ App uses fallback formula if .pkl files not uploaded
- 📤 Upload models manually via Render Shell if needed

---

**Deployment Date:** _______________
**Backend URL:** _______________
**Deployed By:** _______________

---

✅ = Completed
⏭️ = Next Step
⚠️ = Important Note
