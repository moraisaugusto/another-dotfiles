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


# wrap pi (pi.dev) into a bwrap
pi() {
  local pi_bin
  pi_bin=$(whence -p pi)

  if [[ -z "$pi_bin" ]]; then
    echo "Error: real 'pi' binary not found in PATH." >&2
    return 1
  fi

  if [[ "${PWD}" == "/" ]]; then
    echo "Error: Refusing to run pi at system root." >&2
    return 1
  fi

  bwrap \
    --ro-bind /usr /usr \
    --ro-bind /lib /lib \
    --ro-bind /lib64 /lib64 \
    --ro-bind /bin /bin \
    --ro-bind /etc/resolv.conf /etc/resolv.conf \
    --ro-bind /etc/ssl /etc/ssl \
    --ro-bind /etc/hosts /etc/hosts \
    --ro-bind /etc/passwd /etc/passwd \
    --ro-bind /etc/group /etc/group \
    --tmpfs /home \
    --tmpfs /sandbox-home \
    --setenv HOME /sandbox-home \
    --ro-bind-try "${HOME}/.gitconfig" /sandbox-home/.gitconfig \
    --ro-bind-try "${HOME}/.local" /sandbox-home/.local \
    --ro-bind-try "${HOME}/.npm-global" /sandbox-home/.npm-global \
    --bind-try "${HOME}/.pi" /sandbox-home/.pi \
    --setenv PATH "/sandbox-home/.npm-global/bin:/sandbox-home/.local/bin:/usr/local/bin:/usr/bin:/bin" \
    --dev /dev \
    --dev-bind /dev/shm /dev/shm \
    --tmpfs /tmp \
    --proc /proc \
    --bind "${PWD}" /workspace \
    --chdir /workspace \
    --setenv PWD /workspace \
    --unshare-all \
    --share-net \
    --die-with-parent \
    "/sandbox-home/.npm-global/bin/pi" "$@"
}
