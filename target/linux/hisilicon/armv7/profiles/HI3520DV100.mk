#
# Copyright (C) 2007-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/HI3520DV100
  NAME:=HI3520DV100, default
  PACKAGES:=busybox demo
endef

define Profile/HI3520DV100/Description
	Package set compatible with hardware any Hisilicon HI3520DV100 SoC.
endef

$(eval $(call Profile,HI3520DV100))

