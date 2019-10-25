#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=hi35xx
BOARDNAME:=Hisilicon HI3518/HI3516
SUBTARGETS:=16cv100 16cv200 16cv300 16ev100 18av100 18cv100 18ev100 18ev200 18ev201
# SUBTARGETS:=hi3516cv100 hi3516cv200 hi3516cv300 hi3516ev100 hi3518av100 hi3518cv100 hi3518ev100 hi3518ev200 hi3518ev201

FEATURES:=squashfs rtc usb gpio

MAINTAINER:=Igor Zalatov (ZFT Lab.) <flyrouter@gmail.com>
KERNEL_PATCHVER:=3.4.35
KERNELNAME:=zImage

define Target/Description
	Build firmware images for Hisilicon SoC based IPCam's and NVR's.
	Currently supports Xiong Mai (XM) and JVT based devices only.
	Instructions are available here (rus):
	https://zftlab.org/pages/2018010700.html
endef

include $(INCLUDE_DIR)/target.mk

$(eval $(call BuildTarget))