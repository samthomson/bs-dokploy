FROM ghcr.io/hzrd149/blossom-server:master

# Copy our custom config into the image
COPY config.yml /app/config.yml

