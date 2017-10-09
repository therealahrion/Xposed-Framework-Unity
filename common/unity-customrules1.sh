# v DO NOT MODIFY v
# See instructions file for predefined variables
# User defined custom rules
# Can have multiple ones based on when you want them to be run
# You can create copies of this file and name is the same as this but with the next number after it (ex: unity-customrules2.sh)
# See instructions for TIMEOFEXEC values, do not remove it
# ^ DO NOT MODIFY ^
TIMEOFEXEC=2

ui_print "    Installing libs for $API API $ARCH device"
if [ "$MAGISK" == true ]; then
  for app_process in $INSTALLER/custom/$API/$ARCH/bin/app_process*; do
    sed -i 's/\/system\/xposed.prop\x0/\/xposed.prop\x0\x0\x0\x0\x0\x0\x0\x0/g' $app_process
  done
else
  test $API -ge 22 && find $SYS $VEN -type f -name '*.odex.gz' 2>/dev/null | while read f; do mv "$f" "$f.xposed"; done
fi

$CP_PRFX $INSTALLER/custom/$API/$ARCH/xposed.prop $UNITY/xposed.prop
$CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/app_process32 $UNITY$SYS/bin/app_process32
$CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/dex2oat $UNITY$SYS/bin/dex2oat
$CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/oatdump $UNITY$SYS/bin/oatdump
$CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/patchoat $UNITY$SYS/bin/patchoat
$CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libart.so $UNITY$SYS/lib/libart.so
$CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libart-compiler.so $UNITY$SYS/lib/libart-compiler.so
$CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libsigchain.so $UNITY$SYS/lib/libsigchain.so
$CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libxposed_art.so $UNITY$SYS/lib/libxposed_art.so
if $IS64BIT; then
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/app_process64 $UNITY$SYS/bin/app_process64
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libart.so $UNITY$SYS/lib64/libart.so
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libart-compiler.so $UNITY$SYS/lib64/libart-compiler.so
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libart-disassembler.so $UNITY$SYS/lib64/libart-disassembler.so
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libsigchain.so $UNITY$SYS/lib64/libsigchain.so
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libxposed_art.so $UNITY$SYS/lib64/libxposed_art.so
else
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libart-disassembler.so $UNITY$SYS/lib/libart-disassembler.so
fi
