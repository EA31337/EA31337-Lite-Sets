#!/usr/bin/env bash
set -ex
type git
[ $# -ne 2 ] && { echo "Usage: $0 (branch) (message)"; exit 1; }
ROOT="$(git rev-parse --show-toplevel)"
CHK="$1"
MSG="$2"

set -x
cd "$ROOT"
git checkout -mB "$CHK" origin/master
git add -vA *.txt *.gif *.md
git commit -vm "$MSG" -a && git push -fv origin "$CHK"
exit
echo "$0 done."
