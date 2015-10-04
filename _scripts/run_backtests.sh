#!/usr/bin/env bash
# Initialize variables and settings.
: ${1?"Usage: $0 (dir)"} || exit 1
set -e
cd -P -- "$(dirname -- "$0")" && pwd -P
ROOT="$(git rev-parse --show-toplevel)"
type run_backtest || run_backtest() { echo run_backtest $*; }

# Find the ini files.
inis=($(find "$ROOT/$1" -name \*.ini))

# Parse configuration and run the tests.
for ini in ${inis[@]}; do
  . <(grep = "$ini" | sed "s/;/#/g") # Load ini values.
  dir=$(dirname $ini)
  for deposit in ${deposits[@]}; do
    for year in ${years[@]}; do
      for bt_source in ${bt_sources[@]}; do
        for spread in ${spreads[@]}; do
          run_backtest -r "$dir" -f $setfile -n $name -p $pair -d $deposit -y $year -s $spread -b $bt_source
        done
      done
    done
  done
done
