# Use Node.js 20 as the base image
FROM node:20-alpine AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install Angular CLI globally and dependencies
RUN  npm install

# Copy the rest of the application source code
COPY . .

# Build the Angular application
RUN npm run build 

# Use a lightweight web server to serve the Angular app (e.g., Nginx or HTTP server)
FROM nginx:alpine

# Copy the Angular build output to Nginx's HTML folder
COPY --from=build /usr/src/app/dist/hotel_management/usr/share/nginx/html

# Expose port 80 for the application
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
