pub-relay (mei23)
=========

[pub-relay (fork by noellabo)](https://github.com/noellabo/pub-relay) のフォーク。

ただ、大きな機能が廃止されているため リファレンス実装 [pub-relay](https://source.joinmastodon.org/mastodon/pub-relay) に近いです。  
pub-relay から見ると主に以下の変更があります。

 - サポートタイプに `Move`, `Like`, `Add`, `Remove` を追加 (fork by noellabo から)
 - 管理機能を追加 (fork by noellabo から)
 - バグ修正 (あちこちから)
 - Docker対応

主に開発用にリファレンス実装に以下の変更を加えることを目的にしています。

- 動かしやすくする
- バグや想定外の挙動をなくす
- トラブルシュートしやすくする

---

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

- Send a Follow activity to the inbox to subscribe
  (Object: `https://www.w3.org/ns/activitystreams#Public`)
- Send an Undo of Follow activity to the inbox to unsubscribe
  (Object of object: `https://www.w3.org/ns/activitystreams#Public`)
- Send anything else to the inbox to broadcast it
    - Supported types: `Create`, `Update`, `Delete`, `Announce`, `Undo`, `Move`, `Like`, `Add`, `Remove`

Requirements:

- All requests must be HTTP-signed with a valid actor
- Only payloads that contain a linked-data signature will be re-broadcast
- Only payloads addressed to `https://www.w3.org/ns/activitystreams#Public` will be re-broadcast

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
