# Use the official pre-built image
FROM ghcr.io/hzrd149/blossom-server:master

# Copy your custom config generator script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

WORKDIR /app

# Generate config using your script, then start the server using Deno
ENTRYPOINT ["/bin/sh", "-c", "/app/entrypoint.sh && exec deno task start"]
