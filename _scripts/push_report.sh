#!/usr/bin/env bash
set -ex
type git
[ $# -ne 2 ] && { echo "Usage: $0 (branch) (message)"; exit 1; }
ROOT="$(git rev-parse --show-toplevel)"
CHK="$1"
MSG="$2"

git stash
git checkout master
git checkout -b "$CHK"
git commit -m "$MSG" -a
git stash pop
echo git push origin "$CHK"
echo "$0 done."
