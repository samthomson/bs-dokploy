# Build stage: compile blossom-server from source
FROM node:20-alpine AS builder
RUN apk add --no-cache git python3 make g++
RUN git clone https://github.com/hzrd149/blossom-server.git /app
WORKDIR /app
RUN npm install
RUN npm run build

# Production stage
FROM node:20-alpine
WORKDIR /app
# Copy the compiled application from the builder stage
COPY --from=builder /app /app
# Copy your custom config generator script
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Generate config then run the server using node
ENTRYPOINT ["/bin/sh", "-c", "/app/entrypoint.sh && exec node dist/index.js"]
