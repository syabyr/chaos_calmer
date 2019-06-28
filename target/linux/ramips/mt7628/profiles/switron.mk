#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/K4700
 NAME:=Switron K4700
 PACKAGES:=\
	kmod-usb-core kmod-usb-dwc2 kmod-usb2 kmod-usb-ohci \
	kmod-mt76
endef

define Profile/K4700/Description
 Support for Switron K4700 routers
endef
$(eval $(call Profile,K4700))
