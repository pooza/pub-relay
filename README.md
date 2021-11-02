pub-relay (fork by noellabo)
=========

...is a service-type ActivityPub actor that will re-broadcast anything sent to it to anyone who subscribes to it.

![](https://i.imgur.com/5q8db54.jpg)

Endpoints:

- `GET /actor`
- `POST /inbox`
- `GET /.well-known/webfinger`
- `GET /.well-known/nodeinfo`
- `GET /nodeinfo/2.0`
- `GET /stats`

Operations:

- for Mastodon or compatible implementation
    - Send a Follow activity to the inbox to subscribe
        - Object: `https://www.w3.org/ns/activitystreams#Public`
    - Send an Undo of Follow activity to the inbox to unsubscribe
        - Object of object: `https://www.w3.org/ns/activitystreams#Public`
- Send anything else to the inbox to broadcast it
    - Supported types: `Create`, `Update`, `Delete`, `Announce`, `Undo`, `Move`, `Like`, `Add`, `Remove`

Requirements:

- All requests must be HTTP-signed with a valid actor
- Only payloads that contain a linked-data signature will be re-broadcast
    - If the relay cannot re-broadcast, deliver an announce activity
- Only payloads addressed to `https://www.w3.org/ns/activitystreams#Public` will be re-broadcast
    - Deliver all activities except `Create`

## Installation

Require Crystal >= 1.1.1

```
shards update
shards build --release

openssl genrsa 2048 > actor.pem
chmod 600 actor.pem

cp .env.example .env
# Edit it

bin/pub-relay
```

## Usage

## Contributors

- [RX14](https://source.joinmastodon.org/RX14) creator, maintainer
- [noellabo](https://github.com/noellabo)
- [Candinya](https://candinya.com)
- MeiMei
