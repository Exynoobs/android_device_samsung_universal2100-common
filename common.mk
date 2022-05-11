#
# Copyright (C) 2022 The LineageOS Project
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

COMMON_PATH := device/samsung/universal2100-common

# Get non-open-source specific aspects
$(call inherit-product, vendor/samsung/universal2100-common/universal2100-common-vendor.mk)

PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_USE_DYNAMIC_PARTITION_SIZE := true
PRODUCT_BUILD_SUPER_PARTITION := false

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# init
PRODUCT_COPY_FILES += \
    $(COMMON_PATH)/configs/init/fstab.exynos2100:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.exynos2100 \
    $(COMMON_PATH)/configs/init/fstab.exynos2100:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/fstab.exynos2100 \
    $(COMMON_PATH)/configs/init/fstab.universal2100:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.exynos2100 \
    $(COMMON_PATH)/configs/init/init.recovery.exynos2100.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.exynos2100.rc

# Recovery/vendor_boot firmware
PRODUCT_COPY_FILES += \
    vendor/samsung/universal2100-common/proprietary/vendor/firmware/y792_o1.bin:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/vendor/firmware/y792_o1.bin \
    vendor/samsung/universal2100-common/proprietary/vendor/firmware/y792_o1.bin:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/firmware/y792_o1.bin
