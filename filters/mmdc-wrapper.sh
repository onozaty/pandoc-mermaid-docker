#!/bin/sh
# diagram.lua から MERMAID_BIN 経由で呼ばれる mmdc ラッパー。
# root コンテナで Chromium を起動するため、puppeteer 設定で --no-sandbox を付与する。
# diagram.lua が渡す --input/--output 等の引数はそのまま "$@" で透過する。
exec mmdc -p /filters/puppeteer-config.json "$@"
