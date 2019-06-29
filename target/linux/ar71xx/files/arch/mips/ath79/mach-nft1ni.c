/*
 *  LigoWave NFT1NI board support
 *
 *  Copyright (C) 2012 Gabor Juhos <juhosg@openwrt.org>
 *  Copyright (C) 2014 Imre Kaloz <kaloz@openwrt.org>
 *
 *  This program is free software; you can redistribute it and/or modify it
 *  under the terms of the GNU General Public License version 2 as published
 *  by the Free Software Foundation.
 */

#include <linux/platform_device.h>
#include <linux/gpio.h>
#include <asm/mach-ath79/ath79.h>
#include <asm/mach-ath79/ar71xx_regs.h>
#include <asm/mach-ath79/ag71xx_platform.h>

#include "common.h"
#include "dev-eth.h"
#include "dev-gpio-buttons.h"
#include "dev-leds-gpio.h"
#include "dev-m25p80.h"
#include "dev-wmac.h"
#include "dev-usb.h"
#include "machtypes.h"


#define NFT1NI_GPIO_LED_WAN		18
#define NFT1NI_GPIO_LED_LAN1		19
#define NFT1NI_GPIO_LED_WLAN		13
#define NFT1NI_GPIO_LED_SYSTEM		11
#define NFT1NI_GPIO_LED_POWER		12
#define NFT1NI_GPIO_BTN_RESET		17
#define NFT1NI_GPIO_SW_RFKILL		21


#define NFT1NI_KEYS_POLL_INTERVAL	20	/* msecs */
#define NFT1NI_KEYS_DEBOUNCE_INTERVAL (3 * NFT1NI_KEYS_POLL_INTERVAL)

#define NFT1NI_GPIO_MASK        0x007fffff


static struct gpio_led nft1ni_leds_gpio[] __initdata = {
	{
		.name		= "ligowave:green:lan1",
		.gpio		= NFT1NI_GPIO_LED_LAN1,
		.active_low	= 1,
	}, {
		.name		= "ligowave:green:system",
		.gpio		= NFT1NI_GPIO_LED_SYSTEM,
		.active_low	= 1,
	}, {
		.name		= "ligowave:green:wan",
		.gpio		= NFT1NI_GPIO_LED_WAN,
		.active_low	= 1,
	}, {
		.name		= "ligowave:green:wlan",
		.gpio		= NFT1NI_GPIO_LED_WLAN,
		.active_low	= 1,
	},
};

static struct gpio_keys_button nft1ni_gpio_keys[] __initdata = {
	{
		.desc		= "reset",
		.type		= EV_KEY,
		.code		= KEY_RESTART,
		.debounce_interval = NFT1NI_KEYS_DEBOUNCE_INTERVAL,
		.gpio		= NFT1NI_GPIO_BTN_RESET,
		.active_low	= 1,
	}
};

static void __init nft1ni_setup(void)
{
	u8 *mac = (u8 *) KSEG1ADDR(0x1f01fc00);
	u8 *ee = (u8 *) KSEG1ADDR(0x1fff1000);

	ath79_register_leds_gpio(-1, ARRAY_SIZE(nft1ni_leds_gpio),
				 nft1ni_leds_gpio);

	ath79_register_gpio_keys_polled(1, NFT1NI_KEYS_POLL_INTERVAL,
					ARRAY_SIZE(nft1ni_gpio_keys),
					nft1ni_gpio_keys);

	/* ath79_register_m25p80(&nft1ni_flash_data); */
	ath79_register_m25p80(NULL);

	ath79_setup_ar934x_eth_cfg(AR934X_ETH_CFG_SW_PHY_SWAP);

	ath79_register_mdio(1, 0x0);

	ath79_init_mac(ath79_eth0_data.mac_addr, mac, -1);
	ath79_init_mac(ath79_eth1_data.mac_addr, mac, 1);

	/* GMAC0 is connected to the PHY0 of the internal switch */
	ath79_switch_data.phy4_mii_en = 1;
	ath79_switch_data.phy_poll_mask = BIT(0);
	ath79_eth0_data.phy_if_mode = PHY_INTERFACE_MODE_MII;
	ath79_eth0_data.phy_mask = BIT(0);
	ath79_eth0_data.mii_bus_dev = &ath79_mdio1_device.dev;
	ath79_eth0_data.speed = SPEED_100;
	ath79_register_eth(0);

	/* GMAC1 is connected to the internal switch */
	ath79_eth1_data.phy_if_mode = PHY_INTERFACE_MODE_GMII;
	ath79_eth1_data.speed = SPEED_100;
	ath79_register_eth(1);

	ath79_register_wmac(ee, mac);

	ath79_register_usb();

	gpio_request(NFT1NI_GPIO_LED_POWER, "power");
	gpio_direction_output(NFT1NI_GPIO_LED_POWER, GPIOF_OUT_INIT_LOW);
}

MIPS_MACHINE(ATH79_MACH_NFT1NI, "NFT1NI", "LigoWave NFT 1Ni",
	     nft1ni_setup);
