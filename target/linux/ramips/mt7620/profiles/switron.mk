#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/RT2257
 NAME:=Switron RT-2257
 PACKAGES:=\
	kmod-usb-core kmod-usb-dwc2 kmod-usb2 kmod-usb-ohci \
	kmod-mt76
endef

define Profile/RT2257/Description
 Support for Switron RT-2257 routers
endef
$(eval $(call Profile,RT2257))
