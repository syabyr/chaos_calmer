#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/Generic
  NAME:=Hisilicon SoC, ARMv7 (default)
  PACKAGES:=
endef

define Profile/Generic/Description
	Package set compatible with hardware any Hisilicon
	SoC with a ARMv7 CPU like the HI3516CV300, HI3520DV200, XM510
endef

$(eval $(call Profile,Generic))

