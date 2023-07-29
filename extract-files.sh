#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        vendor/lib64/libancbase_rt_fusion.so)
            ${PATCHELF} --set-soname libancbase_rt_fusion.so "${2}"
            ;;
        vendor/lib/libcamximageformatutils.so | vendor/lib64/libcamximageformatutils.so)
            ${PATCHELF} --replace-needed "vendor.qti.hardware.display.config-V2-ndk_platform.so" "vendor.qti.hardware.display.config-V2-ndk.so" "${2}"
            ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=zeekr
export DEVICE_COMMON=sm8475-common
export VENDOR=motorola

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
