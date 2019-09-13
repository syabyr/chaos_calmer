#!/bin/sh
#
# Copyright (C) 2013 OpenWrt.org
#

. /lib/functions/leds.sh
. /lib/hisilicon.sh


gpio_init() {
	case $(hisilicon_board_name) in
	hi3516cv100)
		echo "No GPIO settings" | logger
		;;
	hi3516cv200)
		echo "No GPIO settings" | logger
		;;
	hi3518ev100)
		echo "No GPIO settings" | logger
		;;
	hi3518ev200)
		#
		devmem 0x200f00C0 32 0x3 && echo " | GPIO6_0 |  AMA1  | uart1_rxd | Any Board                                        | SoC hi3518ev200 | " | logger -t gpio_init
		devmem 0x200f00C8 32 0x3 && echo " | GPIO6_2 |  AMA1  | uart1_txd | Any Board                                        | SoC hi3518ev200 | " | logger -t gpio_init
		#
		devmem 0x200f00CC 32 0x3 && echo " | GPIO6_3 |  AMA2  | uart2_rxd | Any Board                                        | SoC hi3518ev200 | " | logger -t gpio_init
		devmem 0x200f00D0 32 0x3 && echo " | GPIO6_4 |  AMA2  | uart2_txd | Any Board                                        | SoC hi3518ev200 | " | logger -t gpio_init
		#
		devmem 0x200f0058 32 0x0 && echo " | GPIO4_1 | GPIO33 | ircut_1   | Board XM 00018520                                | SoC hi3518ev200 | " | logger -t gpio_init
		devmem 0x200f005c 32 0x0 && echo " | GPIO4_2 | GPIO34 | ircut_2   | Board XM 00018520                                | SoC hi3518ev200 | " | logger -t gpio_init
		devmem 0x200f0060 32 0x0 && echo " | GPIO4_3 | GPIO35 | alarm_out | Board XM 00018520                                | SoC hi3518ev200 | " | logger -t gpio_init
		devmem 0x200f00F4 32 0x1 && echo " | GPIO7_5 | GPIO61 | alarm_in  | Board XM 00018520                                | SoC hi3518ev200 | " | logger -t gpio_init
		#
		devmem 0x200f00bc 32 0x0 && echo " | GPIO5_7 | GPIO47 | irled     | Board JVT S130H18V and JVS/Sunwo ZB232_V200+0130 | SoC hi3518ev200 | " | logger -t gpio_init
		devmem 0x200f0100 32 0x1 && echo " | GPIO8_0 | GPIO64 | ircut_1   | Board JVT S130H18V and JVS/Sunwo ZB232_V200+0130 | SoC hi3518ev200 | " | logger -t gpio_init
		devmem 0x200f0104 32 0x1 && echo " | GPIO8_1 | GPIO65 | ircut_2   | Board JVT S130H18V and JVS/Sunwo ZB232_V200+0130 | SoC hi3518ev200 | " | logger -t gpio_init
		;;
	esac
}

get_status_led() {
	case $(hisilicon_board_name) in
	hi3516cv100)
		#status_led="tp-link:blue:system"
		echo "Device hi3518cv100 found - diag.sh" | logger
		;;
	hi3516cv200)
		#status_led="tp-link:blue:system"
		echo "Device hi3518cv200 found - diag.sh" | logger
		;;
	hi3518ev100)
		#status_led="tp-link:blue:system"
		echo "Device hi3518ev100 found - diag.sh" | logger
		;;
	hi3518ev200)
		#status_led="tp-link:blue:system"
		echo "Device hi3518ev200 found - diag.sh" | logger
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
