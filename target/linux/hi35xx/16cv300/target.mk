#
# Copyright (C) 2012 OpenWrt.org
#

SUBTARGET:=16cv300
BOARDNAME:=HI3516cv300 (ARMv5) armv5tej
CPU_TYPE:=arm926ej-s
KERNEL_PATCHVER:=3.18.20

define Target/Description
	Build firmware images for SoC version kernel 3.18.20. \
	Supported hi3516сv300|hi3516ev100.
endef