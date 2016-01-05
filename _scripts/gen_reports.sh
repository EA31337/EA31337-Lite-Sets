#!/usr/bin/env bash
set -ex
type html2text grep sed
[ $# -eq 0 ] && { echo "Usage: $0 (dir)"; exit 1; }
DIR="$1"
ROOT="$(git rev-parse --show-toplevel)"
OUT="README.md"
FILTER="-e Period -e quality -e errors -e deposit -e profit -e drawdown -e positions -e trade -e consecutive"
[ -d "$DIR" ]

# Find, parse configuration and run the tests.
find "$ROOT/$1" -type f -name "test.ini" -print0 | while IFS= read -r -d '' file; do
  dir="$(dirname "$file")"
  > "$dir/$OUT"
  find "$dir" -type f -name "*USD*.txt" -print0 | while IFS= read -r -d '' report; do
    base=$(basename "$report")
    name=$(echo "$base" | sed "s/-/ /g")
    gif="$(basename "${base%.*}.gif")"
    printf "\n### Report: ${name%.*}\n\n" >> "$dir/$OUT"
    printf "![$name]($gif)\n\n" >> "$dir/$OUT"
    grep "^\S" "$report" | sed 's/^/    /' >> "$dir/$OUT"
  done
done
echo "$0 done."
