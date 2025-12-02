#!/bin/sh

# Generate config.yml from environment variables

# Set defaults
DASHBOARD_USER="${DASHBOARD_USER:-admin}"
DASHBOARD_PASS="${DASHBOARD_PASS:-changeme}"
REQUIRE_UPLOAD_AUTH="${REQUIRE_UPLOAD_AUTH:-true}"
REQUIRE_MEDIA_AUTH="${REQUIRE_MEDIA_AUTH:-false}"

# Start building config
cat > /app/config.yml << EOF
publicDomain: ""
databasePath: data/sqlite.db

dashboard:
  enabled: true
  username: "${DASHBOARD_USER}"
  password: "${DASHBOARD_PASS}"

storage:
  backend: local
  local:
    dir: ./data/blobs
  rules:
EOF

# Generate rules with pubkeys if ALLOWED_PUBKEYS is set
if [ -n "$ALLOWED_PUBKEYS" ]; then
  # For each file type, add rule with pubkeys
  for type in "image/*" "video/*" "*"; do
    cat >> /app/config.yml << EOF
    - type: "${type}"
      expiration: never
      pubkeys:
EOF
    # Split ALLOWED_PUBKEYS by comma and add each
    echo "$ALLOWED_PUBKEYS" | tr ',' '\n' | while read -r pubkey; do
      # Trim whitespace
      pubkey=$(echo "$pubkey" | xargs)
      if [ -n "$pubkey" ]; then
        echo "        - \"${pubkey}\"" >> /app/config.yml
      fi
    done
  done
else
  # No pubkey restriction - allow all authenticated users
  cat >> /app/config.yml << EOF
    - type: "image/*"
      expiration: never
    - type: "video/*"
      expiration: never
    - type: "*"
      expiration: never
EOF
fi

# Add upload and media config
cat >> /app/config.yml << EOF

upload:
  enabled: true
  requireAuth: ${REQUIRE_UPLOAD_AUTH}

media:
  enabled: true
  requireAuth: ${REQUIRE_MEDIA_AUTH}
EOF

echo "Generated config.yml:"
cat /app/config.yml
echo ""

