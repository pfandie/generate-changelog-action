FROM alpine:3.20.3@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d

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
