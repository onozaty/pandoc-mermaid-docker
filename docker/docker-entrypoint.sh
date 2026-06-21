#!/bin/sh
# 同梱の日本語+Mermaid 設定 (pandoc-defaults.yaml) を常に適用しつつ pandoc を呼ぶ。
# 利用側の引数 "$@" は --defaults の後ろに置くため、--defaults my.yaml や -V で
# 後勝ち上書き（マージ）できる。
set -e
exec /usr/local/bin/pandoc --defaults /etc/pandoc/defaults.yaml "$@"
