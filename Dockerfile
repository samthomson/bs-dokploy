FROM ghcr.io/hzrd149/blossom-server:master

# Copy config generator script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

WORKDIR /app

# Generate config then run the server
ENTRYPOINT ["/bin/sh", "-c", "/app/entrypoint.sh && exec node ."]

