TIMEOFEXEC=1

if [ -f "/data/app/de.robv.android.xposed.installer/de.robv.android.xposed.installer.apk" ]; then
  test "$(cmp /data/app/de.robv.android.xposed.installer/de.robv.android.xposed.installer.apk $INSTALLER/system/app/XposedFramework/XposedFramework.apk)" && $WP_PRFX FOL/data/data/de.robv.android.xposed.installer
fi
test -d /magisk/xposed21 && rm -rf /magisk/xposed21
test -d /magisk/xposed22 && rm -rf /magisk/xposed22
test -d /magisk/xposed23 && rm -rf /magisk/xposed23
test -d /magisk/xposed24 && rm -rf /magisk/xposed24
test -d /magisk/xposed25 && rm -rf /magisk/xposed25

$MAGISK || POSTFSDATA=false