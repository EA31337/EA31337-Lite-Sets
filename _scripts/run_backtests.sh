#!/usr/bin/env bash
# Initialize variables and settings.
set -e
cd -P -- "$(dirname -- "$0")" && pwd -P
ROOT="$(git rev-parse --show-toplevel)"
VM_DIR="$(find "$ROOT" -type d -name _VM -print -quit)"
PATH="$PATH:$ROOT/_scripts:$VM_DIR"
OUT="README.md"

# Find, parse configuration and run the tests.
find "$ROOT" -type f -name "test.ini" -path "*$1*" -print0 | sort -z | while IFS= read -r -d '' file; do
  . <(grep = "$file" | sed "s/;/#/g") # Load ini values.
  dir="$(dirname "$file")"
  base_name="${pair}-${deposit}${currency}-${year}year-${spread}spread-${bt_source}"
  for curr_deposit in ${deposits[@]}; do
    for curr_year in ${years[@]}; do
      for curr_bt_source in ${bt_sources[@]}; do
        for curr_spread in ${spreads[@]}; do
          report_name="${pair}-${curr_deposit}${currency}-${curr_year}year-${curr_spread}spread-${curr_bt_source}-backtest"
          run_backtest.sh ${@:2} -v -t -e $name -f "$dir/$setfile" -c $currency -p $pair -d $curr_deposit -D $digits -y $curr_year -s $curr_spread -b $curr_bt_source -r "$report_name" -O "$dir/_test_results" $@
        done
      done
    done
  done
  gen_report.sh "$dir/_test_results" "$OUT"
  gen_report.sh "$dir" "$OUT" "$name"
#push_report.sh "Backtest-$base_name" "Backtest results: $base_name"
done
echo "$0 done."
