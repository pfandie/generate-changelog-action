FROM alpine:3.24.4@sha256:e2944c2947c8cabdd6b23a2ebcf8094a9f3d53ca9e0340edd065237ab74c18c0

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
