#!/usr/bin/env bash
set -ex
ROOT="$(git rev-parse --show-toplevel)"
CWD=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
find $ROOT -name "*.gif" -execdir pwd ';' | sort -u | while IFS= read -r dir; do
  $CWD/gen_report.sh "$dir"
done
echo "$0 done."
