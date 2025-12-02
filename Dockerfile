FROM ghcr.io/hzrd149/blossom-server:master

# Copy default config (used if no env var provided)
COPY config.yml /app/config.yml

# Copy and set up entrypoint script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]

