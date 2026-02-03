# Official nginx image from Docker Hub
FROM nginx:alpine


# Copy your static website files from local workspace into nginx folder
COPY . /usr/share/nginx/html

# Expose port 80 to serve HTTP
EXPOSE 80

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
