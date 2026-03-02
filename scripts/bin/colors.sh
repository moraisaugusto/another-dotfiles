
#!/bin/bash
echo "Standard colors (0-15):"
for i in {0..15}; do
    printf "\e[48;5;${i}m\e[38;5;$((i>7?0:15))m %3d \e[0m" $i
    [ $((($i + 1) % 8)) == 0 ] && echo
done

echo -e "\n216 colors (16-231):"
for i in {16..231}; do
    printf "\e[48;5;${i}m\e[38;5;0m %3d \e[0m" $i
    [ $((($i - 15) % 6)) == 0 ] && echo
done

echo -e "\nGrayscale (232-255):"
for i in {232..255}; do
    printf "\e[48;5;${i}m\e[38;5;$((i<244?15:0))m %3d \e[0m" $i
done
echo
The escape sequences work as follows:

\e[48;5;${i}m sets the background color
\e[38;5;${i}m sets the foreground color
\e[0m resets colors back to default
The 48;5; and 38;5; indicate 256-color mode
Save any of these as a .sh file, make it executable with chmod +x filename.sh, and run it to see all 256 colors displayed in your terminal.





