#!/bin/sh
set -e

SCRIPT_DIR=$(dirname "$(realpath "$0")")
INPUT_DIR="$SCRIPT_DIR/sample-docs"
OUTPUT_DIR="$SCRIPT_DIR/output"

docker build -t pandoc-ja "$SCRIPT_DIR/docker" --quiet

mkdir -p "$OUTPUT_DIR"

for INPUT_FILE in "$INPUT_DIR"/*.md; do
  BASENAME=$(basename "$INPUT_FILE" .md)
  OUTPUT_FILE="$OUTPUT_DIR/$BASENAME.pdf"

  printf "Converting %s.md -> %s.pdf ... " "$BASENAME" "$BASENAME"
  docker run --rm \
    -v "$INPUT_DIR":/input \
    -v "$OUTPUT_DIR":/output \
    pandoc-ja \
    /input/"$BASENAME.md" \
    -o /output/"$BASENAME.pdf"
  echo "done."
done

echo "Done. Output: $OUTPUT_DIR"
