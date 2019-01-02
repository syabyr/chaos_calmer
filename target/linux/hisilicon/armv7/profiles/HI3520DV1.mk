#
# Copyright (C) 2007-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/HI3520DV1
  NAME:=HI3520DV1 Soc
  PACKAGES:=mercury206
endef

define Profile/HI3520DV1/Description
	Package set compatible with hardware any Hisilicon HI3520DV1 SoC.
endef

$(eval $(call Profile,HI3520DV1))

