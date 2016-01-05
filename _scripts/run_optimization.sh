#!/usr/bin/env bash
# Script to run optimization tests.
: ${1?"Usage: $0 (dir) (filter)"} || exit 1
set -ex
cd -P -- "$(dirname -- "$0")" && pwd -P
ROOT="$(git rev-parse --show-toplevel)"

# Find, parse configuration and run the tests.
find "$ROOT/$1" -type f -name "test.ini" -print0 | while IFS= read -r -d '' file; do
  . <(grep = "$file" | sed "s/;/#/g") # Load ini values.
  dir="$(dirname "$file")"
  find "$ROOT/$1" -type f -name "*$2*.rules" -print0 | while IFS= read -r -d '' rule_file; do
    run_backtest.sh -x -v -o -e $name -f "$dir/$setfile" -c $currency -p $pair -d $deposit -y $year -s $spread -b $bt_source -i "$rule_file"
  done
done
