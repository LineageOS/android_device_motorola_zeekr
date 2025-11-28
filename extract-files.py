#!/usr/bin/env -S PYTHONPATH=../../../tools/extract-utils python3
#
# SPDX-FileCopyrightText: 2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

from extract_utils.fixups_blob import (
    BlobFixupCtx,
    File,
    blob_fixup,
    blob_fixups_user_type,
)
from extract_utils.fixups_lib import lib_fixups
from extract_utils.main import (
    ExtractUtils,
    ExtractUtilsModule,
)
from extract_utils.tools import (
    llvm_objdump_path,
)
from extract_utils.utils import (
    run_cmd,
)

namespace_imports = [
    'vendor/motorola/sm8475-common',
    'hardware/motorola',
    'hardware/qcom-caf/sm8450',
    'vendor/qcom/opensource/commonsys-intf/display',
]


def blob_fixup_graphic_buffer_size(
    ctx: BlobFixupCtx,
    file: File,
    file_path: str,
    *args,
    **kwargs,
):
    for line in run_cmd(
        [
            llvm_objdump_path,
            '--disassemble-all',
            file_path,
        ]
    ).splitlines():
        line = line.split(maxsplit=5)
        if len(line) != 6:
            continue

        # The size of GraphicBuffer changed from 0x100 to 0xd30
        offset, _, instruction, register, value, _ = line
        if instruction == 'mov' and register[:-1] == 'w0' and value == '#0x100':
            with open(file_path, 'rb+') as f:
                f.seek(int(offset[:-1], 16))
                f.write(b'\x00\xa6\x81\x52')  # AArch64 mov w0, #0xd30


blob_fixups: blob_fixups_user_type = {
    (
        'vendor/lib64/camera/components/com.vidhance.node.ica.so',
        'vendor/lib64/camera/components/com.vidhance.node.processing.so',
    ): blob_fixup().call(
        blob_fixup_graphic_buffer_size,
        [
            '_ZN7android13GraphicBufferC1EjjijmNSt3__112basic_stringIcNS1_11char_traitsIcEENS1_9allocatorIcEEEE',
            '_ZN7android13GraphicBufferC1EPK13native_handleNS0_16HandleWrapMethodEjjijmj',
        ],
    ),
    'vendor/lib64/libcamximageformatutils.so': blob_fixup().replace_needed(
        'vendor.qti.hardware.display.config-V2-ndk_platform.so',
        'vendor.qti.hardware.display.config-V2-ndk.so',
    ),
    'vendor/lib64/nfc_nci.nqx.default.hw.so': blob_fixup().replace_needed(
        'libbase.so',
        'libbase-v33.so',
    ),
    (
        'vendor/lib64/camx.provider@2.4-impl.so',
        'vendor/lib64/camx.provider@2.5-legacy.so',
        'vendor/lib64/camx.provider@2.6-legacy.so',
        'vendor/lib64/camx.provider@2.7-legacy.so',
        'vendor/lib64/camx.device@3.5-ext-impl.so',
        'vendor/lib64/camx.device@3.6-ext-impl.so',
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
