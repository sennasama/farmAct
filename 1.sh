#!/bin/bash
# runner.sh

while true; do
  if [ -z "$GH_TOKEN" ]; then
    read -p "Masukkin token baru: " GH_TOKEN
    export GH_TOKEN
  fi

  # Jalanin execute.sh, tangkep output
  ./exe.sh
  EXIT=$?

  # Cek kalau gagal karena auth
  if [ $EXIT -ne 0 ]; then
    echo "Token expired/invalid, minta token baru~!!"
    unset GH_TOKEN  # reset token, loop lagi minta input
  else
    echo "Selesai normal, loop lagi~!!"
  fi
done
