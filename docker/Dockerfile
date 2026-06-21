# 再現性のためバージョンを固定（Alpine ベース。apk を使うため -alpine 必須）
FROM pandoc/extra:3.9.0.2-alpine

# 日本語フォント + mermaid レンダリングに必要な Node.js / Chromium
RUN apk add --no-cache \
    font-noto-cjk font-noto-cjk-extra \
    nodejs npm chromium

# mermaid-cli (mmdc) を導入。同梱の Chromium を使い、ダウンロードは抑止
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
RUN npm install -g @mermaid-js/mermaid-cli

# diagram フィルタ・puppeteer 設定・mmdc ラッパーを配置（同梱物は /etc/pandoc に集約）
COPY filters/diagram.lua /etc/pandoc/filters/diagram.lua
COPY filters/puppeteer-config.json /etc/pandoc/filters/puppeteer-config.json
COPY filters/mermaid-config.json /etc/pandoc/filters/mermaid-config.json
COPY filters/mmdc-wrapper.sh /usr/local/bin/mmdc-wrapper
RUN chmod +x /usr/local/bin/mmdc-wrapper

# diagram.lua の mermaid エンジンにラッパーを使わせる（--no-sandbox 付与のため）
ENV MERMAID_BIN=/usr/local/bin/mmdc-wrapper

# 同梱の日本語+Mermaid 設定。ENTRYPOINT ラッパーが常に --defaults で適用する
COPY pandoc-defaults.yaml /etc/pandoc/defaults.yaml
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]

LABEL org.opencontainers.image.source="https://github.com/onozaty/pandoc-mermaid-ja" \
      org.opencontainers.image.description="pandoc + mermaid (diagram.lua) で日本語 Markdown を PDF 化するイメージ" \
      org.opencontainers.image.licenses="MIT"
