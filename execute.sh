#!/bin/bash

git remote set-url origin https://sennasama:${GH_TOKEN}@github.com/sennasama/farmAct.git
git config user.email "oyasumi.senko@gmail.com"
git config user.name "sennasama"

WORDS=("update" "fix" "patch" "sync" "refresh" "tweak" "adjust" "clean")
FILES=("data.txt" "log.txt" "notes.txt" "cache.txt" "temp.txt")

# Backfill 365 hari dulu
for i in $(seq 1 365); do
  HOUR=$((RANDOM % 12 + 8))
  MIN=$((RANDOM % 60))
  SEC=$((RANDOM % 60))
  DATE=$(date -d "$i days ago" +"%Y-%m-%dT${HOUR}:${MIN}:${SEC}")
  FILENAME=${FILES[$((RANDOM % ${#FILES[@]}))]}
  echo "$DATE - $RANDOM" >> $FILENAME
  WORD=${WORDS[$((RANDOM % ${#WORDS[@]}))]}
  GIT_AUTHOR_DATE="$DATE" GIT_COMMITTER_DATE="$DATE" \
    git commit -am "chore: $WORD $i" --allow-empty
  echo "Done: $DATE"
done

git push origin main
echo "Backfill selesai, masuk loop mode~!!"

# Loop realtime abis backfill
while true; do
  FILENAME=${FILES[$((RANDOM % ${#FILES[@]}))]}
  echo "$(date) - $RANDOM" >> $FILENAME
  WORD=${WORDS[$((RANDOM % ${#WORDS[@]}))]}
  git add .
  git commit -m "chore: $WORD $(date +%H:%M:%S)"
  git push origin main
  SLEEP=$((RANDOM % 300 + 180))
  echo "Sleeping ${SLEEP}s..."
  sleep $SLEEP
done
