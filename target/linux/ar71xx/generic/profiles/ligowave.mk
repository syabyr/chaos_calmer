#
# Copyright (C) 2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/NFT1NI
	NAME:=LigoWave NFT 1Ni
	PACKAGES:=kmod-usb-core kmod-usb-ohci kmod-usb2
endef

define Profile/NFT1NI/Description
	Package set optimized for the LigoWave NFT 1Ni.
endef

$(eval $(call Profile,NFT1NI))

