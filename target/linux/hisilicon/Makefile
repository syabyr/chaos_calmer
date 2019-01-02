#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=hisilicon
BOARDNAME:=Hisilicon HI35xx
SUBTARGETS:=armv5tej armv7
FEATURES:=usb squashfs
MAINTAINER:=Igor Zalatov (ZFT Lab.) <flyrouter@gmail.com>

KERNEL_PATCHVER:=3.4.35

include $(INCLUDE_DIR)/target.mk

DEFAULT_PACKAGES := $(filter-out ppp%,$(DEFAULT_PACKAGES)) \
		kmod-usb-core kmod-usb2 kmod-usb-ohci \
		kmod-usb-storage kmod-fs-vfat kmod-nls-utf8 \
		kmod-ledtrig-usbdev kmod-tun

define Target/Description
	Build firmware images for Hisilicon SoC based IPCam's and NVR's.
	Currently supports Xiong Mai (XM) and JVT based devices only.
endef

$(eval $(call BuildTarget))
