#!/usr/bin/env bash
# Wrapper script to run backtest tests.
set -e
[ "$TRACE" ] && set -x
ROOT="$(git rev-parse --show-toplevel)"
PATH="$PATH:$ROOT/_scripts:$ROOT/_VM/scripts"
[ $# -eq 0 ] && { echo "Usage: $0 [ini-file]"; exit 1; }
read file args <<<$@

# Parse configuration and run the test.
[ -f "$file" ] || { echo "ERROR: File '$file' not found!" >&2; exit 1; }
. <(grep = "$file" | sed "s/;/#/g") # Load ini values.
dir="$(dirname "$file")"
report_name="${pair}-${deposit}${currency}-${year}y-${spread}spread-${bt_source}-backtest-test"
env TRACE=$TRACE run_backtest.sh -v -t -M4x -e $name -f "$dir/$setfile" -c $currency -p $pair -d $deposit -D $digits -y $year -s $spread -b $bt_source -r "$report_name" -O "$ROOT/results" $args
echo "$0 done."
