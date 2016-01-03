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
  for curr_deposit in ${deposits[@]}; do
    for curr_year in ${years[@]}; do
      for bt_source in ${bt_sources[@]}; do
        for curr_spread in ${spreads[@]}; do
          report_dir="$dir/Report-$curr_deposit-$curr_year-$bt_source-$curr_spread"
          mkdir -p "$report_dir"
          run_backtest.sh -x -v -e $name -f "$dir/$setfile" -c $currency -p $pair -d $curr_deposit -y $curr_year -s $curr_spread -b $bt_source -D "$report_dir"
        done
      done
    done
  done
done
