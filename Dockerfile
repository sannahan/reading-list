# Use an official Node.js runtime as the base image
FROM node:18

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# OpenShift ei salli tietoturvasyistä konttien ajoa root-oikeuksilla. 
# Suoritusaikaisen kontin käyttäjän UID on sattumanvarainen ja käyttäjä kuuluu aina root-ryhmään.
RUN chgrp -R root * && chmod -R 660 *

# Build the React app
RUN npm run build

# Expose port 8080 to the outside world
EXPOSE 8080

# Define the command to run your React app
CMD ["npm", "run", "preview"]
