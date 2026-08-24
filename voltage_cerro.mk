#
# PlasmaAOSP on VoltageOS 17 (cp2a) — cerro product
# Lunch: voltage_cerro-cp2a-userdebug
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

$(call inherit-product, device/nubia/cerro/device.mk)

$(call inherit-product, vendor/voltage/config/common_full_phone.mk)

# PlasmaAOSP display branding (after Voltage common)
$(call inherit-product, $(LOCAL_PATH)/plasma_branding.mk)

TARGET_SCREEN_HEIGHT := 2480
TARGET_SCREEN_WIDTH := 1116

PRODUCT_BRAND := nubia
PRODUCT_DEVICE := cerro
PRODUCT_MANUFACTURER := nubia
PRODUCT_MODEL := NX721J
PRODUCT_NAME := voltage_cerro
PRODUCT_SYSTEM_DEVICE := PQ83A01
PRODUCT_SYSTEM_NAME := PQ83A01-UN

PRODUCT_GMS_CLIENTID_BASE := android-zte

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="PQ83A01-UN PQ83A01 15 AQ3A.240812.002 20250916.013811 release-keys" \
    BuildFingerprint=nubia/PQ83A01-UN/PQ83A01:15/AQ3A.240812.002/20250916.013811:user/release-keys \
    DeviceName=$(PRODUCT_SYSTEM_DEVICE) \
    DeviceProduct=$(PRODUCT_SYSTEM_NAME)

# PlasmaOS ReSukiSU (ksud + libadbroot; user installs official Manager APK)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/plasma_sukisu/plasma_sukisu.rc:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/init/plasma_sukisu.rc \
    $(LOCAL_PATH)/plasma_sukisu/plasma_sukisu_sync.sh:$(TARGET_COPY_OUT_SYSTEM_EXT)/bin/plasma_sukisu_sync.sh

PRODUCT_PROPERTY_OVERRIDES += \
    persist.plasma.adb_root=1 \
    persist.plasma.root_enabled=1

PRODUCT_PACKAGES += \
    ksud \
    libadbroot \
    PowerLayers
