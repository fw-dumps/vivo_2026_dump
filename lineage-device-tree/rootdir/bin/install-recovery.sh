#!/vendor/bin/sh
# added for checking whether if last normal-boot (after ota) finished or not      01/15/2019@chenyuqin
/vendor/bin/dd if=/dev/zero of=/dev/block/bootdevice/by-name/reserved bs=1 count=8 seek=3672072 conv=notrunc && log -t recovery "succeeded to clear last-normal-boot-retry-count" || log -t recovery "failed to clear last-normal-boot-retry-count"
/vendor/bin/dd if=/dev/zero of=/dev/block/bootdevice/by-name/reserved bs=1 count=8 seek=3672088 conv=notrunc && log -t recovery "succeeded to clear last-ota-to-boot-retry-count" || log -t recovery "failed to clear last-ota-to-boot-retry-count"
if ! applypatch --check EMMC:/dev/block/platform/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):100663296:5ea83aaed03f2bca64b963be168d73942913077e; then
  applypatch  \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/platform/bootdevice/by-name/boot$(getprop ro.boot.slot_suffix):100663296:6309b904b68c772672e667b07004bf27dc7cb9ea \
          --target EMMC:/dev/block/platform/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):100663296:5ea83aaed03f2bca64b963be168d73942913077e && \
      log -t recovery "Installing new recovery image: succeeded" || \
      log -t recovery "Installing new recovery image: failed"
else
  log -t recovery "Recovery image already installed"
fi
