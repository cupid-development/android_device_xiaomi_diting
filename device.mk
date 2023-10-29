#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from xiaomi sm8450-common
$(call inherit-product, device/xiaomi/sm8450-common/common.mk)

# Inherit from the proprietary version
$(call inherit-product, vendor/xiaomi/diting/diting-vendor.mk)

# Init scripts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.diting.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.diting.rc

# Overlay
PRODUCT_PACKAGES += \
    ApertureResDiting \
    FrameworksResDiting \
    NfcResDiting \
    SettingsProviderResDiting \
    SettingsProviderResDitingCN \
    SettingsResDiting \
    SystemUIResDiting \
    WifiResDiting \
    WifiResDitingCN

# Sensors
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
