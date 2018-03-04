#!/bin/bash

clear
echo ""

if [ $# -ge 1 ]; then
  build=$1
fi


case $build in

  hi3518v1)
    echo "Start building Hisi V1 SoC's firmware";
    ;;

  hi3518v2)
    echo "Start building Hisi V2 SoC's firmware";
    cp target/linux/hisilicon/examples/.config_current  ./.config                                # Copy default config
    make clean && time make -j 7                                                                 # Clean and compile
    DATE=$(date +%Y%m%d) ; [ -d zft_lab ] || mkdir -p zft_lab                                    # Set time and create output dir
    cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-HI3518Xv2-XM-${DATE}.bin    # Copy Firmware
    ;;

  upload)
    echo "Start uploading firmware";
    scp bin/hisilicon/uImage-OpenWrt-HI35xx root@172.28.200.72:/srv/tftp/uImage                  # Upload current firmware to TFTP server
    scp bin/hisilicon/uImage-OpenWrt-HI35xx zig@172.28.200.74:~                                  # Upload current firmware to Desktop
    ;;

  *)
    echo "Please select: hi3518v1, hi3518v2 or upload";
    ;;

esac

