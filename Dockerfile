FROM crystallang/crystal:1.1.1-alpine AS base
WORKDIR /relay

FROM base AS builder

RUN apk -U upgrade && \
    apk add \
    build-base \
    openssl-dev \
    zlib-dev

COPY . ./

RUN shards update
RUN shards build --release

FROM base AS runner

VOLUME ["/relay/data"]

RUN apk -U upgrade && \
    apk add \
    pcre \
    libevent \
    gcc \
    openssl

COPY --from=builder /relay/bin /relay/bin

CMD ["/relay/bin/pub-relay"]
