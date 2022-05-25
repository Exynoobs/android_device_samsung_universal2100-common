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

LOCAL_PATH := $(call my-dir)

ifneq ($(filter o1s, $(TARGET_DEVICE)),)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
subdir_makefiles=$(call first-makefiles-under,$(LOCAL_PATH))
$(foreach mk,$(subdir_makefiles),$(info including $(mk) ...)$(eval include $(mk)))

include $(CLEAR_VARS)

EGL_LIBS := libGLES_mali.so libOpenCL.so libOpenCL.so.1 libOpenCL.so.1.1

EGL_32_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/lib/,$(EGL_LIBS))
$(EGL_32_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "EGL 32 lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib/egl/libGLES_mali.so $@

EGL_64_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/lib64/,$(EGL_LIBS))
$(EGL_64_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "EGL 64 lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /vendor/lib64/egl/libGLES_mali.so $@

ALL_DEFAULT_INSTALLED_MODULES += $(EGL_32_SYMLINKS) $(EGL_64_SYMLINKS)

RECOVERY_KERNEL_MODULES := $(addprefix $(TARGET_RECOVERY_ROOT_OUT)/lib/modules/,$(shell cat device/samsung/universal2100-common/modules.load))

INSTALLED_KERNEL_TARGET := $(PRODUCT_OUT)/kernel
INTERNAL_RECOVERY_RAMDISK_FILES_TIMESTAMP := $(call intermediates-dir-for,PACKAGING,recovery)/ramdisk_files-timestamp

$(RECOVERY_KERNEL_MODULES): $(INSTALLED_KERNEL_TARGET)
	@echo "Copying kernel modules to recovery ramdisk: $@"
	@mkdir -p $(dir $@)
	cp -r $(TARGET_VENDOR_RAMDISK_OUT)/lib/ $(TARGET_RECOVERY_ROOT_OUT)/

$(INTERNAL_RECOVERY_RAMDISK_FILES_TIMESTAMP): $(RECOVERY_KERNEL_MODULES)
endif
