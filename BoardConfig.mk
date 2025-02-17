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

DEVICE_PATH := device/motorola/zeekr

# Inherit from motorola sm8475-common
include device/motorola/sm8475-common/BoardConfigCommon.mk

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := zeekr

# HIDL
DEVICE_MANIFEST_CAPE_FILES += $(DEVICE_PATH)/manifests/manifest_zeekr.xml
ODM_MANIFEST_SKUS += dnp dn nep ne np n
ODM_MANIFEST_DNP_FILES := $(DEVICE_PATH)/manifests/manifest_dnp.xml
ODM_MANIFEST_DN_FILES  := $(DEVICE_PATH)/manifests/manifest_dn.xml
ODM_MANIFEST_NEP_FILES := $(DEVICE_PATH)/manifests/manifest_nep.xml $(COMMON_PATH)/manifest_cape_ss.xml
ODM_MANIFEST_NE_FILES  := $(DEVICE_PATH)/manifests/manifest_ne.xml $(COMMON_PATH)/manifest_cape_ss.xml
ODM_MANIFEST_NP_FILES  := $(DEVICE_PATH)/manifests/manifest_np.xml $(COMMON_PATH)/manifest_cape_ss.xml
ODM_MANIFEST_N_FILES   := $(DEVICE_PATH)/manifests/manifest_n.xml $(COMMON_PATH)/manifest_cape_ss.xml

# Kernel
TARGET_KERNEL_CONFIG += \
	vendor/ext_config/moto-waipio-zeekr.config

# Partitions
ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 3318226944
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE := 873680896
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 916299776
endif
BOARD_MOT_DP_GROUP_SIZE := 9483321344 # ( BOARD_SUPER_PARTITION_SIZE - 4MB )
BOARD_SUPER_PARTITION_SIZE := 9487515648

# Properties
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# Recovery
TARGET_RECOVERY_UI_MARGIN_HEIGHT := 90

# Security
BOOT_SECURITY_PATCH := 2024-05-01
VENDOR_SECURITY_PATCH := 2024-05-01

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Verified Boot
BOARD_AVB_ROLLBACK_INDEX := 14
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := 14

# inherit from the proprietary version
include vendor/motorola/zeekr/BoardConfigVendor.mk
