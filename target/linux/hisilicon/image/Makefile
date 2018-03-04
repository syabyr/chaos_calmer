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
	hi3518ev1-test1 \
	hi3518ev1-test2

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

#define Image/Build/squashfs
#	$(STAGING_DIR_HOST)/bin/padjffs2 $(KDIR)/root.squashfs 128
#	#$(call prepare_generic_squashfs,$(KDIR)/root.squashfs)
#endef

#define Image/Build/Profile/hi3518ev1-test1
#	$(call Image/Build/squashfs,$(1),hi3518ev1-test1,hi3518ev1-test1)
#endef

#define Image/Build/Profile/hi3518ev1-test2
#	$(call Image/Build/squashfs,$(1),hi3518ev1-test1,hi3518ev1-test1)
#endef

#define Image/Build
#	$(call Image/Build/$(1),$(1))
#	$(call Image/Build/Profile/$(PROFILE),$(1))
#	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-root.$(1) bs=128k conv=sync
#ifneq ($(CONFIG_TARGET_ROOTFS_INITRAMFS),)
#	$(call Image/Build/Initramfs)
#endif
#endef

$(eval $(call BuildImage))
