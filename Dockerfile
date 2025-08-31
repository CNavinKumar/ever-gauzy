# Use Node 18 LTS slim image (includes Yarn)
FROM node:20-bullseye-slim

# Set working directory inside container
WORKDIR /usr/src/app

# Copy package files first (for caching dependencies)
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Bootstrap project (run Gauzy/Aruvili bootstrap script)
RUN yarn bootstrap

# Expose ports for UI and API
EXPOSE 3000 4200

# Optional: set environment variables (replace with your .env variables or use a separate .env file)
ENV NODE_ENV=development
ENV APP_NAME="Aruvili"
# Add more ENV variables if needed

# Start API and UI together
CMD ["yarn", "start"]
