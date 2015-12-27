#!/usr/bin/env bash
# Initialize variables and settings.
: ${1?"Usage: $0 (dir)"} || exit 1
set -ex
cd -P -- "$(dirname -- "$0")" && pwd -P
ROOT="$(git rev-parse --show-toplevel)"

# Find, parse configuration and run the tests.
find "$ROOT/$1" -type f -name "test.ini" -print0 | while IFS= read -r -d '' file; do
  . <(grep = "$file" | sed "s/;/#/g") # Load ini values.
  dir="$(dirname "$file")"
  for deposit in ${deposits[@]}; do
    for year in ${years[@]}; do
      for bt_source in ${bt_sources[@]}; do
        for spread in ${spreads[@]}; do
          report_dir="$dir/Report-$deposit-$year-$bt_source-$spread"
          mkdir -p "$report_dir"
          run_backtest.sh -x -e $name -f "$dir/$setfile" -p $pair -d $deposit -y $year -s $spread -b $bt_source -D "$report_dir"
        done
      done
    done
  done
done
