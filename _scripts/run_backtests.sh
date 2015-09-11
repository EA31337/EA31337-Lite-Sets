#!/bin/bash
# Initialize variables and settings.
: ${1?"Usage: $0 (filter)"} || exit 1
ROOT=$(git rev-parse --show-toplevel)
. $ROOT/_conf/backtest.ini

# Find the set files.
sets=$(find $ROOT -ipath \*$1\*.set -print0)

# Parse configuration and run the tests.
IFS=',' symbols=($symbols)
IFS=',' years=($years)
IFS=',' spreads=($spreads)
IFS=',' sources=($sources)
for file in "${sets[@]}"; do
  for symbol in "${symbols[@]}"; do
    for year in "${years[@]}"; do
      for spread in "${spreads[@]}"; do
        for source in "${sources[@]}"; do
          run_backtest "$file" $symbol $year $spread $source
        done
      done
    done
  done
done
