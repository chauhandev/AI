# Base image
FROM ubuntu:20.04

# Set environment variables to prevent interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary tools
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    ca-certificates \
    lsb-release \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js from NodeSource (for latest version)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest  # Install the latest version of npm

# Install Ollama
RUN curl -sSL https://ollama.ai/install.sh | bash

# Create app directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Expose ports (Ollama server: 11434; Node.js API: 3000)
EXPOSE 11434 3000

# Start Ollama server and Node.js API
CMD ["sh", "-c", "ollama start & ollama run deepseek-r1:1.5b & node runLlama.js"]
