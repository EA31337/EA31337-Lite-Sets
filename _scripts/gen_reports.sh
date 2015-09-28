#!/usr/bin/env bash
type ex || exit 1
type html2text || exit 1
ROOT=$(git rev-parse --show-toplevel)
OUT="README.md.new"
dirs=($(find $ROOT -type d))
for dir in "${dirs[@]}"; do
  cd "$dir"
  ls *.htm 2> /dev/null || continue
  html2text *.htm | tee -a $OUT
done
