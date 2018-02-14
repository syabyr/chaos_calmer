#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=hisilicon
BOARDNAME:=Hisilicon HI3518Ev1
FEATURES:=usb squashfs low_mem
CPU_TYPE:=arm926ej-s
MAINTAINER:=ZigFisher (ZFT Lab.) <flyrouter@gmail.com>

KERNEL_PATCHVER:=3.0

DEVICE_TYPE:=other

include $(INCLUDE_DIR)/target.mk

define Target/Description
	Build firmware images for Hisilicon SoC based IPCam's.
	Currently supports HI3518Ev1 based devices only.
endef

DEFAULT_PACKAGES := $(filter-out ppp%,$(DEFAULT_PACKAGES)) \
		kmod-usb-core kmod-usb2 kmod-usb-ohci \
		kmod-usb-storage kmod-fs-vfat kmod-nls-utf8 \
		kmod-mcs814x-wdt kmod-ledtrig-usbdev

KERNELNAME:=zImage dtbs

$(eval $(call BuildTarget))
