# v DO NOT MODIFY v
# Only predefined variables for this script are: $SYS, $VEN, $MAGISK, and $AMLPATH
# Add any script logic you want run here (post-fs-data in magisk and normal boot time scripts otherwise)
# ^ DO NOT MODIFY ^
MODDIR=${0%/*}
DISABLE=/data/data/de.robv.android.xposed.installer/conf/disabled
MIRRDIR=/dev/magisk/mirror

[ -f $DISABLE ] && exit

IS22=false
case $MODDIR in
  *xposed_22* )
    IS22=true
    ;;
esac

mount -o rw,remount /
ln -s $MODDIR/xposed.prop /xposed.prop
mount -o ro,remount /

! $IS22 && exit

# Cleanup
if [ -f $MODDIR/lists ]; then
  for dir in `cat $MODDIR/lists`; do
    rm -rf $MODDIR$dir 2>/dev/null
  done
fi
rm -f $MODDIR/lists

for ODEX in `find /system -type f -name "*.odex*" 2>/dev/null`; do
  # Rename the odex files
  mkdir -p $MODDIR${ODEX%/*}
  touch $MODDIR${ODEX%/*}/.replace
  ln -s $MIRRDIR$ODEX $MODDIR${ODEX}.xposed
  # Record so we can remove afterwards
  echo ${ODEX%/*} >> $MODDIR/lists
done
for BOOT in `find /system/framework -type f -name "boot.*" 2>/dev/null`; do
  ln -s $MIRRDIR$BOOT $MODDIR$BOOT 2>/dev/null
done
