function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function toutf() {
	if [ -z "$1" ]; then
		echo "Uso: toutf archivo.srt"
		return 1
	fi

	local file="$1"

	if [ ! -f "$file" ]; then
		echo "No se encontró: $file"
		return 1
	fi

	local charset
	charset=$(file -I "$file" | sed -n 's/.*charset=//p')

	if [ "$charset" = "utf-8" ]; then
		echo "$file ya está en UTF-8."
		return 0
	fi

	local from
	case "$charset" in
		iso-8859-1|ISO-8859-1) from="ISO-8859-1" ;;
		windows-1252|us-ascii) from="WINDOWS-1252" ;;
		*) from="WINDOWS-1252" ;;
	esac

	iconv -f "$from" -t UTF-8 "$file" > "${file}.tmp" \
		&& mv "${file}.tmp" "$file" \
		&& echo "$file convertido de $charset a UTF-8"
}
