#!/bin/bash

# Hapus token dari script, baca dari env

git remote set-url origin https://sennasama:${GH_TOKEN}@github.com/sennasama/farmAct.git

git config user.email "oyasumi.senko@gmail.com"

git config user.name "sennasama"

WORDS=("update" "fix" "patch" "sync" "refresh" "tweak" "adjust" "clean")

while true; do

  FILENAME="file_$((RANDOM % 10)).txt"

  echo "$(date) - $RANDOM" >> $FILENAME

  WORD=${WORDS[$((RANDOM % ${#WORDS[@]}))]}

  git add .

  git commit -m "chore: $WORD $(date +%H:%M:%S)"

  git push origin main

  SLEEP=$((RANDOM % 1 + 11))

  echo "Sleeping ${SLEEP}s..."

  sleep $SLEEP

done
