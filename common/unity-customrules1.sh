# v DO NOT MODIFY v
# See instructions file for predefined variables
# User defined custom rules
# Can have multiple ones based on when you want them to be run
# You can create copies of this file and name is the same as this but with the next number after it (ex: unity-customrules2.sh)
# See instructions for TIMEOFEXEC values, do not remove it
# ^ DO NOT MODIFY ^
TIMEOFEXEC=2

if [ "$MAGISK" == true ]; then
  for app_process in $INSTALLER/custom/*/bin/app_process*; do
      sed -i 's/\/system\/xposed.prop\x0/\/xposed.prop\x0\x0\x0\x0\x0\x0\x0\x0/g' $app_process
  done
fi

ui_print "    Installing libs for $ARCH device"
$CP_PRFX $INSTALLER/custom/$ARCH/xposed.prop $UNITY/xposed.prop
$CP_PRFX $INSTALLER/custom/$ARCH/framework/XposedBridge.jar $UNITY$SYS/framework/XposedBridge.jar
$CP_PRFX $INSTALLER/custom/$ARCH/bin/app_process32_xposed $UNITY$SYS/bin/app_process32 0755
$CP_PRFX $INSTALLER/custom/$ARCH/bin/dex2oat $UNITY$SYS/bin/dex2oat 0755
$CP_PRFX $INSTALLER/custom/$ARCH/bin/oatdump $UNITY$SYS/bin/oatdump 0755
$CP_PRFX $INSTALLER/custom/$ARCH/bin/patchoat $UNITY$SYS/bin/patchoat 0755
$CP_PRFX $INSTALLER/custom/$ARCH/lib/libart.so $UNITY$SYS/lib/libart.so
$CP_PRFX $INSTALLER/custom/$ARCH/lib/libart-compiler.so $UNITY$SYS/lib/libart-compiler.so
$CP_PRFX $INSTALLER/custom/$ARCH/lib/libsigchain.so $UNITY$SYS/lib/libsigchain.so
$CP_PRFX $INSTALLER/custom/$ARCH/lib/libxposed_art.so $UNITY$SYS/lib/libxposed_art.so
if [ $IS64BIT ]; then
  $CP_PRFX $INSTALLER/custom/$ARCH/bin/app_process64_xposed $UNITY$SYS/bin/app_process64 0755
  $CP_PRFX $INSTALLER/custom/$ARCH/lib64/libart.so $UNITY$SYS/lib64/libart.so
  $CP_PRFX $INSTALLER/custom/$ARCH/lib64/libart-compiler.so $UNITY$SYS/lib64/libart-compiler.so
  $CP_PRFX $INSTALLER/custom/$ARCH/lib64/libart-disassembler.so $UNITY$SYS/lib64/libart-disassembler.so
  $CP_PRFX $INSTALLER/custom/$ARCH/lib64/libsigchain.so $UNITY$SYS/lib64/libsigchain.so
  $CP_PRFX $INSTALLER/custom/$ARCH/lib64/libxposed_art.so $UNITY$SYS/lib64/libxposed_art.so
else
  $CP_PRFX $INSTALLER/custom/$ARCH/lib/libart-disassembler.so $UNITY$SYS/lib/libart-disassembler.so
fi
