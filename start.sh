#!/bin/bash

# Start Ollama
ollama start &
# Run the Ollama model
ollama run qwen2.5-coder:1.5b &
# Start the Node.js app
node app.js
