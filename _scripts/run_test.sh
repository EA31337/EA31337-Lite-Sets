#!/usr/bin/env bash
# Wrapper script to run backtest tests.
set -e
cd -P -- "$(dirname -- "$0")" && pwd -P
[ "$TRACE" ] && set -x
ROOT="$(git rev-parse --show-toplevel)"
PATH="$PATH:$ROOT/_scripts:$ROOT/_VM/scripts"
[ "$TRACE" ] && set -x

# Find, parse configuration and run the tests.
find "$ROOT" -type f -name "test.ini" -print0 | sort -z | while IFS= read -r -d '' file; do
  . <(grep = "$file" | sed "s/;/#/g") # Load ini values.
  dir="$(dirname "$file")"
  find "$ROOT" -type f -name "*$1*.rules" -print0 | while IFS= read -r -d '' rule_file; do
    report_base="$(basename "${rule_file%.*}")"
    report_name="${report_base}--${pair}-${deposit}${currency}-${year}year-${spread}spread-${bt_source}-backtest-test"
    env TRACE=$TRACE run_backtest.sh ${@:2} -v -t -e $name -f "$dir/$setfile" -c $currency -p $pair -d $deposit -D $digits -y $year -s $spread -b $bt_source -r "$report_name" -i "$rule_file" -O "$ROOT/results"
    [ "$FIRST" ] && break
  done
done
echo "$0 done."
