#!/usr/bin/env bash

# 16 ANSI colors with standard names
ansi_names=(
  black red green yellow blue magenta cyan white
  bright-black bright-red bright-green bright-yellow
  bright-blue bright-magenta bright-cyan bright-white
)

echo "=== 16 ANSI Colors ==="
for i in "${!ansi_names[@]}"; do
  # Auto-contrast: white text for dark bgs (0-7), black for bright bgs (8-15)
  fg=$(( i < 8 ? 15 : 0 ))
  printf "\e[48;5;%sm\e[38;5;%sm %3s %-16s \e[0m" "$i" "$fg" "$i" "${ansi_names[$i]}"
  (( (i+1) % 4 == 0 )) && echo
done

echo -e "\n=== 256-Color Palette ==="
for i in {0..255}; do
  # Smart contrast calculation
  if (( i <= 7 )); then
    fg=15
  elif (( i <= 15 )); then
    fg=0
  elif (( i <= 231 )); then
    # 6x6x6 RGB cube: calculate approximate brightness
    r=$(( (i - 16) / 36 ))
    g=$(( ((i - 16) % 36) / 6 ))
    b=$(( (i - 16) % 6 ))
    if (( r + g + b > 9 )); then fg=0; else fg=15; fi
  else
    # Grayscale ramp (232-255)
    if (( i >= 244 )); then fg=0; else fg=15; fi
  fi

  printf "\e[48;5;%sm\e[38;5;%sm %3s \e[0m" "$i" "$fg" "$i"
  (( (i+1) % 16 == 0 )) && echo
done
echo
