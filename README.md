# pandoc-mermaid-ja

Mermaid を含む Markdown を、日本語フォント付きで PDF に変換する Docker イメージです。
[pandoc](https://pandoc.org/) + [pandoc-ext/diagram](https://github.com/pandoc-ext/diagram)
＋ [mermaid-cli](https://github.com/mermaid-js/mermaid-cli) を同梱しています。

イメージは GHCR で配布しています。 `ghcr.io/onozaty/pandoc-mermaid-ja`

## 使い方

カレントディレクトリ（`/data` にマウント）の Markdown を PDF に変換します。
**何も指定しなくても**、同梱の日本語フォント・余白・Mermaid 設定が適用されます。

```bash
docker run --rm -v "$PWD":/data \
  ghcr.io/onozaty/pandoc-mermaid-ja \
  input.md -o output.pdf
```

### 設定の上書き

同梱設定を土台に、利用側の指定が後勝ちでマージされます。

```bash
# 自前の defaults を重ねて上書き（同梱が土台、my.yaml が後勝ち）
docker run --rm -v "$PWD":/data \
  ghcr.io/onozaty/pandoc-mermaid-ja \
  input.md -o output.pdf --defaults my.yaml

# 個別オプションで上書き（余白だけ変更。フォント等は同梱のまま）
docker run --rm -v "$PWD":/data \
  ghcr.io/onozaty/pandoc-mermaid-ja \
  input.md -o output.pdf -V geometry:margin=10mm

# 同梱 defaults を丸ごと差し替える（マウントで上書き）
docker run --rm -v "$PWD":/data \
  -v "$PWD/my-defaults.yaml":/etc/pandoc/defaults.yaml \
  ghcr.io/onozaty/pandoc-mermaid-ja \
  input.md -o output.pdf
```

同梱物はイメージ内の `/etc/pandoc/` に集約されています。

```
/etc/pandoc/
  defaults.yaml          # 既定の設定（下記内容）
  filters/
    diagram.lua          # mermaid 等を画像化する pandoc フィルタ
    mmdc-wrapper.sh 相当  # （実体は /usr/local/bin/mmdc-wrapper）
    puppeteer-config.json # Chromium 起動オプション
    mermaid-config.json   # mermaid テーマ（フォント等）
```

同梱の `defaults.yaml`（イメージ内 `/etc/pandoc/defaults.yaml`）の内容:

```yaml
pdf-engine: xelatex
filters:
  - /etc/pandoc/filters/diagram.lua
variables:
  mainfont: Noto Sans CJK JP
  CJKmainfont: Noto Sans CJK JP
  papersize: a4
  geometry: margin=20mm
```

## ローカルでのビルドと変換

`sample-docs/*.md` を一括変換して `output/` に出力します（イメージをローカルビルド）。

```bash
./convert.sh
```

## ライセンス

MIT

## 作者

[onozaty](https://github.com/onozaty)
