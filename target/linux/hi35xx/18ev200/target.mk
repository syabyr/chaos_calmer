#
# Copyright (C) 2012 OpenWrt.org
#

SUBTARGET:=18ev200
BOARDNAME:=HI3518ev200 (ARMv5) armv5tej
CPU_TYPE:=arm926ej-s
KERNEL_PATCHVER:=3.4.35

define Target/Description
	Build firmware images for SoC version kernel 3.4.35. \
	Supported hi3516cv200|hi3518ev200|hi3518ev201.
endef