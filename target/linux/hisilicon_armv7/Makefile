#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=hi3520d
CPU_TYPE:=cortex-a9
#CPU_SUBTYPE:=vfpv3
BOARDNAME:=Hisilicon HI35xx (ARMv7)
FEATURES:=squashfs usb gpio
MAINTAINER:=Igor Zalatov <flyrouter@gmail.com>

KERNEL_PATCHVER:=3.0.101

include $(INCLUDE_DIR)/target.mk

define Target/Description
	Build firmware images for XM510 ARM CPU
endef

KERNELNAME:=zImage 

#DEFAULT_PACKAGES += swconfig wpad-mini nvram otrx \
#	kmod-gpio-button-hotplug \
#	kmod-leds-gpio kmod-ledtrig-default-on kmod-ledtrig-timer

$(eval $(call BuildTarget))
