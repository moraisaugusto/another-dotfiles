#█▓▒░ disk info
# disks() and pi() need lsblk/swapon and bwrap, which are Linux-only.
if [[ $OSTYPE == linux* ]]; then
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
fi

# extract any common archive format
extract() {
  if (( $# == 0 )); then
    echo "Usage: extract <archive> [archive ...]" >&2
    return 1
  fi

  local f rc=0
  for f in "$@"; do
    if [[ ! -f "$f" ]]; then
      echo "extract: '$f' is not a file" >&2
      rc=1
      continue
    fi
    case "${f:l}" in
      *.tar.gz|*.tgz)   tar xf "$f" ;;
      *.tar.bz2|*.tbz2) tar xf "$f" ;;
      *.tar.xz|*.txz)   tar xf "$f" ;;
      *.tar.zst)        tar xf "$f" ;;
      *.tar)            tar xf "$f" ;;
      *.gz)             gunzip -k "$f" ;;
      *.bz2)            bunzip2 -k "$f" ;;
      *.xz)             unxz -k "$f" ;;
      *.zst)            unzstd "$f" ;;
      *.zip)            unzip "$f" ;;
      *.7z)             7z x "$f" ;;
      *.rar)            unrar x "$f" ;;
      *)
        echo "extract: unknown archive format: '$f'" >&2
        rc=1
        continue
        ;;
    esac || rc=$?
  done
  return $rc
}
