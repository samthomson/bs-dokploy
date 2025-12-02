# Blossom Server for Dokploy

A [Blossom](https://github.com/hzrd149/blossom-server) media server for Nostr, configured for deployment with Dokploy.

## Environment Variables

Set these in Dokploy:

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `DASHBOARD_USER` | No | `admin` | Admin dashboard username |
| `DASHBOARD_PASS` | **Yes** | `changeme` | Admin dashboard password |
| `ALLOWED_PUBKEYS` | No | (none) | Comma-separated hex pubkeys allowed to upload. If empty, any authenticated user can upload |
| `REQUIRE_UPLOAD_AUTH` | No | `true` | Require Nostr auth for `/upload` endpoint |
| `REQUIRE_MEDIA_AUTH` | No | `false` | Require Nostr auth for `/media` endpoint |

### Example

```
DASHBOARD_USER=admin
DASHBOARD_PASS=my-secure-password
ALLOWED_PUBKEYS=2093baa8621c5b255e8f4fc2c6fdfc10d8a5598a25517664efaba860735f1030,abc123def456...
```

To get your hex pubkey from an npub, use https://nostrcheck.me/converter/

## Local Development

```bash
# Run locally
DASHBOARD_USER=admin DASHBOARD_PASS=testpass docker compose up --build

# Access at http://localhost:3001
# Admin dashboard at http://localhost:3001/admin
```

## Deployment

1. Create a new Compose application in Dokploy
2. Connect this repository
3. Set the environment variables above
4. Deploy
5. Access admin dashboard at `https://your-domain.com/admin`

## Configuration

Edit `config.yml` to:
- Restrict uploads to specific pubkeys (uncomment `pubkeys` in storage rules)
- Change authentication requirements
- Configure storage backend (local or S3)

After changes, rebuild and redeploy since the config is baked into the Docker image.
