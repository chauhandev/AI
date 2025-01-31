# Base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y curl unzip

# Install Ollama
RUN curl -fsSL https://ollama.com/install.sh | sh

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs

# Create app directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy the rest of the app files
COPY . .

# Expose necessary ports
EXPOSE 3000 11434

# Start Ollama, install the model, then run the Node.js app
CMD ollama serve & \
    sleep 5 && \
    ollama run deepseek-r1:1.5b && \
    node index.js

