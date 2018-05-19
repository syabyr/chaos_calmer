#!/bin/bash

clear

if [ $# -ge 1 ]; then
  build=$1
fi

case $build in

  hi3518v1)
    echo "Start building Hisi V1 SoC's firmware";
    cp target/linux/hisilicon/examples/.config_current  ./.config                                # Copy default config
    sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=3.0.8/' target/linux/hisilicon/Makefile       # Set right kernel version - 3.0.8
    make clean && time make -i -j 7                                                              # Clean and compile !!!!!!! any errors ignored (-i key) !!!!!!!
    DATE=$(date +%Y%m%d) ; [ -d zft_lab ] || mkdir -p zft_lab                                    # Set time and create output dir
    cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-HI3518Xv1-XM-${DATE}.bin    # Copy Firmware
    ;;

  hi3518v2)
    echo "Start building Hisi V2 SoC's firmware";
    cp target/linux/hisilicon/examples/.config_current  ./.config                                # Copy default config
    sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=3.4.35/' target/linux/hisilicon/Makefile      # Set right kernel version - 3.4.35
    make clean && time make -j 7                                                                 # Clean and compile
    DATE=$(date +%Y%m%d) ; [ -d zft_lab ] || mkdir -p zft_lab                                    # Set time and create output dir
    cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-HI3518Xv2-XM-${DATE}.bin    # Copy Firmware
    ;;

  hi3516v3)
    echo "Start building Hisi V3 SoC's firmware";
    cp target/linux/hisilicon/examples/.config_current  ./.config                                # Copy default config
    sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=3.18.20/' target/linux/hisilicon/Makefile     # Set right kernel version - 3.18.20
    make clean && time make -j 7                                                                 # Clean and compile
    DATE=$(date +%Y%m%d) ; [ -d zft_lab ] || mkdir -p zft_lab                                    # Set time and create output dir
    cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-HI3516Xv3-XM-${DATE}.bin    # Copy Firmware
    ;;

  upload)
    echo "Start uploading firmware";
    scp bin/hisilicon/uImage-OpenWrt-HI35xx root@172.28.200.72:/srv/tftp/uImage                  # Upload current firmware to TFTP server
    #scp bin/hisilicon/uImage-OpenWrt-HI35xx zig@172.28.200.74:~                                 # Upload current firmware to Desktop
    #scp -r \
    #  ~/chaos_calmer/bin/hisilicon/packages/base \
    #  ~/chaos_calmer/bin/hisilicon/packages/glutinium \
    #  ~/chaos_calmer/bin/hisilicon/packages/luci \
    #  ~/chaos_calmer/bin/hisilicon/packages/packages \
    #  zig@172.28.200.74:~/REPO/bitbucket_flyrouter_ipcams/OpenWrt/
    ;;

  update)
    # Update ZFT Lab. feeds
    ./scripts/feeds update glutinium
    ./scripts/feeds update zftlab
    ;;

  ipeye)
    # For test
    ./scripts/feeds update zftlab
    make package/feeds/zftlab/ipeye/clean ; make -j1 V=s package/feeds/zftlab/ipeye/compile ; make -j1 V=s package/feeds/zftlab/ipeye/install
    scp ./bin/hisilicon/packages/zftlab/*.ipk zig@172.28.200.74:~
    ;;

  *)
    echo -e "\nPlease select: hi3518v1, hi3518v2, hi3516v3, upload or glutinium \n";
    sleep 1
    ;;

esac
