#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/Generic
	NAME:=Generic profile
endef

define Profile/Generic/Description
	Default profile for Hisilicon HI3518Ev1 targets

	Instructions are available here (rus):
	https://zftlab.org/pages/2018010700.html
endef

$(eval $(call Profile,Generic))

