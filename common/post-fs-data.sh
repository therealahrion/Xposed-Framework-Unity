DISABLE=/data/data/de.robv.android.xposed.installer/conf/disabled
MIRRDIR=/dev/magisk/mirror

[ -f $DISABLE ] && exit

mount -o rw,remount /
ln -s $MODPATH/xposed.prop /xposed.prop
mount -o ro,remount /

test ! "$(grep "minsdk=22" $MODPATH/xposed.prop)" && exit

# Cleanup
if [ -f $MODPATH/lists ]; then
  for DIR  in `cat $MODPATH/lists`; do
    rm -rf $MODPATH$DIR 2>/dev/null
  done
fi
rm -f $MODPATH/lists

for ODEX in `find $SYS -type f -name "*.odex*" 2>/dev/null`; do
  # Rename the odex files
  mkdir -p $MODPATH${ODEX%/*}
  touch $MODPATH${ODEX%/*}/.replace
  ln -s $MIRRDIR$ODEX $MODPATH${ODEX}.xposed
  # Record so we can remove afterwards
  echo ${ODEX%/*} >> $MODPATH/lists
done
for BOOT in `find $SYS/framework -type f -name "boot.*" 2>/dev/null`; do
  ln -s $MIRRDIR$BOOT $MODPATH$BOOT 2>/dev/null
done
