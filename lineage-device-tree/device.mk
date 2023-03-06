#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Include GSI keys
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# Overlays
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := overseas

# Rootdir
PRODUCT_PACKAGES += \
    init.vivo.fingerprint.sh \
    init.vivo.fingerprint_restart_counter.sh \
    zramsize_reconfig.sh \
    install-recovery.sh \
    init.vivo.crashdata.sh \

PRODUCT_PACKAGES += \
    fstab.enableswap \
    init.connectivity.rc \
    init.factory.rc \
    meta_init.modem.rc \
    multi_init.rc \
    init.sensor_1_0.rc \
    factory_init.connectivity.rc \
    meta_init.project.rc \
    init.project.rc \
    init.mt6765.rc \
    init.modem.rc \
    factory_init.rc \
    factory_init.project.rc \
    meta_init.connectivity.rc \
    meta_init.rc \
    init.aee.rc \
    init.mt6765.usb.rc \
    init.ago.rc \
    init.recovery.wifi.rc \
    init.recovery.mt6765.rc \
    init.recovery.platform.rc \
    init.recovery.touch.rc \
    init.recovery.svc.rc \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.enableswap:$(TARGET_COPY_OUT_RAMDISK)/fstab.enableswap

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 29

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/vivo/2026/2026-vendor.mk)
