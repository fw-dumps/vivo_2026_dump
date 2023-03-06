#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from 2026 device
$(call inherit-product, device/vivo/2026/device.mk)

PRODUCT_DEVICE := 2026
PRODUCT_NAME := lineage_2026
PRODUCT_BRAND := vivo
PRODUCT_MODEL := V2026
PRODUCT_MANUFACTURER := vivo

PRODUCT_GMS_CLIENTID_BASE := android-vivo-rev1

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="full_k65v1_64_bsp-user 11 RP1A.200720.012 eng.compil.20211012.154701 release-keys"

BUILD_FINGERPRINT := vivo/2026/2026:11/RP1A.200720.012/compiler1012154357:user/release-keys
