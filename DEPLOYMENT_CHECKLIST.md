# ✅ Pre-Deployment Checklist

## Backend (Render)

### Files Ready
- [x] `Procfile` - Created
- [x] `runtime.txt` - Python 3.11.0 specified
- [x] `requirements.txt` - Updated with gunicorn
- [x] `render.yaml` - Configuration ready
- [x] `.env.example` - Template created
- [x] CORS configured for production
- [x] Environment variable support added
- [x] Database configuration (SQLite/PostgreSQL)
- [x] Port binding from environment
- [x] Gunicorn integration

### Environment Variables to Set on Render
```
FLASK_ENV=production
FRONTEND_URL=https://your-app.vercel.app
PORT=10000
OPENWEATHER_API_KEY=optional
```

### Deployment Steps
1. Push code to GitHub
2. Create new Web Service on Render
3. Connect GitHub repository
4. Set root directory to `backend`
5. Add environment variables
6. Deploy

### Post-Deployment
- [ ] Test `/health` endpoint
- [ ] Test `/predict-today` endpoint
- [ ] Verify CORS headers
- [ ] Check logs for errors

---

## Frontend (Vercel)

### Files Ready
- [x] `vercel.json` - Created
- [x] `.env.example` - Template created
- [x] `package.json` - vercel-build script added
- [x] API URL using environment variables
- [x] WeatherWidget using env vars
- [x] Production build configuration

### Environment Variables to Set on Vercel
```
REACT_APP_API_URL=https://your-backend.onrender.com
```

### Deployment Steps
1. Push code to GitHub
2. Import project to Vercel
3. Set root directory to `frontend`
4. Set `REACT_APP_API_URL` environment variable
5. Deploy

### Post-Deployment
- [ ] Visit deployed URL
- [ ] Test AQI prediction
- [ ] Check 10-day forecast
- [ ] Verify all components load
- [ ] Test responsive design on mobile
- [ ] Check browser console for errors

---

## Critical Updates Made

### Backend Changes
✅ Added `gunicorn==22.0.0` to requirements.txt (security update)
✅ Updated CORS to accept environment variable for frontend URL
✅ Added PostgreSQL support (with SQLite fallback)
✅ Port binding from `PORT` environment variable
✅ Production initialization outside `if __name__ == '__main__'`
✅ Created Procfile for Gunicorn
✅ Created runtime.txt for Python version
✅ Created render.yaml for configuration

### Frontend Changes
✅ Updated API base URL to use `REACT_APP_API_URL` env var
✅ Updated WeatherWidget to use env var
✅ Created vercel.json for deployment config
✅ Added vercel-build script to package.json
✅ Created .env.example template

### New Files Created
✅ `backend/Procfile`
✅ `backend/runtime.txt`
✅ `backend/render.yaml`
✅ `backend/.env.example`
✅ `frontend/vercel.json`
✅ `frontend/.env.example`
✅ `.gitignore` (root level)
✅ `DEPLOYMENT.md` (comprehensive guide)
✅ `DEPLOYMENT_CHECKLIST.md` (this file)

---

## Testing Before Deployment

### Local Testing with Production Settings

**Backend**
```bash
cd backend
export FLASK_ENV=production
export FRONTEND_URL=http://localhost:3000
gunicorn app:app
```

**Frontend**
```bash
cd frontend
export REACT_APP_API_URL=http://localhost:8000
npm run build
npx serve -s build
```

---

## Common Issues & Solutions

### Issue: CORS Error
**Solution**: 
- Ensure `FRONTEND_URL` on Render matches Vercel URL exactly
- No trailing slash
- Include https://

### Issue: Backend Not Responding
**Solution**:
- Check Render logs
- Verify Gunicorn is running
- Test health endpoint

### Issue: Frontend Blank Page
**Solution**:
- Check Vercel build logs
- Verify environment variable is set
- Check browser console

### Issue: API 404 Errors
**Solution**:
- Verify `REACT_APP_API_URL` is correct
- Check if backend is awake (Render free tier sleeps)
- Test backend endpoint directly

---

## Performance Considerations

### Backend (Render Free Tier)
- ⚠️ Sleeps after 15 minutes of inactivity
- First request after sleep: ~30-60 seconds
- Consider paid tier for production

### Frontend (Vercel)
- ✅ Instant wake-up
- ✅ Global CDN
- ✅ Automatic HTTPS
- ✅ No cold starts

---

## Security Checklist

- [x] Environment variables for sensitive data
- [x] CORS restricted to specific origins
- [x] No hardcoded API keys in code
- [x] .env files ignored in git
- [x] Production mode enables security features

---

## Monitoring & Maintenance

### Things to Monitor
- [ ] Backend uptime
- [ ] API response times
- [ ] Error rates in logs
- [ ] Database size
- [ ] Free tier limits

### Regular Maintenance
- [ ] Check for dependency updates
- [ ] Monitor Render/Vercel usage
- [ ] Review logs weekly
- [ ] Test all features monthly

---

## Rollback Plan

If deployment fails:

1. **Backend Issues**
   - Revert to previous commit
   - Check Render logs
   - Verify environment variables

2. **Frontend Issues**
   - Vercel provides instant rollback
   - Go to Deployments tab
   - Click "Redeploy" on working version

---

## Success Criteria

Deployment is successful when:
- ✅ Backend health endpoint returns 200
- ✅ Frontend loads without console errors
- ✅ Can predict today's AQI
- ✅ 10-day forecast works
- ✅ All components render
- ✅ No CORS errors
- ✅ Mobile responsive
- ✅ Data persists in database

---

## 🎉 Ready to Deploy!

All files are configured and ready for deployment on:
- 🔴 **Backend**: Render
- ▲ **Frontend**: Vercel

Follow the detailed steps in [DEPLOYMENT.md](./DEPLOYMENT.md)

---

Last Updated: 2024
