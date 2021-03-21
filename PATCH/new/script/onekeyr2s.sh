#!/bin/bash

cp -r ./SCRIPTS/R2S/. ./SCRIPTS/
cp -r ./SCRIPTS/. ./
bash 01_get_ready.sh
cd openwrt
cp -r ../SCRIPTS/. ./
bash 02_prepare_package.sh
bash 02_R2S.sh
chmod -R 755 ./
bash 03_convert_translation.sh
bash 04_remove_upx.sh
bash 05_create_acl_for_luci.sh -a
cp ../SEED/R2S/config.seed .config
make defconfig
make download -j10
chmod -R 755 ./
let make_process=$(nproc)+1
make toolchain/install -j${make_process} V=s
let make_process=$(nproc)+1
make -j${make_process} V=s || make -j${make_process} V=s
cd bin/targets/rockchip/armv8
/bin/bash ../../../../../SCRIPTS/06_cleaning.sh
