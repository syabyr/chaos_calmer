#!/bin/sh

do_hisilicon() {
	. /lib/hisilicon.sh

	hisilicon_board_detect
}

boot_hook_add preinit_main do_hisilicon
