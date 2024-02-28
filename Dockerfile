# Use an official Node.js runtime as the base image
FROM node:18-alpine AS build
# Set the working directory in the container
WORKDIR /app
# Copy package.json and package-lock.json (if available)
COPY package*.json ./
# Install dependencies
RUN npm install
# Copy the rest of the application code
COPY . .
# Build the React app
RUN npm run build

# Use Nginx as the production server
FROM nginxinc/nginx-unprivileged
# Copy the built React app to Nginx's web server directory
COPY --from=build /app/dist /usr/share/nginx/html
# Expose port 8080 for the Nginx server
EXPOSE 8080
# OpenShift ei salli tietoturvasyistä konttien ajoa root-oikeuksilla. 
# Suoritusaikaisen kontin käyttäjän UID on sattumanvarainen ja käyttäjä kuuluu aina root-ryhmään.
# RUN chgrp -R 0 * && chmod -R g+rwX *
# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
