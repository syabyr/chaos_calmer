#
# Copyright (C) 2011-2014 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mpp-hi3518xv100
PKG_VERSION:=1.0.B.0
PKG_RELEASE:=0.1
PKG_MAINTAINER:=Igor Zalatov (ZFT Lab.) <flyrouter@gmail.com>

include $(INCLUDE_DIR)/package.mk

PKG_LICENSE:=GPL-2.0
PKG_LICENSE_FILES:=LICENSE

define Package/$(PKG_NAME)
	SECTION:=openipc
	CATEGORY:=OpenIPC
	SUBMENU:=Testing
	TITLE:=MPP files for HI3518xV100 SoC's
	MAINTAINER:=Hisilicon
endef

define Package/$(PKG_NAME)/description
  MPP files for HI3518xV100 SoC's
endef

define Build/Prepare
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/lib/modules/3.0.8
	$(CP) ./modules/*.ko $(1)/lib/modules/3.0.8/
	$(INSTALL_DIR) $(1)/etc/hi3518xv100
	$(CP) ./scripts/* $(1)/etc/hi3518xv100
endef

$(eval $(call BuildPackage,$(PKG_NAME)))


