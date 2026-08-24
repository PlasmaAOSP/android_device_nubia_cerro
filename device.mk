#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from nubia sm8650-common
$(call inherit-product, device/nubia/sm8650-common/common.mk)

DEVICE_PATH := device/nubia/cerro

# Audio
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/audio/mixer_paths_pineapple_mtp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_pineapple/mixer_paths_pineapple_mtp.xml

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# Overlays
PRODUCT_PACKAGES += \
    SettingsProviderResCerro

# Inherit from proprietary targets
$(call inherit-product, vendor/nubia/cerro/cerro-vendor.mk)

# PlasmaOS ReSukiSU (user build; not userdebug) — packages also listed in voltage_cerro.mk
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/plasma_sukisu/plasma_sukisu.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/plasma_sukisu.rc \
    $(DEVICE_PATH)/plasma_sukisu/plasma_sukisu_sync.sh:$(TARGET_COPY_OUT_SYSTEM_EXT)/bin/plasma_sukisu_sync.sh

PRODUCT_PROPERTY_OVERRIDES += \
    persist.plasma.adb_root=1

PRODUCT_PACKAGES += \
    ksud \
    libadbroot
# PlasmaOS: CERRO_CAMERA_BOOTSTRAP
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/rootdir/bin/init.cerro.camera.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.cerro.camera.sh \
    $(DEVICE_PATH)/rootdir/etc/init.cerro.camera.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.cerro.camera.rc

