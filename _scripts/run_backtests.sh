#!/usr/bin/env bash
# Initialize variables and settings.
: ${1?"Usage: $0 (dir)"} || exit 1
set -e
cd -P -- "$(dirname -- "$0")" && pwd -P
ROOT="$(git rev-parse --show-toplevel)"
type run_backtest || run_backtest() { echo run_backtest $*; }

# Find, parse configuration and run the tests.
find "$ROOT/$1" -type f -name "test.ini" -print0 | while IFS= read -r -d '' file; do
  . <(grep = "$file" | sed "s/;/#/g") # Load ini values.
  dir="$(dirname "$file")"
  for deposit in ${deposits[@]}; do
    for year in ${years[@]}; do
      for bt_source in ${bt_sources[@]}; do
        for spread in ${spreads[@]}; do
          run_backtest.sh -f $setfile -n $name -p $pair -d $deposit -y $year -s $spread -b $bt_source -D "$dir"
	  find ~/.wine/drive_c -type f -name Report.htm -exec html2text {} >> "$dir/README.md.new" ';'
        done
      done
    done
  done

  # Replace the old concatenated reports with the new one
  mv "$dir/README.md.new" "$dir/README.md"
done
