# v DO NOT MODIFY v
# See instructions file for predefined variables
# User defined custom rules
# Can have multiple ones based on when you want them to be run
# You can create copies of this file and name is the same as this but with the next number after it (ex: unity-customrules2.sh)
# See instructions for TIMEOFEXEC values, do not remove it
# ^ DO NOT MODIFY ^
TIMEOFEXEC=4

if [ "$MAGISK" == false ]; then
  test $API -ge 22 && find $SYS $VEN -type f -name '*.odex.gz.xposed' 2>/dev/null | while read f; do mv "$f" "${f%.xposed}"; done
  set_permissions
fi
