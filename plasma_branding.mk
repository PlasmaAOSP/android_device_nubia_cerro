# PlasmaAOSP visible branding for Voltage cerro.
# Keep PRODUCT_BRAND/MODEL spoof policy in voltage_cerro.mk; this only sets display names.

PLASMA_AOSP_VERSION ?= 1.0

# About / OTA-style display (Voltage version.mk reads these if set after inherit)
VOLTAGE_DISPLAY_VERSION := PlasmaAOSP-$(PLASMA_AOSP_VERSION)-$(VOLTAGE_BUILD_TYPE)
VOLTAGE_MOD_VERSION := $(TARGET_PRODUCT)-PlasmaAOSP-$(PLASMA_AOSP_VERSION)

PRODUCT_SYSTEM_PROPERTIES += \
    ro.plasmaaosp.version=$(PLASMA_AOSP_VERSION) \
    ro.plasmaaosp.build=$(VOLTAGE_DISPLAY_VERSION)

PRODUCT_PROPERTY_OVERRIDES += \
    ro.plasmaaosp.device=$(PRODUCT_DEVICE) \
    ro.plasma.build.status=社区版
