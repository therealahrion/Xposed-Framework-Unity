TIMEOFEXEC=1

if [ -f "/data/app/de.robv.android.xposed.installer/de.robv.android.xposed.installer.apk" ]; then
  test "$(cmp /data/app/de.robv.android.xposed.installer/de.robv.android.xposed.installer.apk $INSTALLER/system/app/XposedFramework/XposedFramework.apk)" && $WP_PRFX FOL/data/data/de.robv.android.xposed.installer
fi
