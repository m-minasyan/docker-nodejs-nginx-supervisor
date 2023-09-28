FROM node:18.15-alpine

# Install needed apps and set workdir
RUN apk add --no-cache curl nginx supervisor
WORKDIR /app

# Copy project files and config files
COPY . .
COPY ./docker/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/supervisord-programs.conf /etc/supervisor/conf.d/supervisord-programs.conf
COPY ./docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Run command
EXPOSE 80
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
