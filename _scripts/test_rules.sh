#!/usr/bin/env bash
# Script to test rules for any errors.
set -e
[ "$TRACE" ] && set -x
ROOT="$(git rev-parse --show-toplevel)"
SETFILE="$ROOT/EURUSD/default/2000USD/10-spread/5-digits/2014/EA31337-Lite.set"
TESTER_INI="$ROOT/_VM/conf/mt4-tester.ini"
EA_INI="$ROOT/_VM/conf/ea.ini"
cp -f "${SETFILE}" "${SETFILE}.bak" && SETFILE="${SETFILE}.bak"
cp -f "${TESTER_INI}" "${TESTER_INI}.bak" && TESTER_INI="${TESTER_INI}.bak"
cp -f "${EA_INI}" "${EA_INI}.bak" && EA_INI="${EA_INI}.bak"

cd "$ROOT"
. ./_VM/scripts/.funcs.inc.sh
. ./_VM/scripts/.vars.inc.sh
. ./_rules/.init.rules.inc

find "$ROOT" -type f -name "*$1*.rule" -print0 | sort -z | while IFS= read -r -d '' rule_file; do
  echo "Testing $(basename ${rule_file} .rule)..."
  . "$rule_file"
done && echo OK
