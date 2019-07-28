
LOCAL_PATH := $(call my-dir)

KERNEL_CROSS_COMPILE := aarch64-linux-android-

KERNEL_DEFCONFIG := hikey960_defconfig

KERNEL_SRC := $(LOCAL_PATH)
KERNEL_BUILD := $(PRODUCT_OUT)/obj/KERNEL/

KERNEL_OUT := $(KERNEL_BUILD)/arch/$(TARGET_ARCH)/boot
KERNEL_IMG := $(KERNEL_OUT)/Image.gz
KERNEL_DTB := $(KERNEL_OUT)/dts/hisilicon/hi3660-hikey960.dtb

.PHONY: kernel-build kernel-config

kernel-build: kernel-config
	$(MAKE) -C $(KERNEL_BUILD) ARCH=$(TARGET_ARCH) CROSS_COMPILE=$(KERNEL_CROSS_COMPILE)	

kernel-config:
	$(MAKE) -C $(KERNEL_SRC) O=$(KERNEL_BUILD) ARCH=$(TARGET_ARCH) $(KERNEL_DEFCONFIG)

$(TARGET_PREBUILT_KERNEL): kernel-build
	echo "Copy $(KERNEL_IMG) to $@"
	cp $(KERNEL_IMG) $@

$(TARGET_PREBUILT_DTB): kernel-build
	echo "Copy $(KERNEL_DTB) to $@"
	cp $(KERNEL_DTB) $@