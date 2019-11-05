#!/bin/bash
#
# More information on the site - http://openipc.org
#

DEFCONF="target/linux/hisilicon/examples/.config_armv5tej_luci_default"



set -e # exit immediately if a command exits with a non-zero status.

if [ $# -ge 1 ]; then
  build=$1
  vendor=$2
fi

# clear

case $build in

  hi3516cv100|hi3518av100|hi3518cv100|hi3518ev100)
    SOC=${build}
    echo -e "\nStart building OpenWrt firmware for ${SOC} with kernel 3.0.8"                  # For SoC’s HI35_16C_18ACE_V100 only with kernel 3.0.8
    #echo "${SOC}" > target/linux/hisilicon/base-files/etc/soc-version                        # Create identification file for updates
    ./scripts/feeds update glutinium                                                          # *** Update glutinium feed
    cp ${DEFCONF}  ./.config                                                                  # Copy default config
    sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=3.0.8/' target/linux/hisilicon/Makefile    # Set right kernel version - 3.0.8
    make clean && time make V=99 -j$(($(nproc)+1))                                            # Clean and compile
    rm -f target/linux/hisilicon/base-files/etc/soc-version                                   # Remove identification file
    #DATE=$(date +%Y%m%d) ; [ -d zft_lab ] || mkdir -p zft_lab                                # Set time and create output dir
    #cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-${SOC}-${DATE}.bin      # Copy Firmware
    ;;

  hi3516cv200|hi3518ev200|hi3518ev201)
    SOC=${build}
    echo -e "\nStart building OpenWrt firmware for ${SOC} with kernel 3.4.35"                 # For SoC’s HI35_16C_18E_V200 only with kernel 3.4.35
    #echo "${SOC}" > target/linux/hisilicon/base-files/etc/soc-version                        # Create identification file for updates
    ./scripts/feeds update glutinium                                                          # *** Update glutinium feed
    ./scripts/feeds install -f -p glutinium hisi-osdrv2-base hisi-sample                      # *** Add hisilicon osdrv2 and sample packege from feed
    cp ${DEFCONF}  ./.config                                                                  # Copy default config
    sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=3.4.35/' target/linux/hisilicon/Makefile   # Set right kernel version - 3.4.35
    make clean && time make V=99 -j1  -j$(($(nproc)+1))                                       # Clean and compile
    rm -f target/linux/hisilicon/base-files/etc/soc-version                                   # Remove identification file
    #DATE=$(date +%Y%m%d) ; [ -d zft_lab ] || mkdir -p zft_lab                                # Set time and create output dir
    #cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-${SOC}-${DATE}.bin      # Copy Firmware
    ;;

  hi3516сv300|hi3516ev100)
    SOC=${build}
    echo -e "\nStart building OpenWrt firmware for ${SOC} with kernel 3.18.20"                # For SoC’s HI35_16C_V300 only with kernel 3.18.20
    #echo "${SOC}" > target/linux/hisilicon/base-files/etc/soc-version                        # Create identification file for updates
    ./scripts/feeds update glutinium                                                          # *** Update glutinium feed
    cp ${DEFCONF}  ./.config                                                                  # Copy default config
    sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=3.18.20/' target/linux/hisilicon/Makefile  # Set right kernel version - 3.18.20
    make clean && time make V=99 -j$(($(nproc)+1))                                            # Clean and compile
    rm -f target/linux/hisilicon/base-files/etc/soc-version                                   # Remove identification file
    #DATE=$(date +%Y%m%d) ; [ -d zft_lab ] || mkdir -p zft_lab                                # Set time and create output dir
    #cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-${SOC}-${DATE}.bin      # Copy Firmware
    ;;

  hi3520dv100)
    SOC=${build}
    echo -e "\nStart building OpenWrt firmware for ${SOC} with kernel 3.0.8"                  # For SoC’s HI35_20D_V100 only with kernel 3.0.8
    #echo "${SOC}" > target/linux/hisilicon/base-files/etc/soc-version                        # Create identification file for updates
    cp target/linux/hisilicon/examples/.config_armv7_extrasmall  ./.config                    # Copy default config
    sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=3.0.8/' target/linux/hisilicon/Makefile    # Set right kernel version - 3.0.8
    make clean && time make V=99 -j$(($(nproc)+1))                                            # Clean and compile
    rm -f target/linux/hisilicon/base-files/etc/soc-version                                   # Remove identification file
    #DATE=$(date +%Y%m%d) ; [ -d zft_lab ] || mkdir -p zft_lab                                # Set time and create output dir
    #cp -v bin/hisilicon/uImage-OpenWrt-HI35xx zft_lab/uImage-OpenWrt-${SOC}-${DATE}.bin      # Copy Firmware
    ;;

  rotek)
    SOC=${build}
    echo -e "\nStart building OpenWrt firmware for Rotek board with kernel 3.4.35"            # For Rotek
    cp target/linux/hisilicon/examples/.config_armv5tej_luci_rotek  ./.config                 # Copy default config
    sed -i 's/KERNEL_PATCHVER:=.*/KERNEL_PATCHVER:=3.4.35/' target/linux/hisilicon/Makefile   # Set right kernel version - 3.4.35
    make clean && time make V=99 -j1  -j$(($(nproc)+1))                                       # Clean and compile
    ;;

  release)
    # Rebuild kernel, rootfs, firmware
    make V=99 -j$(($(nproc)+1)) target/install
    ;;

  update)
    # Update ZFT Lab. feeds
    # git pull
    ./scripts/feeds update glutinium packages luci management routing telephony # zftlab
    ./scripts/feeds install -p glutinium -a
    ./scripts/feeds install -p luci -a
    ./scripts/feeds install -p packages -a
    ./scripts/feeds install -p routing -a
    ./scripts/feeds install -p management -a
    ./scripts/feeds install -p telephony -a
    #./scripts/feeds install -p zftlab -a
    ;;

  project)
    # Show project changes
    HASH1="ceddf6298ad84c0ac103d25559e4e76a57f5bf76"
    HASH2="6256558"
    #
    clear
    echo -e "\n####################################################################################################\n"
    git diff --name-only ${HASH1} ${HASH2} | grep -v "^dl/" | grep -v "target/linux/ar71xx" | grep -v "^target/linux/hisilicon" | grep -v "^target/linux/ramips"
    echo -e "\n####################################################################################################\n"
    git diff --name-only ${HASH1} ${HASH2} | grep -e "^target/linux/hisilicon/" | grep -v "^target/linux/hisilicon/u-boot_from_sdk"
    echo
    git diff --name-only ${HASH1} ${HASH2} | grep -e "^target/linux/hisilicon/u-boot_from_sdk"
    echo -e "\n####################################################################################################\n"
    git diff --name-only ${HASH1} ${HASH2} | grep -e "^target/linux/ar71xx"
    echo -e "\n####################################################################################################\n"
    git diff --name-only ${HASH1} ${HASH2} | grep -e "^target/linux/ramips"
    echo -e "\n####################################################################################################\n"
    ;;

  push)
    echo "Start pushing firmware"
    scp bin/hisilicon/openwrt-hisilicon-* root@172.28.200.72:/srv/tftp/                          # Push firmware to ZFT Lab. TFTP server
    scp bin/hisilicon/openwrt-hisilicon-* zig@172.28.200.74:~                                    # Push firmware to my PC
    ;;

  upload)
    echo "Start uploading firmware and packages"
    scp bin/hisilicon/openwrt-hisilicon-* \
      root@araneus:/var/www/net_flyrouter/downloads/software/ipcam/GitHub_OpenWrt/Firmware/      # Upload firmware to WEB server
    scp -r bin/hisilicon/packages/* \
      root@araneus:/var/www/net_flyrouter/downloads/software/ipcam/GitHub_OpenWrt/Packages/      # Upload packages to WEB server
    scp -r bin/hisilicon/OpenWrt-* \
      root@araneus:/var/www/net_flyrouter/downloads/software/ipcam/GitHub_OpenWrt/SDK/           # Upload SDK an ImageBuilder to WEB server
    ;;

  ipeye)
    # For test
    ./scripts/feeds update zftlab
    #make package/feeds/glutinium/kdb/{clean,compile,install}
    make package/feeds/zftlab/ipeye/{clean,compile,install}
    #scp ./bin/hisilicon/packages/zftlab/*.ipk zig@172.28.200.74:~
    ;;

  minihttp)
    # For test
    ./scripts/feeds update glutinium
    make -j1 V=s package/feeds/glutinium/minihttp/{clean,compile,install}
    #scp root@172.28.200.80:/usr/bin/minihttp_test
    ;;

  osdrv1)
    # For test
    ./scripts/feeds update glutinium
    ./scripts/feeds install -f -p glutinium hisi-osdrv1-base hisi-sample
    make package/feeds/glutinium/hisi-osdrv1/clean  &&  make -j1 V=s package/feeds/glutinium/hisi-osdrv1/compile  &&  make -j1 V=s package/feeds/glutinium/hisi-osdrv1/install
    make package/feeds/glutinium/hisi-sample/clean  &&  make -j1 V=s package/feeds/glutinium/hisi-sample/compile  &&  make -j1 V=s package/feeds/glutinium/hisi-sample/install
    #scp ./bin/hisilicon/packages/glutinium/*.ipk zig@172.28.200.74:~
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
    echo -e "\n#####################################"
    echo -e "\nMore information on the site - http://openipc.org\n"
    echo -e "\nPLEASE SELECT ONE OPTION IN COMMAND LINE"
    echo -e "\nBuild firmware section:\n  hi3516cv100\n  hi3518av100\n  hi3518cv100\n  hi3518ev100\n\n  hi3516cv200\n  hi3518ev200\n  hi3518ev201\n\n  hi3516сv300\n  hi3516ev100\n\n  hi3520dv100"
    echo -e "\nSystem command section:\n  project\n  push\n  update\n  upload"
    echo -e "\nRebuild software section:\n  osdrv2\n  release"
    echo -e "\n#####################################"
    (echo -e "\nCheck OPENWRT repo...\n" ; git status)
    echo -e "\n#####################################"
    (echo -e "\nCheck GLUTINIUM feed...\n" ; cd feeds/glutinium ; git status)
    echo -e "\n#####################################"
    #(echo -e "\nCheck ZFTLAB feed...\n" ; cd feeds/zftlab ; git status)
    #echo -e "\n#####################################"
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

