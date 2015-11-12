#!/usr/bin/env bash

if [ ! "$1" ]; then
  echo "[ERROR] Missing parameter, usage is: $0 <directory to process>"
  exit 1
fi

set -e
type html2text || exit 1

TEMPORARY_FILE="README.md.new"
README_FILE="README.md"

for REPORT in $(find $1 -type f -name 'Report.htm' -print); do
  OUTPUT_PATH="$(dirname $(dirname $REPORT))/$TEMPORARY_FILE"
  echo -n "Appending $REPORT to $OUTPUT_PATH ...  "
  html2text $REPORT >> $OUTPUT_PATH && \
  echo "Done!"
done

echo -n "Renaming $TEMPORARY_FILE files to $README_FILE ...  "
find $1 -type f -name "$TEMPORARY_FILE" -execdir mv "$TEMPORARY_FILE" "$README_FILE" ';' && \
echo "Done!"
