#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
        vendor/etc/camera/pureView_parameter.xml)
            [ "$2" = "" ] && return 0
            sed -i 's/=\([0-9]\+\)>/="\1">/g' "${2}"
            ;;
        vendor/etc/camera/diting_enhance_motiontuning.xml|vendor/etc/camera/diting_motiontuning.xml)
            [ "$2" = "" ] && return 0
            sed -i 's/xml=version/xml version/g' "${2}"
            ;;
        vendor/lib64/libalNN_snpe.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF_0_17_2}" --set-soname "libalNN_snpe.so" "${2}"
            ;;
        vendor/lib64/hw/audio.primary.taro-diting.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF_0_17_2}" --set-soname "audio.primary.taro-diting.so" "${2}"
            ;;
        vendor/lib64/hw/fingerprint.goodix_fod.default.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF_0_17_2}" --set-soname "fingerprint.goodix_fod.default.so" "${2}"
            ;;
        vendor/lib64/libcamximageformatutils.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF_0_17_2}" --replace-needed "vendor.qti.hardware.display.config-V2-ndk_platform.so" "vendor.qti.hardware.display.config-V2-ndk.so" "${2}"
            ;;
        vendor/lib64/libkaraokepal.so)
            [ "$2" = "" ] && return 0
            "${PATCHELF_0_17_2}" --replace-needed "audio.primary.taro.so" "audio.primary.taro-diting.so" "${2}"
            ;;
        *)
            return 1
            ;;
    esac
}

function blob_fixup_dry() {
    blob_fixup "$1" ""
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=diting
export DEVICE_COMMON=sm8450-common
export VENDOR=xiaomi
export VENDOR_COMMON=${VENDOR}

"./../../${VENDOR_COMMON}/${DEVICE_COMMON}/extract-files.sh" "$@"
