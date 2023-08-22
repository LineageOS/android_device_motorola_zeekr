#
# Copyright (C) 2023 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Boot animation
TARGET_SCREEN_HEIGHT := 2640
TARGET_SCREEN_WIDTH := 1080

# Screen
TARGET_SCREEN_DENSITY := 420

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := 400dpi
PRODUCT_AAPT_PREBUILT_DPI := xxxhdpi xxhdpi xhdpi hdpi

BOARD_SHIPPING_API_LEVEL := 31
PRODUCT_SHIPPING_API_LEVEL := 31

# Inherit from motorola sm8475-common
$(call inherit-product, device/motorola/sm8475-common/sm8475.mk)

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay-lineage

PRODUCT_PACKAGES += \
    DeviceApertureRes \
    FrameworksResDevice \
    LineageSystemUIDevice \
    SystemUIResDevice

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/sku_cape/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_cape/audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/sku_cape/mixer_paths_waipio_mtp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_cape/mixer_paths_waipio_mtp.xml \
    $(LOCAL_PATH)/configs/audio/sku_cape/resourcemanager_waipio_mtp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_cape/resourcemanager_waipio_mtp.xml \
    $(LOCAL_PATH)/configs/audio/sku_cape_qssi/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_cape_qssi/audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/configs/audio/audio_ext_spkr.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_ext_spkr.conf \
    $(LOCAL_PATH)/configs/audio/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    $(LOCAL_PATH)/configs/audio/microphone_characteristics.xml:$(TARGET_COPY_OUT_VENDOR)/etc/microphone_characteristics.xml \
    $(LOCAL_PATH)/configs/audio/usecaseKvManager.xml:$(TARGET_COPY_OUT_VENDOR)/etc/usecaseKvManager.xml

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.1.vendor \
    com.motorola.hardware.biometric.fingerprint@1.0.vendor

# Fold related configs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fold/device_state_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/devicestate/device_state_configuration.xml \
    $(LOCAL_PATH)/fold/display_id_4630947043778501761.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_id_4630947043778501761.xml \
    $(LOCAL_PATH)/fold/display_id_4630947043778501762.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_id_4630947043778501762.xml \
    $(LOCAL_PATH)/fold/display_layout_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_layout_configuration.xml

# Init
PRODUCT_PACKAGES += \
    init.mmi.overlay.rc

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc-service.nxp \
    com.android.nfc_extras \
    nqnfcinfo \
    Tag

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.hinge_angle.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.hinge_angle.xml \
    frameworks/native/data/etc/android.hardware.nfc.ese.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_ne/android.hardware.nfc.ese.xml \
    frameworks/native/data/etc/android.hardware.se.omapi.ese.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_ne/android.hardware.se.omapi.ese.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_dnp/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_nep/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_np/android.hardware.sensor.barometer.xml \
    $(LOCAL_PATH)/permissions/unavail.android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_dn/unavail.android.hardware.sensor.barometer.xml \
    $(LOCAL_PATH)/permissions/unavail.android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_n/unavail.android.hardware.sensor.barometer.xml \
    $(LOCAL_PATH)/permissions/unavail.android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_ne/unavail.android.hardware.sensor.barometer.xml

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# VINTF
DEVICE_MANIFEST_FILE += device/motorola/zeekr/vintf/manifest.xml
ODM_MANIFEST_SKUS += dnp dn nep ne np n
ODM_MANIFEST_DNP_FILES := $(LOCAL_PATH)/vintf/manifest_dn.xml
ODM_MANIFEST_DN_FILES  := $(LOCAL_PATH)/vintf/manifest_dn.xml
ODM_MANIFEST_NEP_FILES := $(LOCAL_PATH)/vintf/manifest_ne.xml \
    device/motorola/sm8475-common/vintf/manifest_ss.xml
ODM_MANIFEST_NE_FILES  := $(LOCAL_PATH)/vintf/manifest_ne.xml \
    device/motorola/sm8475-common/vintf/manifest_ss.xml
ODM_MANIFEST_NP_FILES  := $(LOCAL_PATH)/vintf/manifest_n.xml \
    device/motorola/sm8475-common/vintf/manifest_ss.xml
ODM_MANIFEST_N_FILES   := $(LOCAL_PATH)/vintf/manifest_n.xml \
    device/motorola/sm8475-common/vintf/manifest_ss.xml

# Inherit from vendor blobs
$(call inherit-product, vendor/motorola/zeekr/zeekr-vendor.mk)
