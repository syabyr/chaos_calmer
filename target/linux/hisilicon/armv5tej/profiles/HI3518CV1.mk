#
# Copyright (C) 2007-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/HI3518CV1
  NAME:=HI3518CV1 Soc
  PACKAGES:=busybox demo
endef

define Profile/HI3518CV1/Description
	Package set compatible with hardware any Hisilicon HI3518CV1 SoC.
endef

$(eval $(call Profile,HI3518CV1))

