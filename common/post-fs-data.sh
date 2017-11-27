DISABLE=/data/data/de.robv.android.xposed.installer/conf/disabled
MIRRDIR=/dev/magisk/mirror

[ -f $DISABLE ] && exit

mount -o rw,remount /
ln -s $SH/xposed.prop /xposed.prop
mount -o ro,remount /

test ! $(grep "minsdk=22" $SH/xposed.prop) && exit

# Cleanup
if [ -f $SH/lists ]; then
  for DIR  in `cat $SH/lists`; do
    rm -rf $SH$DIR 2>/dev/null
  done
fi
rm -f $SH/lists

for ODEX in `find $SYS -type f -name "*.odex*" 2>/dev/null`; do
  # Rename the odex files
  mkdir -p $SH${ODEX%/*}
  touch $SH${ODEX%/*}/.replace
  ln -s $MIRRDIR$ODEX $SH${ODEX}.xposed
  # Record so we can remove afterwards
  echo ${ODEX%/*} >> $SH/lists
done
for BOOT in `find $SYS/framework -type f -name "boot.*" 2>/dev/null`; do
  ln -s $MIRRDIR$BOOT $SH$BOOT 2>/dev/null
done
