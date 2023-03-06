#!/bin/bash

cat boot.img.* 2>/dev/null >> boot.img
rm -f boot.img.* 2>/dev/null
cat bootimg/01_dtbdump_MT6765.dtb.* 2>/dev/null >> bootimg/01_dtbdump_MT6765.dtb
rm -f bootimg/01_dtbdump_MT6765.dtb.* 2>/dev/null
cat recovery.img.* 2>/dev/null >> recovery.img
rm -f recovery.img.* 2>/dev/null
cat product/app/Photos/Photos.apk.* 2>/dev/null >> product/app/Photos/Photos.apk
rm -f product/app/Photos/Photos.apk.* 2>/dev/null
cat product/app/WebViewGoogle/WebViewGoogle.apk.* 2>/dev/null >> product/app/WebViewGoogle/WebViewGoogle.apk
rm -f product/app/WebViewGoogle/WebViewGoogle.apk.* 2>/dev/null
cat product/app/YouTube/YouTube.apk.* 2>/dev/null >> product/app/YouTube/YouTube.apk
rm -f product/app/YouTube/YouTube.apk.* 2>/dev/null
cat product/priv-app/GmsCore/GmsCore.apk.* 2>/dev/null >> product/priv-app/GmsCore/GmsCore.apk
rm -f product/priv-app/GmsCore/GmsCore.apk.* 2>/dev/null
cat product/priv-app/Velvet/Velvet.apk.* 2>/dev/null >> product/priv-app/Velvet/Velvet.apk
rm -f product/priv-app/Velvet/Velvet.apk.* 2>/dev/null
cat system/system/app/VivoCamera/VivoCamera.apk.* 2>/dev/null >> system/system/app/VivoCamera/VivoCamera.apk
rm -f system/system/app/VivoCamera/VivoCamera.apk.* 2>/dev/null
cat system/system/app/VivoThemeRes/VivoThemeRes.apk.* 2>/dev/null >> system/system/app/VivoThemeRes/VivoThemeRes.apk
rm -f system/system/app/VivoThemeRes/VivoThemeRes.apk.* 2>/dev/null
cat system/system/app/VivoGallery/VivoGallery.apk.* 2>/dev/null >> system/system/app/VivoGallery/VivoGallery.apk
rm -f system/system/app/VivoGallery/VivoGallery.apk.* 2>/dev/null
cat system/system/app/VivoThemeRes_T1/VivoThemeRes_T1.apk.* 2>/dev/null >> system/system/app/VivoThemeRes_T1/VivoThemeRes_T1.apk
rm -f system/system/app/VivoThemeRes_T1/VivoThemeRes_T1.apk.* 2>/dev/null
cat system/system/app/Gboard/Gboard.apk.* 2>/dev/null >> system/system/app/Gboard/Gboard.apk
rm -f system/system/app/Gboard/Gboard.apk.* 2>/dev/null
cat system/system/apex/com.android.vndk.current.apex.* 2>/dev/null >> system/system/apex/com.android.vndk.current.apex
rm -f system/system/apex/com.android.vndk.current.apex.* 2>/dev/null
cat system/system/apex/com.android.art.release.apex.* 2>/dev/null >> system/system/apex/com.android.art.release.apex
rm -f system/system/apex/com.android.art.release.apex.* 2>/dev/null
cat system/system/framework/vivo-res.apk.* 2>/dev/null >> system/system/framework/vivo-res.apk
rm -f system/system/framework/vivo-res.apk.* 2>/dev/null
cat system/system/priv-app/Settings/Settings.apk.* 2>/dev/null >> system/system/priv-app/Settings/Settings.apk
rm -f system/system/priv-app/Settings/Settings.apk.* 2>/dev/null
