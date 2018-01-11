TIMEOFEXEC=1

if [ -f "/data/app/de.robv.android.xposed.installer/de.robv.android.xposed.installer.apk" ]; then
  test "$(cmp /data/app/de.robv.android.xposed.installer/de.robv.android.xposed.installer.apk $INSTALLER/system/app/XposedFramework/XposedFramework.apk)" && $WP_PRFX FOL/data/data/de.robv.android.xposed.installer
fi
test -d /magisk/xposed21 && rm -rf /magisk/xposed21
test -d /magisk/xposed22 && rm -rf /magisk/xposed22
test -d /magisk/xposed23 && rm -rf /magisk/xposed23
test -d /magisk/xposed24 && rm -rf /magisk/xposed24
test -d /magisk/xposed25 && rm -rf /magisk/xposed25
test -d /magisk/xposed26 && rm -rf /magisk/xposed26
test -d /magisk/xposed27 && rm -rf /magisk/xposed27

cp -rf $INSTALLER/custom/$API/$ARCH/* $INSTALLER/system

if $MAGISK; then 
  mv -f $INSTALLER/system/bin/app_process32_magisk $INSTALLER/system/bin/app_process32
  $IS64BIT && mv -f $INSTALLER/system/bin/app_process64_magisk $INSTALLER/system/bin/app_process64
  rm -f $INSTALLER/system/xposed.prop
  $CP_NBPRFX $INSTALLER/custom/$API/$ARCH/xposed.prop $MODPATH/xposed.prop
else
  rm -f $INSTALLER/system/bin/app_process32_magisk
  $IS64BIT && rm -f $INSTALLER/system/bin/app_process64_magisk
  POSTFSDATA=false
  test $API -ge 22 && find -L $SYS -type f -name '*.odex.gz' 2>/dev/null | while read f; do mv "$f" "$f.xposed"; done
fi

if $OREONEW; then
  cp_ch $INSTALLER/custom/XposedBridge.jar $INSTALLER/system/framework/XposedBridge.jar
  cp_ch $INSTALLER/custom/XposedInstaller.apk $INSTALLER/system/app/XposedInstaller/XposedInstaller.apk
  sed -i "s/version=.*/version=v90-beta1/" $INSTALLER/module.prop
fi
