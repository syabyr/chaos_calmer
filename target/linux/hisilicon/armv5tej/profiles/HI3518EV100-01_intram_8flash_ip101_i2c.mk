#
# Copyright (C) 2007-2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/HI3518EV100-01
  NAME:=HI3518EV100, Int. RAM, 8M Flash, IP101, I2C
  PACKAGES:=busybox demo
endef

define Profile/HI3518EV100-01/Description
	Package set compatible with hardware any Hisilicon HI3518EV100 SoC.
endef

$(eval $(call Profile,HI3518EV100-01))
