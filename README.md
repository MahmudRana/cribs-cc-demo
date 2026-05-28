# Cribs Command Center — Demo Deploy

Static HTML mockup served via nginx in a Docker container.

## Deploy to Render

### Option 1: One-Click via GitHub + Blueprint

1. Create a new GitHub repo (private is fine), upload these 4 files:
   - `Dockerfile`
   - `nginx.conf`
   - `render.yaml`
   - `index.html`
   - `.dockerignore`

2. Go to [Render Dashboard](https://dashboard.render.com) → **New** → **Blueprint**

3. Connect the GitHub repo. Render reads `render.yaml` and auto-configures the service.

4. Click **Apply**. First build takes 2-3 minutes. Subsequent deploys ~30s.

5. You'll get a URL like `cribs-command-center.onrender.com`

### Option 2: Manual Web Service

1. Push files to GitHub
2. Render → **New** → **Web Service** → connect repo
3. Settings:
   - **Runtime**: Docker
   - **Plan**: Free (or Starter $7/mo if you want it to never sleep)
   - **Branch**: main
4. Deploy

### Heads up about Render Free Tier

The free tier **spins down after 15 mins of inactivity**. First request after that takes ~30 seconds to wake up. For sending Sief a link, this is annoying but workable.

**If you want it always-on for the Mark/Josh kickoff**, upgrade to the **Starter plan ($7/mo)** for that service. Cancel after the kickoff if you don't need it persistent.

## Local Test (Optional)

```bash
docker build -t cribs-cc .
docker run -p 8080:8080 -e PORT=8080 cribs-cc
# Open http://localhost:8080
```

## Updating the Mockup

Replace `index.html` and push to GitHub. Render auto-redeploys.

## Files

- `Dockerfile` — nginx-alpine container, ~30MB image
- `nginx.conf` — serves the HTML, sets cache headers, enables gzip
- `render.yaml` — Render Blueprint for one-click deploy
- `index.html` — the V5 Command Center mockup
- `.dockerignore` — keeps the build clean

## Custom Domain (Optional)

If you want `cribs-cc.altri.ai` instead of `cribs-command-center.onrender.com`:

1. In Render service settings → **Custom Domains** → add `cribs-cc.altri.ai`
2. Render gives you a CNAME target
3. Add the CNAME in your Altri DNS provider
4. Render auto-issues a Let's Encrypt cert

Takes ~10 mins total.
