# Base image for Node.js
FROM node:18

# Install dependencies for Ollama (assuming Ubuntu-based installation works)
RUN apt-get update && apt-get install -y \
    curl \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*
do
# Install Ollama (adjust the following command as per Ollama's installation method)
RUN curl -sSL https://ollama.ai/install.sh | bash

# Set working directory for the Node.js app
WORKDIR /usr/src/app

# Copy Node.js application files
COPY package*.json ./
RUN npm install
COPY . .

# Expose the ports for Node.js and Ollama (adjust if needed)
EXPOSE 3000 8080

# Add a script to start both Ollama and the Node.js app
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Command to run both services (Ollama and Node.js)
CMD ["/start.sh"]
