# pandoc-mermaid-ja

Mermaid を含む Markdown を、**日本語フォント込み・ゼロ設定**で PDF に変換する Docker イメージです。

日本語の Markdown を PDF にしようとすると、フォントの指定や Mermaid の画像化まわりで設定が増えがちです。このイメージは [pandoc](https://pandoc.org/) ／ [pandoc-ext/diagram](https://github.com/pandoc-ext/diagram) ／ [mermaid-cli](https://github.com/mermaid-js/mermaid-cli) と、必要な日本語フォント・設定を 1 つにまとめて同梱しているため、`docker run` だけで変換できます。イメージは GHCR（`ghcr.io/onozaty/pandoc-mermaid-ja`）で配布しています。

## 特徴

- **日本語フォント同梱**（Noto Sans CJK JP）。フォント指定なしで日本語が出力できます。
- **Mermaid を自動で画像化**。コードブロックの ```` ```mermaid ```` がそのまま図になります。
- **設定不要ですぐ使える**。余白・用紙サイズ・PDF エンジンなどの既定値を同梱しています。
- **必要な部分だけ上書き可能**。同梱設定を土台に、利用側の指定が後勝ちでマージされます。

## クイックスタート

カレントディレクトリを `/data` にマウントし、その中の Markdown を PDF に変換します。**何も指定しなくても**、同梱の日本語フォント・余白・Mermaid 設定が適用されます。

```bash
docker run --rm -v "$PWD":/data \
  ghcr.io/onozaty/pandoc-mermaid-ja:latest \
  input.md -o output.pdf
```

`input.md` / `output.pdf` の後ろには、通常の [pandoc のオプション](https://pandoc.org/MANUAL.html)をそのまま渡せます。

### タグ

| タグ | 内容 |
| --- | --- |
| `latest` | 最新リリース |
| `X.Y`（例: `1.2`） | 指定したマイナーバージョンの最新 |
| `X.Y.Z`（例: `1.2.3`） | 特定バージョンに固定 |

再現性が必要な場合は `X.Y.Z` を、常に最新を使いたい場合は `latest` を指定してください。

## 設定の上書き

同梱の既定設定（[docker/pandoc-defaults.yaml](docker/pandoc-defaults.yaml)）が土台になり、利用側の指定が**後勝ち**でマージされます。変更したい範囲に応じて、次のいずれかを選んでください（上ほど手軽）。

### 個別オプションだけ変える

余白だけ変えたい、といったケース。指定していない項目（フォント等）は同梱のままです。

```bash
docker run --rm -v "$PWD":/data \
  ghcr.io/onozaty/pandoc-mermaid-ja:latest \
  input.md -o output.pdf -V geometry:margin=10mm
```

### 自前の defaults を重ねる

複数の設定をまとめて上書きしたいケース。同梱設定が土台、`my.yaml` が後勝ちです。

```bash
docker run --rm -v "$PWD":/data \
  ghcr.io/onozaty/pandoc-mermaid-ja:latest \
  input.md -o output.pdf --defaults my.yaml
```

### 同梱 defaults を丸ごと差し替える

既定設定そのものを置き換えたいケース。イメージ内の `/etc/pandoc/defaults.yaml` をマウントで上書きします。

```bash
docker run --rm -v "$PWD":/data \
  -v "$PWD/my-defaults.yaml":/etc/pandoc/defaults.yaml \
  ghcr.io/onozaty/pandoc-mermaid-ja:latest \
  input.md -o output.pdf
```

## 同梱物

イメージ内の構成は次のとおりです（詳細は [docker/Dockerfile](docker/Dockerfile) を参照）。

```
/etc/pandoc/
  defaults.yaml                  # 既定の設定（フォント・余白・PDF エンジン・フィルタ）
  filters/
    diagram.lua                  # mermaid 等を画像化する pandoc フィルタ
    mermaid-config.json          # mermaid テーマ（フォント等）
    puppeteer-config.json        # Chromium 起動オプション
/usr/local/bin/
  mmdc-wrapper                   # --no-sandbox 付きで mermaid-cli を呼ぶラッパー
```

既定設定の内容は [docker/pandoc-defaults.yaml](docker/pandoc-defaults.yaml) を参照してください。

## ローカルでのビルドと変換

リポジトリ直下の [convert.sh](convert.sh) は、**イメージをローカルでビルドしたうえで** `sample-docs/*.md` を一括変換し、`output/` に PDF を出力します（実行には Docker が必要です）。

```bash
./convert.sh
```

## ライセンス

MIT

## 作者

[onozaty](https://github.com/onozaty)
