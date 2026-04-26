# -------- Production Image --------
FROM nginx:1.27-alpine

# Remove default configs completely
RUN rm -rf /etc/nginx/conf.d/*

# Copy static website
COPY index.html /usr/share/nginx/html/index.html

# Copy custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Create required writable directories
RUN mkdir -p /tmp/nginx \
    && chown -R appuser:appgroup /tmp/nginx \
    && chown -R appuser:appgroup /usr/share/nginx/html

# Switch to non-root user
USER appuser

# Expose custom port
EXPOSE 8080

# Start nginx
CMD ["nginx", "-g", "daemon off;"]