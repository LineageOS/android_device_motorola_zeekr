#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import lib_fixups
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)

namespace_imports = [
    'vendor/motorola/sm8475-common',
    'hardware/motorola',
    'hardware/qcom-caf/sm8450',
    'vendor/qcom/opensource/commonsys-intf/display',
]

blob_fixups: blob_fixups_user_type = {
    'vendor/lib64/libcamximageformatutils.so': blob_fixup().replace_needed(
        'vendor.qti.hardware.display.config-V2-ndk_platform.so',
        'vendor.qti.hardware.display.config-V2-ndk.so',
    ),
    'vendor/lib64/nfc_nci.nqx.default.hw.so': blob_fixup().replace_needed(
        'libbase.so',
        'libbase-v33.so',
    ),
    (
        'vendor/bin/hw/vendor.qti.camera.provider@2.7-service_64',
        'vendor/lib64/camx.device@3.4-ext-impl.so',
        'vendor/lib64/camx.device@3.5-ext-impl.so',
        'vendor/lib64/camx.device@3.6-ext-impl.so',
        'vendor/lib64/camx.provider@2.4-external.so',
        'vendor/lib64/camx.provider@2.4-impl.so',
        'vendor/lib64/camx.provider@2.4-legacy.so',
        'vendor/lib64/camx.provider@2.5-external.so',
        'vendor/lib64/camx.provider@2.5-legacy.so',
        'vendor/lib64/camx.provider@2.6-legacy.so',
        'vendor/lib64/camx.provider@2.7-legacy.so',
    ): blob_fixup().replace_needed(
        'libtinyxml2.so', 'libtinyxml2-v34.so'
    ),
}

module = ExtractUtilsModule(
    'zeekr',
    'motorola',
    blob_fixups=blob_fixups,
    lib_fixups=lib_fixups,
    namespace_imports=namespace_imports,
    add_generated_carriersettings=True,
)

if __name__ == '__main__':
    utils = ExtractUtils.device_with_common(module, 'sm8475-common', module.vendor)
    utils.run()
