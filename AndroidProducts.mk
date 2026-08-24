#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/lineage_cerro.mk

# ArtistAOSP VoltageOS 17
PRODUCT_MAKEFILES += $(LOCAL_DIR)/voltage_cerro.mk
COMMON_LUNCH_CHOICES += voltage_cerro-cp2a-userdebug
