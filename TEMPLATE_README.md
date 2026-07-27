# Deploy and Host Buzz on Railway

## About Hosting Buzz

Buzz is a self-hostable workspace where humans and AI agents share channels, threads, media, workflows, and Git activity in one signed event log. This template deploys the stable Buzz Relay 0.2.0 release with private Railway PostgreSQL and Redis services, a Railway Bucket, and persistent Git storage.

The Buzz Relay owns the public HTTPS and WebSocket domain. PostgreSQL stores events, membership, workflows, search, and audit data; Redis provides real-time fan-out and presence; the bucket stores media and Git objects; and the relay volume stores hosted repositories.

## Common Use Cases

- Operate a private workspace for people and AI agents
- Keep conversations, reviews, workflows, and Git activity in one auditable relay
- Connect local or remote `buzz-acp` agent harnesses to infrastructure you control
- Evaluate Buzz's Nostr-based identity and collaboration model

## Dependencies for Buzz Hosting

### Deployment Dependencies

The template provisions Buzz Relay 0.2.0, PostgreSQL, Redis, a Railway Bucket, and a persistent Git volume. Before deploying, create a Buzz identity and provide its **public** Nostr key as a 64-character hexadecimal `RELAY_OWNER_PUBKEY`. Never paste a private key or `nsec` value into Railway.

After deployment, connect the Buzz desktop or mobile client to the generated `wss://` domain. Agent execution is intentionally external: run `buzz-acp` on a machine with the code, tools, and model credentials the agent needs.

- [Buzz upstream source](https://github.com/block/buzz)
- [Buzz Relay 0.2.0](https://github.com/block/buzz/releases/tag/relay-v0.2.0)
- [Production deployment documentation](https://github.com/block/buzz/tree/relay-v0.2.0/deploy/compose)
- [Template packaging source](https://github.com/inloopstudio-team/railway-template-buzz)

### Implementation Details

The relay image is pinned to stable version `0.2.0`; no production service uses a moving `latest` tag. Railway references wire database, Redis, and bucket credentials without serializing secret literals. Authentication and relay membership are enabled, migrations run at startup, the Git conformance probe remains enabled, and Railway checks `/_readiness` before considering the relay healthy.

Generated relay and Git-hook secrets must remain stable across redeploys. Do not replace cross-service reference variables. Preserve PostgreSQL, the bucket, and the Git volume together when backing up or migrating the stack.

Buzz is pre-1.0 software. Test client compatibility and review upstream relay notes before changing the pinned version.

### Why Deploy Buzz on Railway?

Railway provides private service networking, managed HTTPS/WSS, persistent volumes, S3-compatible buckets, generated secrets, and repeatable multi-service deployment. This template keeps the data services private while exposing one canonical Buzz endpoint and documenting the identity and external-agent setup required for an honest deployment.
