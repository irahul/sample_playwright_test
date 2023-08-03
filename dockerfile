# download official node image and latest fromplaywright 
FROM node:18

FROM mcr.microsoft.com/playwright:v1.36.2-focal

# Set the working directory
WORKDIR /app

# Set the environment path to node_modules/.bin
ENV PATH /app/node_modules/.bin:$PATH

# Copy package.json and package-lock.json
COPY package.json /app/
COPY playwright.config.ts /app/
COPY tests*/ /app/tests/

# # Copy the rest of the application files
# COPY . .
  
# Get the needed libraries to run Playwright
RUN apt-get update && apt-get -y install libnss3 libatk-bridge2.0-0 libdrm-dev libxkbcommon-dev libgbm-dev libasound-dev libatspi2.0-0 libxshmfence-dev

# Install dependencies
RUN npm install
RUN npm ci


# # Move another directory
RUN cd /app/tests/

# # Set the entry point for the container
CMD ["npx", "playwright", "test"]