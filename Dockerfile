# Use Node 20 LTS slim image
FROM node:20-bullseye-slim

# Install build essentials for native modules
RUN apt-get update && apt-get install -y \
    build-essential \
    python3 \
    python3-pip \
    g++ \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Update libstdc++ for GLIBCXX_3.4.29
RUN apt-get update && apt-get install -y libstdc++6

# Set working directory inside container
WORKDIR /usr/src/app

# Copy package files first (for caching dependencies)
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the application code
COPY . .

# Bootstrap project
RUN yarn bootstrap

# Expose ports for UI and API
EXPOSE 3000 4200

# Environment variables (replace as needed)
ENV NODE_ENV=development
ENV APP_NAME="Aruvili"

# Start API and UI together
CMD ["yarn", "start"]
