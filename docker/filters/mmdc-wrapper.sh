#!/bin/sh
# diagram.lua から MERMAID_BIN 経由で呼ばれる mmdc ラッパー。
# root コンテナで Chromium を起動するため、puppeteer 設定で --no-sandbox を付与する。
# -c でテーマ設定を渡し、図中フォントを本文と同じ Noto Sans CJK JP に揃える。
# diagram.lua が渡す --input/--output 等の引数はそのまま "$@" で透過する。
exec mmdc -p /etc/pandoc/filters/puppeteer-config.json -c /etc/pandoc/filters/mermaid-config.json "$@"
