#█▓▒░ disk info
function disks() {
	# echo
	function _e() {
		title=$(echo "$1" | sed 's/./& /g')
		echo "
\033[0;31m╓─────\033[0;35m ${title}
\033[0;31m╙────────────────────────────────────── ─ ─"
	}
	# loops
	function _l() {
		X=$(printf '\033[0m')
		G=$(printf '\033[0;32m')
		R=$(printf '\033[0;35m')
		C=$(printf '\033[0;36m')
		W=$(printf '\033[0;37m')
		i=0;
		while IFS= read -r line || [[ -n $line ]]; do
			if [[ $i == 0 ]]; then
				echo "${G}${line}${X}"
			else
				if [[ "$line" == *"%"* ]]; then
					percent=$(echo "$line" | awk '{ print $5 }' | sed 's!%!!')
					color=$W
					((percent >= 75)) && color=$C
					((percent >= 90)) && color=$R
					line=$(echo "$line" | sed "s/${percent}%/${color}${percent}%${W}/")
				fi
				echo "${W}${line}${X}" | sed "s/\([─└├┌┐└┘├┤┬┴┼]\)/${R}\1${W}/g; s! \(/.*\)! ${C}\1${W}!g;"
			fi
			i=$((i+1))
		done < <(printf '%s' "$1")
	}
	# outputs
	m=$(lsblk -a | grep -v loop)
	_e "mount.points"
	_l "$m"
	d=$(df -h)
	_e "disk.usage"
	_l "$d"
	s=$(swapon --show)
	_e "swaps"
	_l "$s"
}
