#
# Copyright (C) 2021-2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Inherit from cepheus device
$(call inherit-product, device/xiaomi/cepheus/device.mk)

PRODUCT_NAME := lineage_cepheus
PRODUCT_DEVICE := cepheus
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := MI 9

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="cepheus-user 11 RKQ1.200826.002 V12.5.1.0.RFAMIXM release-keys"

BUILD_FINGERPRINT := Xiaomi/cepheus/cepheus:11/RKQ1.200826.002/V12.5.1.0.RFAMIXM:user/release-keys
