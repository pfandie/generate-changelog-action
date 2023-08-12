FROM alpine:3.18.3@sha256:7144f7bab3d4c2648d7e59409f15ec52a18006a128c733fcff20d3a4a54ba44a

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
