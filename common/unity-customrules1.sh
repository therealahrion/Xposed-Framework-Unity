TIMEOFEXEC=3

if [ "$MAGISK" == true ]; then
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/xposed.prop $MODPATH/xposed.prop
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/app_process32_magisk $SYS/bin/app_process32
  $IS64BIT && $CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/app_process64_magisk $SYS/bin/app_process64
else
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/xposed.prop $SYS/xposed.prop
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/app_process32 $SYS/bin/app_process32
  $IS64BIT && $CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/app_process64 $SYS/bin/app_process64
  test $API -ge 22 && find $SYS $VEN -type f -name '*.odex.gz' 2>/dev/null | while read f; do mv "$f" "$f.xposed"; done
fi
$CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/dex2oat $SYS/bin/dex2oat
$CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/oatdump $SYS/bin/oatdump
$CP_PRFX $INSTALLER/custom/$API/$ARCH/bin/patchoat $SYS/bin/patchoat
$CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libart.so $SYS/lib/libart.so
$CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libart-compiler.so $SYS/lib/libart-compiler.so
$CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libsigchain.so $SYS/lib/libsigchain.so
$CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libxposed_art.so $SYS/lib/libxposed_art.so
if $IS64BIT; then
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libart.so $SYS/lib64/libart.so
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libart-compiler.so $SYS/lib64/libart-compiler.so
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libart-disassembler.so $SYS/lib64/libart-disassembler.so
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libsigchain.so $SYS/lib64/libsigchain.so
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib64/libxposed_art.so $SYS/lib64/libxposed_art.so
else
  $CP_PRFX $INSTALLER/custom/$API/$ARCH/lib/libart-disassembler.so $SYS/lib/libart-disassembler.so
fi
