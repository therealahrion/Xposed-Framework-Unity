TIMEOFEXEC=4

if [ "$MAGISK" == false ]; then
  test $API -ge 22 && find -L $SYS -type f -name '*.odex.gz.xposed' 2>/dev/null | while read f; do mv "$f" "${f%.xposed}"; done
  set_permissions
fi
