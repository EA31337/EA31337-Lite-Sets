#!/usr/bin/env bash
# Script to run main backtests.
: ${1?"Usage: $0 (filter)"} || exit 1
set -e
cd -P -- "$(dirname -- "$0")" && pwd -P
ROOT="$(git rev-parse --show-toplevel)"
PATH="$PATH:$ROOT/_scripts:$ROOT/_VM/scripts"
OUT="README.md"

# Find, parse configuration and run the tests.
find "$ROOT" -type f -path "*$1*" -name "test.ini" -print0 | sort -z | while IFS= read -r -d '' file; do
  . <(grep = "$file" | sed "s/;/#/g") # Load ini values.
  dir=$(dirname "$file")
  dirname=$(basename "$dir")
  base_name="${pair}-${deposit}${currency}-${year}year-${spread}spread-${bt_source}"
  report_name="${pair}-${deposit}${currency}-${year}year-${spread}spread-${bt_source}-main-test"
  run_backtest.sh ${@:2} -v -t -e $name -f "$dir/$setfile" -c $currency -p $pair -d $deposit -y $year -s $spread -b $bt_source -r "$report_name" -D "$dir"
  gen_report.sh "$dir" "$OUT" main
  push_report.sh "Backtest-$base_name" "Backtest results: $base_name"
done
echo "$0 done."
