#
# Copyright (C) 2012 OpenWrt.org
#

SUBTARGET:=16cv100
BOARDNAME:=HI3516cv100 (ARMv5) armv5tej
CPU_TYPE:=arm926ej-s
KERNEL_PATCHVER:=3.0.8

define Target/Description
	Build firmware images for SoC version kernel 3.0.8. \
	Supported hi3516cv100|hi3518av100|hi3518cv100|hi3518ev100.
endef