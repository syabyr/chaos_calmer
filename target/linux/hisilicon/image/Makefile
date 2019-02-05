#
# Copyright (C) 2018 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk
include $(INCLUDE_DIR)/host.mk

BOARDS:= \
	HI3518EV200 \
	HI3518EV201

LOADADDR:=0x80008000

define Image/BuildKernel
	mkimage -A arm -O linux -T kernel -C none \
		-a $(LOADADDR) \
		-n 'Hisilicon OpenWrt Linux-$(LINUX_VERSION)' \
		-d $(KDIR)/linux-$(LINUX_VERSION)/arch/arm/boot/zImage $(BIN_DIR)/uImage-OpenWrt-HI35xx
endef

#define Image/InstallKernel
#	mkdir -p $(TARGET_DIR)/boot
#	cp $(KDIR)/uImage $(TARGET_DIR)/boot/
#endef

#define Image/Build/Initramfs
#	mkimage -A arm -O linux -T kernel -C gzip \
#		-a 0x20008000 -e 0x20008000 \
#		-n 'OpenWrt Linux-$(LINUX_VERSION)' \
#		-d $(KDIR)/zImage-initramfs $(BIN_DIR)/$(IMG_PREFIX)-initramfs-uImage
#endef

# Build rootfs as squashfs
define Image/Build/squashfs
#	$(STAGING_DIR_HOST)/bin/padjffs2 $(KDIR)/root.squashfs 128
	$(call prepare_generic_squashfs,$(KDIR)/root.squashfs)
	cp $(KDIR)/root.squashfs $(BIN_DIR)/$(IMG_PREFIX)-root.squashfs
#	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-$(1).img bs=131072 conv=sync
endef

# Build rootfs as jffs2-128k
define Image/Build/jffs2-128k
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-$(1).img bs=131072 conv=sync
endef

# Build sysupgrade image
define BuildFirmware/Generic
	dd if=$(KDIR)/zImage of=$(KDIR)/zImage.pad bs=64k conv=sync; \
	dd if=$(KDIR)/root.$(1) of=$(KDIR)/root.$(1).pad bs=128k conv=sync; \
	sh $(TOPDIR)/scripts/combined-image.sh \
		$(KDIR)/zImage.pad \
		$(KDIR)/root.$(1).pad \
		$(BIN_DIR)/$(IMG_PREFIX)-$(patsubst jffs2-%,jffs2,$(patsubst squashfs-%,squashfs,$(1)))-sysupgrade.bin
endef


define Image/Build/Profile/HI3518EV200
	$(call Image/Build/squashfs,$(1),HI3518EV200,HI3518EV200)
endef

define Image/Build/Profile/HI3518EV201
	$(call Image/Build/squashfs,$(1),HI3518EV201,HI3518EV201)
endef


define Image/Build
	$(call Image/Build/$(1),$(1))
	$(call BuildFirmware/Generic,$(1))
	cp $(KDIR)/zImage $(BIN_DIR)/$(IMG_PREFIX)-uImage
#
	$(call Image/Build/Profile/$(PROFILE),$(1))
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-root.$(1) bs=128k conv=sync
endef

$(eval $(call BuildImage))
