# Minimal Dockerfile to serve the Cribs Command Center mockup
# Uses nginx-alpine for tiny image size and fast cold starts

FROM nginx:alpine

# Copy the mockup HTML as the index page
COPY index.html /usr/share/nginx/html/index.html

# Custom nginx config for SPA-style routing and proper caching
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Render assigns the PORT env var dynamically; nginx config handles it
EXPOSE 8080

# Use a shell wrapper to substitute the PORT env var into nginx config at runtime
CMD ["/bin/sh", "-c", "envsubst '$PORT' < /etc/nginx/conf.d/default.conf > /tmp/default.conf && cp /tmp/default.conf /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"]
