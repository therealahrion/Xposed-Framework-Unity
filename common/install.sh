ui_print "   Decompressing files..."
tar -xf $INSTALLER/custom/$API.tar.xz -C $INSTALLER/custom 2>/dev/null

rm -rf /data/app/de.robv.android.xposed.installer /magisk/xposed* /sbin/.core/img/xposed*
if [ -f "/data/app/de.robv.android.xposed.installer/de.robv.android.xposed.installer.apk" ]; then
  [ "$(cmp /data/app/de.robv.android.xposed.installer/de.robv.android.xposed.installer.apk $INSTALLER/system/app/XposedFramework/XposedFramework.apk)" ] && rm -rf /data/data/de.robv.android.xposed.installer
fi

cp -rf $INSTALLER/custom/$API/$ARCH/* $INSTALLER/system

if $MAGISK && ! $SYSOVERRIDE; then 
  mv -f $INSTALLER/system/bin/app_process32_magisk $INSTALLER/system/bin/app_process32
  $IS64BIT && mv -f $INSTALLER/system/bin/app_process64_magisk $INSTALLER/system/bin/app_process64
  rm -f $INSTALLER/system/xposed.prop
  cp_ch -n $INSTALLER/custom/$API/$ARCH/xposed.prop $UNITY/xposed.prop
else
  rm -f $INSTALLER/system/bin/app_process32_magisk
  $IS64BIT && rm -f $INSTALLER/system/bin/app_process64_magisk
  POSTFSDATA=false
  [ $API -ge 22 ] && find -L $SYS -type f -name '*.odex.gz' 2>/dev/null | while read f; do mv "$f" "$f.xposed"; done
fi

if [ $API -ge 26 ]; then
  cp -f $INSTALLER/custom/XposedBridge.jar $INSTALLER/system/framework/XposedBridge.jar
  sed -i "s/v89//" $INSTALLER/module.prop
else
  sed -i "s/v90b3//" $INSTALLER/module.prop
fi
