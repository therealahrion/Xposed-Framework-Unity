#!/sbin/sh

for app_process in /storage/emulated/0/Android/data/ch.phcoder.jigit/files/repo/Xposed-Framework/custom/*/bin/app_process*; do
    echo "Patching $app_process"
    sed -i 's/\/system\/xposed.prop\x0/\/xposed.prop\x0\x0\x0\x0\x0\x0\x0\x0/g' $app_process
done
