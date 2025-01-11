FROM alpine:3.21.2@sha256:56fa17d2a7e7f168a043a2712e63aed1f8543aeafdcee47c58dcffe38ed51099

ENV CHGLOG_VERSION=0.15.4
COPY entrypoint.sh /entrypoint.sh
COPY .chglog /.chglog

RUN apk add --no-cache \
    bash \
    git \
    jq

RUN wget -q https://github.com/git-chglog/git-chglog/releases/download/v${CHGLOG_VERSION}/git-chglog_${CHGLOG_VERSION}_linux_amd64.tar.gz -P /tmp/ && \
    tar -xzf /tmp/git-chglog_${CHGLOG_VERSION}_linux_amd64.tar.gz -C /usr/local/bin/ && \
    chmod 755 /entrypoint.sh /usr/local/bin/git-chglog

ENTRYPOINT ["/entrypoint.sh"]
