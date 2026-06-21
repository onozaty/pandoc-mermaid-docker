FROM pandoc/extra:latest

# 日本語フォント + mermaid レンダリングに必要な Node.js / Chromium
RUN apk add --no-cache \
    font-noto-cjk font-noto-cjk-extra \
    nodejs npm chromium

# mermaid-cli (mmdc) を導入。同梱の Chromium を使い、ダウンロードは抑止
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
RUN npm install -g @mermaid-js/mermaid-cli

# diagram フィルタ・puppeteer 設定・mmdc ラッパーを配置
COPY filters/diagram.lua /filters/diagram.lua
COPY filters/puppeteer-config.json /filters/puppeteer-config.json
COPY filters/mmdc-wrapper.sh /usr/local/bin/mmdc-wrapper
RUN chmod +x /usr/local/bin/mmdc-wrapper

# diagram.lua の mermaid エンジンにラッパーを使わせる（--no-sandbox 付与のため）
ENV MERMAID_BIN=/usr/local/bin/mmdc-wrapper
