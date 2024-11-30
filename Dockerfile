FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    python3 \
    python3-pip
RUN curl -sSL https://ollama.ai/install.sh | bash

EXPOSE 8080

# Run both the server and the model command
CMD ["sh", "-c", "ollama start & sleep 5 && ollama run qwen2.5-coder:1.5b"]
