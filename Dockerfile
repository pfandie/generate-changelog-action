FROM alpine:3.19.1@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

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
