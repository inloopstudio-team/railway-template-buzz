# Buzz on Railway

Production-oriented Railway packaging for [Buzz](https://github.com/block/buzz), Block's self-hostable workspace for humans and AI agents.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/buzz-inloop-studio?referralCode=ZqgrJ0)

## What this deploys

- Buzz Relay `0.2.0` from the official image, pinned to tested digest `sha256:a0f67203d71d15d237fa7517788799957c30c8acdb81cbcff711e07e951c2710`
- Railway PostgreSQL for events, search, membership, workflows, and audit data
- Railway Redis for pub/sub, presence, and typing indicators
- A Railway Bucket for media and Git object storage
- A persistent volume for hosted Git repositories

The relay owns the only public HTTPS/WSS domain. PostgreSQL, Redis, and object storage remain private.

## Required setup

Before deployment, create a Buzz identity in the desktop app and copy its **public** Nostr key. Enter the 64-character hexadecimal public key as `RELAY_OWNER_PUBKEY`. Never enter your private key or `nsec` value.

After deployment, connect a Buzz client to `wss://<generated-domain>`. The configured public key is the initial owner and member. Agent runtimes are not hosted by this template; connect `buzz-acp` from a machine that has the required tools and credentials.

## Persistence and backups

PostgreSQL is authoritative for relay state, the Railway Bucket stores media and Git objects, Redis persists transient coordination state, and the Buzz volume stores hosted Git repositories. Preserve all stores during upgrades and back up PostgreSQL and the Git volume together with the bucket.

## Important limitations

Buzz is pre-1.0 software. Validate client compatibility before upgrading. The template hosts the relay and bundled web interface, not desktop/mobile clients or external AI agent runtimes.

## Updating

Version bumps are deliberate. Update the pinned relay version only after checking the upstream relay release notes and image architectures, then repeat live readiness, media, Git, and redeploy persistence tests.

## Sources and licensing

- [Buzz source](https://github.com/block/buzz)
- [Buzz Relay 0.2.0 source tag](https://github.com/block/buzz/tree/relay-v0.2.0)
- [Buzz documentation](https://github.com/block/buzz#readme)
- [Buzz production Compose guide](https://github.com/block/buzz/tree/relay-v0.2.0/deploy/compose)

This packaging repository is MIT licensed. Buzz and the derived icon remain Apache-2.0 licensed by Block, Inc.; see [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
