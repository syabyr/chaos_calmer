#
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk
include $(INCLUDE_DIR)/version.mk

PKG_NAME:=u-boot
PKG_VERSION:=2010.06
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(KERNEL_BUILD_DIR)/$(PKG_NAME)-$(BUILD_VARIANT)/$(PKG_NAME)-$(PKG_VERSION)
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tgz
PKG_SOURCE_URL:= \
	http://flyrouter.net/downloads/software/ipcam/archive/
PKG_MD5SUM:=
PKG_TARGETS:=bin

PKG_LICENSE:=GPL-2.0 GPL-2.0+
PKG_LICENSE_FILES:=Licenses/README

include $(INCLUDE_DIR)/package.mk

#IMG_PREFIX:=openwrt-$(if $(CONFIG_VERSION_FILENAMES),$(VERSION_NUMBER)-)$(BOARD)$(if $(SUBTARGET),-$(SUBTARGET))

define uboot/Default
  TITLE:=
  CONFIG:=
  IMAGE:=
  REG_FILE:=
  COMPRESS:=
endef

UBOOTS+=18ev200



# ?
# hi3535_config
# hi3516a_config
# hi3536_config
# ?

define Package/uboot/template
define Package/uboot-hi35xx-$(1)
  SECTION:=boot
  CATEGORY:=Boot Loaders
  DEPENDS:=@TARGET_hi35xx_$(1)
  TITLE:=U-boot for the $(1) boards
  URL:=http://www.denx.de/wiki/U-Boot
  VARIANT:=$(1)
endef
endef

define BuildUbootPackage
	$(eval $(uboot/Default))
	$(eval $(uboot/$(1)))
	$(call Package/uboot/template,$(1),$(TITLE))
endef


ifdef BUILD_VARIANT
$(eval $(call uboot/$(BUILD_VARIANT)))
ifeq ($(BUILD_VARIANT), 18ev200)
    UBOOT_CONFIG:=hi3518ev200_config
	REG_FILE:=reg_info_hi3518ev200.bin
	COMPRESS:=1
	CONFIG_HI3518EV200:=1
endif


UBOOT_IMAGE:="openwrt-$(if $(CONFIG_VERSION_FILENAMES),$(VERSION_NUMBER)-)$(BOARD)$(if $(SUBTARGET),-$(SUBTARGET))-u-boot.bin"

endif

define Build/Prepare
	$(call Build/Prepare/Default)
	#$(CP) ./files/* $(PKG_BUILD_DIR)
	$(CP) $(PKG_BUILD_DIR)/common/cmd_bootss2_v400_hi3518ev200 $(PKG_BUILD_DIR)/common/bootss2.a -rf
	find $(PKG_BUILD_DIR) -name .svn | $(XARGS) rm -rf
endef

define Build/Configure
	$(MAKE) -C $(PKG_BUILD_DIR) \
		$(UBOOT_CONFIG)
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CROSS_COMPILE=$(TARGET_CROSS)
endef

define Package/uboot/install/template
ifeq ($(COMPRESS), 1)
define Package/uboot-hi35xx-$(1)/install
    $(CP) $(PKG_BUILD_DIR)/u-boot.bin $(PKG_BUILD_DIR)/full-boot.bin
	$(CP) $(PKG_BUILD_DIR)/uboot_tools/$(REG_FILE) $(PKG_BUILD_DIR)/.reg
	$(MAKE) -C $(PKG_BUILD_DIR) CROSS_COMPILE=$(TARGET_CROSS) mini-boot.bin
	$(CP) $(PKG_BUILD_DIR)/mini-boot.bin $(BIN_DIR)/$(UBOOT_IMAGE)
endef
endif
ifeq ($(COMPRESS), 0)
define Package/uboot-hi35xx-$(1)/install
	$(PKG_BUILD_DIR)/uboot_tools/mkboot.sh $(PKG_BUILD_DIR)/uboot_tools/$(REG_FILE) $(PKG_BUILD_DIR)/u-boot.bin $(PKG_BUILD_DIR)/$(UBOOT_IMAGE)
	$(CP) $(PKG_BUILD_DIR)/$(UBOOT_IMAGE) $(BIN_DIR)/
endef
endif
endef

$(foreach u,$(UBOOTS), \
	$(eval $(call Package/uboot/install/template,$(u))) \
)

$(foreach u,$(UBOOTS), \
	$(eval $(call BuildUbootPackage,$(u))) \
	$(eval $(call BuildPackage,uboot-hi35xx-$(u))) \
)
