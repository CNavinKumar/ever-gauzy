# Use official Node.js LTS image
FROM node:18.19.1

# Set working directory
WORKDIR /app

# Copy package files
COPY package.json yarn.lock ./

# Install Yarn globally (optional if Node image doesn't have it)
RUN npm install -g yarn

# Install dependencies
RUN yarn install --frozen-lockfile

# Bootstrap Gauzy (install internal packages & build dependencies)
RUN yarn bootstrap

# Copy the rest of the application code
COPY . .

# Optional: prepare husky hooks for development
# RUN yarn prepare:husky

# Expose ports for UI and API
EXPOSE 4200 3000

# Use environment variables from .env file if exists
ENV NODE_ENV=development

# Default command: run both API and UI
CMD ["yarn", "start"]
