#!/bin/sh
#
# Copyright (C) 2013 OpenWrt.org
#

. /lib/functions/leds.sh
. /lib/hisilicon.sh

get_status_led() {
	case $(hisilicon_board_name) in
	hi3518ev200)
		#status_led="tp-link:blue:system"
		echo "Maybe LED ON" | logger
		;;
	esac
}

set_state() {
	get_status_led

	case "$1" in
	preinit)
		status_led_blink_preinit
		;;

	failsafe)
		status_led_blink_failsafe
		;;

	preinit_regular)
		status_led_blink_preinit_regular
		;;

	done)
		status_led_on
		;;
	esac
}
