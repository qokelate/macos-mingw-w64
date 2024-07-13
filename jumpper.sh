#!/bin/zsh

[ -z "$MINGW_LOGFILE" ] && \
MINGW_LOGFILE="/tmp/$(basename "$0")-last-build.txt"

cmd="'$(dirname "$0")/jmp-$(basename "$0")'"

pass='0'
for a in "$@"; do
    [ "$pass" = '1' ] && {
        pass='0'
        continue
    }
    [ '-install_name' = "$a" ] && {
        pass='1'
        continue
    }
    cmd="$cmd '$a'"
done

eval "$cmd"
ecode="$?"
[ '0' = "$ecode" ] && echo "[SUCCE] $cmd\n" >>"$MINGW_LOGFILE"
[ '0' = "$ecode" ] || echo "[ERROR] error=$ecode, $cmd\n" >>"$MINGW_LOGFILE"
exit "$ecode"
