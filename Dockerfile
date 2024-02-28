# Use an official Node.js runtime as the base image
FROM node:18-alpine AS build
# Set the working directory in the container
WORKDIR /app
# Copy package.json and package-lock.json (if available)
COPY package*.json ./
# Install dependencies
RUN npm install --omit=dev
# Copy the rest of the application code
COPY . .
# Build the React app
RUN npm run build

# Use a minimal base image for the final image
FROM node:18-alpine
# Set the working directory
WORKDIR /app
# Copy built files from the previous stage
COPY --from=build /app/build ./build
# Expose port 8080 to the outside world
EXPOSE 8080
# OpenShift ei salli tietoturvasyistä konttien ajoa root-oikeuksilla. 
# Suoritusaikaisen kontin käyttäjän UID on sattumanvarainen ja käyttäjä kuuluu aina root-ryhmään.
RUN chgrp -R 0 * && chmod -R g+rwX *
# Define the command to run your React app
CMD ["npm", "run", "preview"]
