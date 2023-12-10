# Using a specific version of the Node.js image for consistency and reliability
FROM node:18.15-alpine

# Installing required applications: curl for network operations, Nginx as a web server, and Supervisor for process control
RUN apk add --no-cache curl nginx supervisor

# Setting the working directory inside the container
WORKDIR /app

# Copying the entire project and necessary configuration files into the container
COPY . .
COPY ./docker/nginx.conf /etc/nginx/nginx.conf
COPY ./docker/supervisord-programs.conf /etc/supervisor/conf.d/supervisord-programs.conf
COPY ./docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Exposing port 80 for Nginx
EXPOSE 80

# Starting Supervisor to manage the Node.js and Nginx processes
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
