FROM --platform=linux/amd64 node:16

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Install Nginx
RUN apt-get update && apt-get install -y nginx

# Remove the default Nginx configuration
RUN rm -v /etc/nginx/nginx.conf

# Copy your Nginx configuration file
COPY config/nginx.conf /etc/nginx/

# Expose the port your Node.js app is running on
EXPOSE 80

# Start Nginx and your Node.js application
CMD npm run start & nginx -g 'daemon off;'