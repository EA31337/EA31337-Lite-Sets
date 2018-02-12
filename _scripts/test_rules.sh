#!/usr/bin/env bash
# Script to test rules for any errors.
set -e
[ "$TRACE" ] && set -x
ROOT="$(git rev-parse --show-toplevel)"
SETFILE="$ROOT/EURUSD/default/10000USD/20-spread/5-digits/2014-2016/EA31337-Lite.set"
VM_DIR="$(find "$ROOT" -type d -name _VM -print -quit)"
TESTER_INI="$VM_DIR/conf/mt4-tester.ini"
EA_INI="$VM_DIR/conf/ea.ini"
cp -f "${SETFILE}" "${SETFILE}.bak" && SETFILE="${SETFILE}.bak"
cp -f "${TESTER_INI}" "${TESTER_INI}.bak" && TESTER_INI="${TESTER_INI}.bak"
cp -f "${EA_INI}" "${EA_INI}.bak" && EA_INI="${EA_INI}.bak"

cd "$ROOT"
. "$VM_DIR"/scripts/.funcs.inc.sh
. "$VM_DIR"/scripts/.vars.inc.sh
. "$ROOT"/_rules/.init.rules.inc

find "$ROOT" -type f -name "*$1*.rule" -print0 | sort -z | while IFS= read -r -d '' rule_file; do
  echo "Testing $(basename ${rule_file} .rule)..."
  . "$rule_file"
done
echo $0 OK
