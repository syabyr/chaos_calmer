#!/bin/bash

set -e # exit immediately if a command exits with a non-zero status.

if [ $# -ge 1 ]; then
  build=$1
  vendor=$2
fi

# clear

case $build in

  hi3516cv1|hi3518av1|hi3518cv1|hi3518ev1)
    SOC=${build}
    echo -e "\nStart building OpenWrt firmware for ${SOC} with kernel 3.0.8"                     # For SoC’s HI35_16C_18ACE_V100 only with kernel 3.0.8
    cp target/linux/hisilicon/examples/.config_armv5tej_current  ./.config                       # Copy default config
    sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=3.0.8/' target/linux/hisilicon/Makefile       # Set right kernel version - 3.0.8
    make clean && time make V=99 -j1                                                             # Clean and compile
    DATE=$(date +%Y%m%d) ; [ -d zft_lab ] || mkdir -p zft_lab                                    # Set time and create output dir
    #cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-${SOC}-XM-${DATE}.bin      # Copy Firmware
    cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-hi3516cv1-XM-${DATE}.bin    #
    cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-hi3518av1-XM-${DATE}.bin    #
    cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-hi3518cv1-XM-${DATE}.bin    #
    cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-hi3518ev1-XM-${DATE}.bin    #
    ;;

  hi3516cv2|hi3518ev2)
    SOC=${build}
    echo -e "\nStart building OpenWrt firmware for ${SOC} with kernel 3.4.35"                    # For SoC’s HI35_16C_18E_V200 only with kernel 3.4.35
    ./scripts/feeds update glutinium                                                             # *** Update glutinium feed
    ./scripts/feeds install -f -p glutinium hisi-osdrv2-base hisi-sample                         # *** Add hisilicon osdrv2 and sample packege from feed
    cp target/linux/hisilicon/examples/.config_armv5tej_current  ./.config                       # Copy default config
    sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=3.4.35/' target/linux/hisilicon/Makefile      # Set right kernel version - 3.4.35
    make clean && time make V=99 -j1                                                             # Clean and compile
    DATE=$(date +%Y%m%d) ; [ -d zft_lab ] || mkdir -p zft_lab                                    # Set time and create output dir
    #cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-${SOC}-XM-${DATE}.bin      # Copy Firmware
    cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-hi3516cv2-XM-${DATE}.bin    #
    cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-hi3518ev2-XM-${DATE}.bin    #
    ;;

  hi3516сv3)
    SOC=${build}
    echo -e "\nStart building OpenWrt firmware for ${SOC} with kernel 3.18.20"                   # For SoC’s HI35_16C_V300 only with kernel 3.18.20
    cp target/linux/hisilicon/examples/.config_armv5tej_current  ./.config                       # Copy default config
    sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=3.18.20/' target/linux/hisilicon/Makefile     # Set right kernel version - 3.18.20
    make clean && time make V=99 -j1                                                             # Clean and compile
    DATE=$(date +%Y%m%d) ; [ -d zft_lab ] || mkdir -p zft_lab                                    # Set time and create output dir
    #cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-${SOC}-XM-${DATE}.bin      # Copy Firmware
    cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-hi3516сv3-XM-${DATE}.bin    #
    ;;

  hi3520dv1)
    SOC=${build}
    echo -e "\nStart building OpenWrt firmware for ${SOC} with kernel 3.0.8"                     # For SoC’s HI35_20D_V100 only with kernel 3.0.8
    cp target/linux/hisilicon/examples/.config_armv7_extrasmall  ./.config                       # Copy default config
    sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=3.0.8/' target/linux/hisilicon/Makefile       # Set right kernel version - 3.0.8
    make clean && time make V=99 -j1                                                             # Clean and compile
    DATE=$(date +%Y%m%d) ; [ -d zft_lab ] || mkdir -p zft_lab                                    # Set time and create output dir
    #cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-${SOC}-XM-${DATE}.bin      # Copy Firmware
    cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-hi3520dv1-XM-${DATE}.bin    #
    ;;

  update)
    # Update ZFT Lab. feeds
    # git pull
    ./scripts/feeds update glutinium
    ./scripts/feeds update zftlab
    ;;

  project)
    # Show project changes
    HASH1="ceddf6298ad84c0ac103d25559e4e76a57f5bf76"
    HASH2="fc10957"
    #
    clear
    echo -e "\n####################################################################################################\n"
    git diff --name-only ${HASH1} ${HASH2} | grep -v "^dl/" | grep -v "^target/linux/hisilicon"
    echo -e "\n####################################################################################################\n"
    git diff --name-only ${HASH1} ${HASH2} | grep -e "^target/linux/hisilicon/" | grep -v "^target/linux/hisilicon/original_u-boot"
    echo
    git diff --name-only ${HASH1} ${HASH2} | grep -e "^target/linux/hisilicon/original_u-boot"
    echo -e "\n####################################################################################################\n"
    ;;

  upload)
    echo "Start uploading firmware and packages"
    scp bin/hisilicon/uImage-OpenWrt-HI35xx root@172.28.200.72:/srv/tftp/uImage                  # Upload current firmware to TFTP server
    scp -r \
      ~/chaos_calmer/bin/hisilicon/packages/* \
      root@araneus:/var/www/net_flyrouter/downloads/software/ipcam/GitHub_OpenWrt/Packages/      # Upload packages to OPKG server
    ;;

  ipeye)
    # For test
    ./scripts/feeds update zftlab
    make package/feeds/zftlab/ipeye/clean  &&  make -j1 V=s package/feeds/zftlab/ipeye/compile  &&  make -j1 V=s package/feeds/zftlab/ipeye/install
    #scp ./bin/hisilicon/packages/zftlab/*.ipk zig@172.28.200.74:~
    ;;

  osdrv2)
    # For test
    ./scripts/feeds update glutinium
    ./scripts/feeds install -f -p glutinium hisi-osdrv2-base hisi-sample
    make package/feeds/glutinium/hisi-osdrv2/clean  &&  make -j1 V=s package/feeds/glutinium/hisi-osdrv2/compile  &&  make -j1 V=s package/feeds/glutinium/hisi-osdrv2/install
    make package/feeds/glutinium/hisi-sample/clean  &&  make -j1 V=s package/feeds/glutinium/hisi-sample/compile  &&  make -j1 V=s package/feeds/glutinium/hisi-sample/install
    #scp ./bin/hisilicon/packages/glutinium/*.ipk zig@172.28.200.74:~
    ;;

  *)
    echo -e "\nPLEASE SELECT ONE OPTION IN COMMAND LINE"
    echo -e "\nBuild firmware section:\n  hi3516cv1\n  hi3518av1\n  hi3518cv1\n  hi3518ev1\n  hi3516cv2\n  hi3518ev2\n  hi3516сv3\n  hi3520dv1"
    echo -e "\nSystem command section:\n  project\n  update\n  upload"
    echo -e "\nRebuild software section:\n  ipeye\n  osdrv2"
    echo -e "\n#####################################"
    (echo -e "\nCheck OPENWRT repo...\n" ; git status)
    echo -e "\n#####################################"
    (echo -e "\nCheck GLUTINIUM feed...\n" ; cd feeds/glutinium ; git status)
    echo -e "\n#####################################"
    (echo -e "\nCheck ZFTLAB feed...\n" ; cd feeds/zftlab ; git status)
    echo -e "\n#####################################"
    sleep 3
    ;;

esac



#    sed -i 's/CONFIG_HIETH_MII_RMII_MODE_U:=.*/CONFIG_HIETH_MII_RMII_MODE_U:=1/' target/linux/hisilicon/config-3.0.8.phy-xm      # Set CONFIG_HIETH_MII_RMII_MODE_U=1   - XM+BLUE vendor
#    sed -i 's/CONFIG_HIETH_MII_RMII_MODE_D:=.*/CONFIG_HIETH_MII_RMII_MODE_D:=1/' target/linux/hisilicon/config-3.0.8.phy-xm      # Set CONFIG_HIETH_MII_RMII_MODE_D=1   - XM+BLUE vendor
#
#    sed -i 's/CONFIG_HIETH_PHYID_U:=.*/CONFIG_HIETH_PHYID_U:=1/' target/linux/hisilicon/config-3.0.8.phy-xm                      # Set CONFIG_HIETH_PHYID_U=1           - XM model
#    sed -i 's/CONFIG_HIETH_PHYID_D:=.*/CONFIG_HIETH_PHYID_D:=2/' target/linux/hisilicon/config-3.0.8.phy-xm                      # Set CONFIG_HIETH_PHYID_D=2           - XM model
#
#    sed -i 's/CONFIG_HIETH_PHYID_U:=.*/CONFIG_HIETH_PHYID_U:=0/' target/linux/hisilicon/config-3.0.8.phy-xm                      # Set CONFIG_HIETH_PHYID_U=0           - BLUE vendor
#    sed -i 's/CONFIG_HIETH_PHYID_D:=.*/CONFIG_HIETH_PHYID_D:=1/' target/linux/hisilicon/config-3.0.8.phy-xm                      # Set CONFIG_HIETH_PHYID_D=1           - BLUE vendor



#    sed -i 's/CONFIG_HIETH_MII_RMII_MODE_U:=.*/CONFIG_HIETH_MII_RMII_MODE_U:=1/' target/linux/hisilicon/config-3.4.35.phy-xm     # Set CONFIG_HIETH_MII_RMII_MODE_U=1   - XM+BLUE vendor
#    sed -i 's/CONFIG_HIETH_MII_RMII_MODE_D:=.*/CONFIG_HIETH_MII_RMII_MODE_D:=1/' target/linux/hisilicon/config-3.4.35.phy-xm     # Set CONFIG_HIETH_MII_RMII_MODE_D=1   - XM+BLUE vendor
#
#    sed -i 's/CONFIG_HIETH_PHYID_U:=.*/CONFIG_HIETH_PHYID_U:=0/' target/linux/hisilicon/config-3.4.35.phy-xm                     # Set CONFIG_HIETH_PHYID_U=1           - XM vendor
#    sed -i 's/CONFIG_HIETH_PHYID_D:=.*/CONFIG_HIETH_PHYID_D:=1/' target/linux/hisilicon/config-3.4.35.phy-xm                     # Set CONFIG_HIETH_PHYID_D=3           - XM vendor
#
#    sed -i 's/CONFIG_HIETH_PHYID_U:=.*/CONFIG_HIETH_PHYID_U:=0/' target/linux/hisilicon/config-3.4.35.phy-xm                     # Set CONFIG_HIETH_PHYID_U=0           - BLUE vendor
#    sed -i 's/CONFIG_HIETH_PHYID_D:=.*/CONFIG_HIETH_PHYID_D:=1/' target/linux/hisilicon/config-3.4.35.phy-xm                     # Set CONFIG_HIETH_PHYID_D=1           - BLUE vendor

