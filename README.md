# Blossom Server for Dokploy

A [Blossom](https://github.com/hzrd149/blossom-server) media server for Nostr, configured for deployment with Dokploy.

## Environment Variables

Set these in Dokploy:

| Variable | Required | Description |
|----------|----------|-------------|
| `DASHBOARD_USER` | No | Dashboard username (default: `admin`) |
| `DASHBOARD_PASS` | Yes | Dashboard password |

## Local Development

```bash
# Run locally
DASHBOARD_USER=admin DASHBOARD_PASS=testpass docker compose up --build

# Access at http://localhost:3001
```

## Deployment

1. Create a new Compose application in Dokploy
2. Connect this repository
3. Set the environment variables above
4. Deploy

## Configuration

Edit `config.yml` to:
- Restrict uploads to specific pubkeys (uncomment `pubkeys` in storage rules)
- Change authentication requirements
- Configure storage backend (local or S3)

After changes, rebuild and redeploy since the config is baked into the Docker image.
