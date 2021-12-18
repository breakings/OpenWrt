#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 删除软件包
 #rm -rf feeds/packages/net/openssh
 #rm -rf feeds/packages/sound/fdk-aac
 rm -rf feeds/packages/utils/lvm2
 #rm -rf feeds/packages/utils/tini
 rm -rf feeds/packages/net/kcptun
 #rm -rf package/lean/ntfs3
 #rm -rf package/lean/luci-app-cpufreq
 #rm include/feeds.mk
 #wget -P include https://raw.githubusercontent.com/openwrt/openwrt/master/include/feeds.mk
 #rm -rf package/libs/elfutils
 #rm -rf feeds/packages/utils/gnupg
 rm -rf feeds/packages/lang/python/python3
 #rm -rf package/lean/n2n_v2
 
# ARM64: Add CPU model name in proc cpuinfo
#wget -P target/linux/generic/pending-5.4 https://github.com/immortalwrt/immortalwrt/raw/master/target/linux/generic/hack-5.4/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch
# autocore
sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_ipq807x||TARGET_mvebu||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile
# Add cputemp.sh
#cp -rf $GITHUB_WORKSPACE/PATCH/new/script/cputemp.sh ./package/base-files/files/bin/cputemp.sh

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

#添加额外软件包
#git clone https://github.com/immortalwrt/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic
#git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
svn co https://github.com/jerrykuku/lua-maxminddb/trunk package/lua-maxminddb
svn co https://github.com/jerrykuku/luci-app-vssr/trunk package/luci-app-vssr
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
#git clone https://github.com/project-lede/luci-app-godproxy package/luci-app-godproxy
svn co https://github.com/iwrt/luci-app-ikoolproxy/trunk package/luci-app-ikoolproxy
#svn co https://github.com/openwrt/luci/trunk/modules/luci-mod-dashboard feeds/luci/modules/luci-mod-dashboard
#svn co https://github.com/openwrt/packages/trunk/net/openssh package/openssh
#svn co https://github.com/openwrt/packages/trunk/libs/libfido2 package/libfido2
#svn co https://github.com/openwrt/packages/trunk/libs/libcbor package/libcbor
svn co https://github.com/ophub/luci-app-amlogic/trunk/luci-app-amlogic package/luci-app-amlogic
#svn co https://github.com/breakings/OpenWrt/trunk/general/luci-app-cpufreq package/luci-app-cpufreq
#svn co https://github.com/breakings/OpenWrt/trunk/general/ntfs3 package/lean/ntfs3
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-socat package/luci-app-socat
#svn co https://github.com/neheb/openwrt/branches/elf/package/libs/elfutils package/libs/elfutils
#svn co https://github.com/breakings/OpenWrt/trunk/general/gnupg feeds/packages/utils/gnupg
#svn co https://github.com/breakings/OpenWrt/trunk/general/n2n_v2 package/lean/n2n_v2

# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/luci-app-openclash/tools/po2lmo
make && sudo make install
popd
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/brook
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/chinadns-ng package/chinadns-ng
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/tcping package/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-go package/trojan-go
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan-plus package/trojan-plus
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-filebrowser package/luci-app-filebrowser
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/filebrowser package/filebrowser
#svn co https://github.com/project-openwrt/openwrt/trunk/package/lienol/luci-app-fileassistant package/luci-app-fileassistant
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/luci-app-passwall package/luci-app-passwall
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/shadowsocks-rust package/shadowsocks-rust
#svn co https://github.com/fw876/helloworld/trunk/shadowsocks-rust package/shadowsocks-rust
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-core package/xray-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-plugin package/xray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks package/ssocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/dns2socks package/dns2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ipt2socks package/ipt2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/microsocks package/microsocks 
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/pdnsd-alt package/pdnsd-alt
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/shadowsocksr-libev package/shadowsocksr-libev
svn co https://github.com/fw876/helloworld/trunk/shadowsocksr-libev package/shadowsocksr-libev
#svn co https://github.com/fw876/helloworld/trunk/tcping package/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-core package/v2ray-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-plugin package/v2ray-plugin
#svn co https://github.com/fw876/helloworld/trunk/v2ray-plugin package/v2ray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/simple-obfs package/simple-obfs
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/kcptun package/kcptun
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan package/trojan
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/hysteria

#svn co https://github.com/fw876/helloworld/trunk/xray-core package/xray-core
#svn co https://github.com/fw876/helloworld/trunk/xray-plugin package/xray-plugin
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-gost package/luci-app-gost
svn co https://github.com/kenzok8/openwrt-packages/trunk/gost package/gost
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-gost package/luci-app-gost
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gost package/gost
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/luci-app-eqos
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus
#svn co https://github.com/fw876/helloworld/trunk/naiveproxy package/naiveproxy
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/naiveproxy package/naiveproxy
git clone https://github.com/semigodking/redsocks.git package/redsocks2
svn co https://github.com/rufengsuixing/luci-app-adguardhome/trunk package/luci-app-adguardhome
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-filebrowser package/luci-app-filebrowser
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-ssr-mudb-server package/luci-app-ssr-mudb-server
svn co https://github.com/halldong/luci-app-speederv2/trunk package/luci-app-speederv2

#添加smartdns
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/smartdns package/smartdns
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns package/luci-app-smartdns
#svn co https://github.com/openwrt/luci/trunk/applications/luci-app-smartdns package/luci-app-smartdns
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-smartdns package/luci-app-smartdns
svn co https://github.com/kenzok8/openwrt-packages/branches/main/luci-app-smartdns package/luci-app-smartdns

#mosdns
#svn co https://github.com/QiuSimons/openwrt-mos/trunk/mosdns package/mosdns
svn co https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns package/luci-app-mosdns

#修改bypass的makefile
#git clone https://github.com/garypang13/luci-app-bypass package/luci-app-bypass
#find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
#find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
#find package/luci-app-bypass/*/ -maxdepth 8 -path "*" | xargs -i sed -i 's/smartdns-le/smartdns/g' {}

#添加ddnsto
#svn co https://github.com/linkease/ddnsto-openwrt/trunk/ddnsto package/ddnsto
#svn co https://github.com/linkease/ddnsto-openwrt/trunk/luci-app-ddnsto package/luci-app-ddnsto
#添加udp2raw
#git clone https://github.com/sensec/openwrt-udp2raw package/openwrt-udp2raw
svn co https://github.com/sensec/openwrt-udp2raw/trunk package/openwrt-udp2raw
#git clone https://github.com/sensec/luci-app-udp2raw package/luci-app-udp2raw
svn co https://github.com/sensec/luci-app-udp2raw/trunk package/luci-app-udp2raw
sed -i "s/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=f2f90a9a150be94d50af555b53657a2a4309f287/" package/openwrt-udp2raw/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=20200920\.0/" package/openwrt-udp2raw/Makefile

#themes
svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/luci-theme-rosy
#git clone https://github.com/rosywrt/luci-theme-purple.git package/luci-theme-purple
#git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
svn co https://github.com/Leo-Jo-My/luci-theme-opentomcat/trunk package/luci-theme-opentomcat
svn co https://github.com/Leo-Jo-My/luci-theme-opentomato/trunk package/luci-theme-opentomato
#svn co https://github.com/sirpdboy/luci-theme-opentopd/trunk package/luci-theme-opentopd
#git clone https://github.com/kevin-morgan/luci-theme-argon-dark.git package/luci-theme-argon-dark
#svn co https://github.com/kevin-morgan/luci-theme-argon-dark/trunk package/luci-theme-argon-dark
#svn co https://github.com/openwrt/luci/trunk/themes/luci-theme-openwrt-2020 package/luci-theme-openwrt-2020

# fix nginx-ssl-util error (do not use fallthrough attribute)
#rm feeds/packages/net/nginx-util/src/nginx-ssl-util.hpp
#wget -P feeds/packages/net/nginx-util/src https://raw.githubusercontent.com/openwrt/packages/master/net/nginx-util/src/nginx-ssl-util.hpp

# fdk-aac
#svn co https://github.com/openwrt/packages/trunk/sound/fdk-aac feeds/packages/sound/fdk-aac

# lvm2
svn co https://github.com/openwrt/packages/trunk/utils/lvm2 feeds/packages/utils/lvm2

# tini
#svn co https://github.com/openwrt/packages/trunk/utils/tini feeds/packages/utils/tini

#删除docker无脑初始化教程
#sed -i '31,39d' package/lean/luci-app-docker/po/zh-cn/docker.po
#rm -rf lean/luci-app-docker/root/www

# samba4
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.14.10/g' feeds/packages/net/samba4/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=107ee862f58062682cec362ec68a24251292805f89aa4c97e7ab80237f91c7af/g' feeds/packages/net/samba4/Makefile

# ffmpeg
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.4.1/g' feeds/packages/multimedia/ffmpeg/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=eadbad9e9ab30b25f5520fbfde99fae4a92a1ae3c0257a8d68569a4651e30e02/g' feeds/packages/multimedia/ffmpeg/Makefile

# 晶晨宝盒
sed -i "s|https.*/amlogic-s9xxx-openwrt|https://github.com/breakings/OpenWrt|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|http.*/library|https://github.com/breakings/OpenWrt/opt/kernel|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|s9xxx_lede|ARMv8|g" package/luci-app-amlogic/root/etc/config/amlogic
#sed -i "s|.img.gz|..OPENWRT_SUFFIX|g" package/luci-app-amlogic/root/etc/config/amlogic

# btrfs-progs
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.13.1/g' feeds/packages/utils/btrfs-progs/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=3d7e5a01e68fbaf485c5f1da15c6b8a7d1455fb57b6e75a706f8e2bb37f4f399/g' feeds/packages/utils/btrfs-progs/Makefile

# qBittorrent
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=4.3.7/g" package/lean/qBittorrent/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=d17c0bd852aaf8b75d61026ee213ad9147c37d8e3a14a3137b735732061bd1b1/g" package/lean/qBittorrent/Makefile

# golang
sed -i 's/GO_VERSION_PATCH:=.*/GO_VERSION_PATCH:=5/g' feeds/packages/lang/golang/golang/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=3defb9a09bed042403195e872dcbc8c6fae1485963332279668ec52e80a95a2d/g' feeds/packages/lang/golang/golang/Makefile

# curl
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=7.78.0/g' feeds/packages/net/curl/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=be42766d5664a739c3974ee3dfbbcbe978a4ccb1fe628bb1d9b59ac79e445fb5/g' feeds/packages/net/curl/Makefile
#rm -f feeds/packages/net/curl/Makefile
#wget -P feeds/packages/net/curl https://raw.githubusercontent.com/openwrt/packages/master/net/curl/Makefile

# Qt5 -qtbase
#sed -i "s/PKG_BUGFIX:=.*/PKG_BUGFIX:=2/g" package/lean/qtbase/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=909fad2591ee367993a75d7e2ea50ad4db332f05e1c38dd7a5a274e156a4e0f8/g" package/lean/qtbase/Makefile
#mkdir package/lean/qtbase/patches
#wget -P package/lean/qtbase/patches/ https://raw.githubusercontent.com/breakings/OpenWrt/main/general/001-gcc11.patch

# Qt5 -qttools
#sed -i "s/PKG_BUGFIX:=.*/PKG_BUGFIX:=2/g" package/lean/qttools/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=c189d0ce1ff7c739db9a3ace52ac3e24cb8fd6dbf234e49f075249b38f43c1cc/g" package/lean/qttools/Makefile

#fix speedtest-cli
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=2.1.3/g" feeds/packages/lang/python/python3-speedtest-cli/Makefile
#sed -i "s/PKG_RELEASE:=.*/PKG_RELEASE:=1/g" feeds/packages/lang/python/python3-speedtest-cli/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=5e2773233cedb5fa3d8120eb7f97bcc4974b5221b254d33ff16e2f1d413d90f0/g" feeds/packages/lang/python/python3-speedtest-cli/Makefile

# node 
sed -i "s/PKG_VERSION:=v14.18.1/PKG_VERSION:=v14.18.2/g" feeds/packages/lang/node/Makefile
sed -i "s/PKG_HASH:=3fa1d71adddfab2f5e3e41874b4eddbdf92b65cade4a43922fb1e437afcf89ed/PKG_HASH:=3e8a9ce10f8bcd3628eb6dd049f7f03c84ba9219be6f9743e2221154b9cc680b/g" feeds/packages/lang/node/Makefile
#rm -f feeds/packages/lang/node/patches/v14.x/003-path.patch
#wget -P feeds/packages/lang/node/patches/v14.x https://raw.githubusercontent.com/openwrt/packages/master/lang/node/patches/003-path.patch
rm -f feeds/packages/lang/node/patches/v14.x/999-fix_building_with_system_c-ares_on_Linux.patch

# mbedtls
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.6.11/g' package/libs/mbedtls/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=$(AUTORELEASE)/g' package/libs/mbedtls/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=c18e7e9abf95e69e425260493720470021384a1728417042060a35d0b7b18b41/g' package/libs/mbedtls/Makefile

# docker
#sed -i 's/PKG_VERSION:=20.10.10/PKG_VERSION:=20.10.11/g' feeds/packages/utils/docker/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=55d55fdead906cbea8608ef39d5a62d54d1118e604a5ae7e2d58b4fb54a599a7/g' feeds/packages/utils/docker/Makefile
#sed -i 's/PKG_GIT_SHORT_COMMIT:=b485636/PKG_GIT_SHORT_COMMIT:=dea9396/g' feeds/packages/utils/docker/Makefile

# dockerd
#sed -i 's/PKG_VERSION:=20.10.10/PKG_VERSION:=20.10.11/' feeds/packages/utils/dockerd/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=6fa7835bf7c17c293621967bd5096642fa1e3e1b597fbc7d7bd35f455d886495/' feeds/packages/utils/dockerd/Makefile
#sed -i 's/PKG_GIT_SHORT_COMMIT:=e2f740d/PKG_GIT_SHORT_COMMIT:=847da18/' feeds/packages/utils/dockerd/Makefile

# docker-compose
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.2.2/g' feeds/packages/utils/docker-compose/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=001cf72f6bc8a8c43d100389e0bbd3d4d5f5c523f4e3f7ddd53f6a4cd2d6cb18/g' feeds/packages/utils/docker-compose/Makefile

# containerd
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.4.12/g' feeds/packages/utils/containerd/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=85a531725f15e2d136131119d42af4507a5389e0947015152075c4c93816fb5c/g' feeds/packages/utils/containerd/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=7b11cfaabd73bb80907dd23182b9347b4245eb5d/g' feeds/packages/utils/containerd/Makefile

# runc
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.0.3/g' feeds/packages/utils/runc/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=0eaf2f6606d72f166a5e7138a8a8d4d8f85d84e43448c08c66a1c93ead17a574/g' feeds/packages/utils/runc/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=f46b6ba2c9314cfc8caae24a32ec5fe9ef1059fe/g' feeds/packages/utils/runc/Makefile

# bsdtar
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.5.2/g' feeds/packages/libs/libarchive/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=f0b19ff39c3c9a5898a219497ababbadab99d8178acc980155c7e1271089b5a0/g' feeds/packages/libs/libarchive/Makefile

# pcre
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.45/g' package/libs/pcre/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=$(AUTORELEASE)/g' package/libs/pcre/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=4dae6fdcd2bb0bb6c37b5f97c33c2be954da743985369cddac3546e3218bffb8/g' package/libs/pcre/Makefile

# pcre2
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=10.39/g' feeds/packages/libs/pcre2/Makefile
sed -i 's|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=https://github.com/PhilipHazel/pcre2/releases/download/$(PKG_NAME)-$(PKG_VERSION)|g' feeds/packages/libs/pcre2/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=0f03caf57f81d9ff362ac28cd389c055ec2bf0678d277349a1a4bee00ad6d440/g' feeds/packages/libs/pcre2/Makefile

# libseccomp
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.5.3/g' feeds/packages/libs/libseccomp/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=59065c8733364725e9721ba48c3a99bbc52af921daf48df4b1e012fbc7b10a76/g' feeds/packages/libs/libseccomp/Makefile

# wsdd2
#sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2021-10-22/g' feeds/packages/net/wsdd2//Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=9831daf2e14e0e112b5ad95224e9167072d52aa3/g' feeds/packages/net/wsdd2//Makefile
#sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=403d7d20bf2ae67e898db4543c61cc07f337cedf038a11c84a2af5504cfb82e9/g' feeds/packages/net/wsdd2//Makefile

# openvpn
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.5.5/g' feeds/packages/net/openvpn/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=119bd69fa0210838f6cdaa273696dc738efa200f454dbe11eb6dfb75dfb6003b/g' feeds/packages/net/openvpn/Makefile

# php7
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=7.4.27/g' feeds/packages/lang/php7//Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=3f8b937310f155822752229c2c2feb8cc2621e25a728e7b94d0d74c128c43d0c/g' feeds/packages/lang/php7//Makefile

# php8
#rm -rf feeds/packages/lang/php8
#svn co https://github.com/openwrt/packages/trunk/lang/php8 feeds/packages/lang/php8
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.1.1/g' feeds/packages/lang/php8/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=33c09d76d0a8bbb5dd930d9dd32e6bfd44e9efcf867563759eb5492c3aff8856/g' feeds/packages/lang/php8/Makefile

# python-docker
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.0.3/g' feeds/packages/lang/python/python-docker/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=d916a26b62970e7c2f554110ed6af04c7ccff8e9f81ad17d0d40c75637e227fb/g' feeds/packages/lang/python/python-docker/Makefile

# coremark
#sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2021-11-17/g' feeds/packages/utils/coremark//Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/coremarkMakefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=45faaf84d2b76a413129909605fb4f09e55645e3/g' feeds/packages/utils/coremark/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=3c74d1789ed8e7a9cf2c6ad6ad68b33ed5bc87abe405af04088ab418e240ffe1/g' feeds/packages/utils/coremark/Makefile

# kcptun
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=20210922/g' package/kcptun/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=f6a08f0fe75fa85d15f9c0c28182c69a5ad909229b4c230a8cbe38f91ba2d038/g' package/kcptun/Makefile

# parted
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.4/g' feeds/packages/utils/parted/Makefile
sed -i 's/PKG_MD5SUM:=.*/PKG_MD5SUM:=357d19387c6e7bc4a8a90fe2d015fe80/g' feeds/packages/utils/parted/Makefile

# wolfSSL
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.0.0-stable/g' package/libs/wolfssl/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=908390282cc613a3943533f3d922b3c18dee3289f498b6f944cb86a19a5eeb56/g' package/libs/wolfssl/Makefile
rm -f package/libs/wolfssl/patches/002-Update-macro-guard-on-SHA256-transform-call.patch

# socat
rm -rf feeds/packages/net/socat
svn co https://github.com/openwrt/packages/trunk/net/socat feeds/packages/net/socat
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.7.4.2/g' feeds/packages/net/socat/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/socat/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=6690a9f9990457b505097a272bbf2cbf4cc35576176f76646e3524b0e91c1763/g' feeds/packages/net/socat/Makefile
#rm -f feeds/packages/net/socat/patches/100-usleep.patch

# transmission-web-control
sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2021-09-25/g' feeds/packages/net/transmission-web-control/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=4b2e1858f7a46ee678d5d1f3fa1a6cf2c739b88a/g' feeds/packages/net/transmission-web-control/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=ea014c295766e2efc7b890dc6a6940176ba9c5bdcf85a029090f2bb850e59708/g' feeds/packages/net/transmission-web-control/Makefile

# htop
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.1.2/g' feeds/packages/admin/htop/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=fe9559637c8f21f5fd531a4c072048a404173806acbdad1359c6b82fd87aa001/g' feeds/packages/admin/htop/Makefile
#rm -rf feeds/packages/admin/htop/patches

# python3
sed -i 's/PYTHON3_VERSION_MICRO:=.*/PYTHON3_VERSION_MICRO:=9/g' feeds/packages/lang/python/python3-version.mk
sed -i 's/PYTHON3_SETUPTOOLS_VERSION:=.*/PYTHON3_SETUPTOOLS_VERSION:=58.1.0/g' feeds/packages/lang/python/python3-version.mk
sed -i 's/PYTHON3_PIP_VERSION:=.*/PYTHON3_PIP_VERSION:=21.2.4/g' feeds/packages/lang/python/python3-version.mk
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python3/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=06828c04a573c073a4e51c4292a27c1be4ae26621c3edc7cf9318418ce3b6d27/g' feeds/packages/lang/python/python3/Makefile
svn co https://github.com/openwrt/packages/branches/openwrt-21.02/lang/python/python3 feeds/packages/lang/python/python3

# python-yaml
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=6.0/g' feeds/packages/lang/python/python-yaml/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python-yaml/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=68fb519c14306fec9720a2a5b45bc9f0c8d1b9c72adf45c37baedfcd949c35a2/g' feeds/packages/lang/python/python-yaml/Makefile
sed -i '22i\HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:=Cython\n' feeds/packages/lang/python/python-yaml/Makefile

# python-websocket-client
#sed -i 's/PYPI_NAME:=.*/PYPI_NAME:=websocket-client/g' feeds/packages/lang/python/python-websocket-client/Makefile
#sed -i 's/PKG_LICENSE:=*/PKG_LICENSE:=Apache-2.0/g' feeds/packages/lang/python/python-websocket-client/Makefile
#sed -i 's/DEPENDS:=.*/DEPENDS:=+python3-light +python3-logging +python3-openssl/g' feeds/packages/lang/python/python-websocket-client/Makefile
#sed -i '34i\define Py3Package/python3-websocket-client/filespec' feeds/packages/lang/python/python-websocket-client/Makefile
#sed -i '35i\+|$(PYTHON3_PKG_DIR)' feeds/packages/lang/python/python-websocket-client/Makefile
#sed -i '36i\-|$(PYTHON3_PKG_DIR)/websocket/tests' feeds/packages/lang/python/python-websocket-client/Makefile
#sed -i '37i\endef\n' feeds/packages/lang/python/python-websocket-client/Makefile
rm -f feeds/packages/lang/python/python-websocket-client/Makefile
wget -P feeds/packages/lang/python/python-websocket-client https://raw.githubusercontent.com/openwrt/packages/master/lang/python/python-websocket-client/Makefile
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2.3/g' feeds/packages/lang/python/python-websocket-client/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=1315816c0acc508997eb3ae03b9d3ff619c9d12d544c9a9b553704b1cc4f6af5/g' feeds/packages/lang/python/python-websocket-client/Makefile

# python-texttable
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.6.4/g' feeds/packages/lang/python/python-texttable/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=42ee7b9e15f7b225747c3fa08f43c5d6c83bc899f80ff9bae9319334824076e9/g' feeds/packages/lang/python/python-texttable/Makefile

# python-urllib3
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.26.7/g' feeds/packages/lang/python/python-urllib3/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=4987c65554f7a2dbf30c18fd48778ef124af6fab771a377103da0585e2336ece/g' feeds/packages/lang/python/python-urllib3/Makefile

# python-sqlalchemy
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.4.28/g' feeds/packages/lang/python/python-sqlalchemy/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=7fdb7b775fb0739d3e71461509f978beb788935bc0aa9e47df14837cb33e5226/g' feeds/packages/lang/python/python-sqlalchemy/Makefile

# python-simplejson
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.17.6/g' feeds/packages/lang/python/python-simplejson/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=cf98038d2abf63a1ada5730e91e84c642ba6c225b0198c3684151b1f80c5f8a6/g' feeds/packages/lang/python/python-simplejson/Makefile

# python-pyrsistent
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.18.0/g' feeds/packages/lang/python/python-pyrsistent/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=773c781216f8c2900b42a7b638d5b517bb134ae1acbebe4d1e8f1f41ea60eb4b/g' feeds/packages/lang/python/python-pyrsistent/Makefile

# python-pycparser
rm -rf feeds/packages/lang/python/python-pycparser
svn co https://github.com/openwrt/packages/trunk/lang/python/python-pycparser feeds/packages/lang/python/python-pycparser

# python-paramiko
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.8.1/g' feeds/packages/lang/python/python-paramiko/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=85b1245054e5d7592b9088cc6d08da22445417912d3a3e48138675c7a8616438/g' feeds/packages/lang/python/python-paramiko/Makefile

# python-lxml
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.6.5/g' feeds/packages/lang/python/python-lxml/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=6e84edecc3a82f90d44ddee2ee2a2630d4994b8471816e226d2b771cda7ac4ca/g' feeds/packages/lang/python/python-lxml/Makefile

# python-idna
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.3/g' feeds/packages/lang/python/python-idna/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=9d643ff0a55b762d5cdb124b8eaa99c66322e2157b69160bc32796e824360e6d/g' feeds/packages/lang/python/python-idna/Makefile

# python-dns
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.1.0/g' feeds/packages/lang/python/python-dns/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=e4a87f0b573201a0f3727fa18a516b055fd1107e0e5477cded4a2de497df1dd4/g' feeds/packages/lang/python/python-dns/Makefile

# python-certifi
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2021.10.8/g' feeds/packages/lang/python/python-certifi/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=78884e7c1d4b00ce3cea67b44566851c4343c120abd683433ce934a68ea58872/g' feeds/packages/lang/python/python-certifi/Makefile

# bcrypt
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.2.0/g' feeds/packages/lang/python/bcrypt/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/bcrypt/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=5b93c1726e50a93a033c36e5ca7fdcd29a5c7395af50a6892f5d9e7c6cfbfb29/g' feeds/packages/lang/python/bcrypt/Makefile

# python-dotenv
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.19.2/g' feeds/packages/lang/python/python-dotenv/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=a5de49a31e953b45ff2d2fd434bbc2670e8db5273606c1e737cc6b93eff3655f/g' feeds/packages/lang/python/python-dotenv/Makefile

# python-cffi
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.15.0/g' feeds/packages/lang/python/python-cffi/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=920f0d66a896c2d99f0adbb391f990a84091179542c205fa53ce5787aff87954/g' feeds/packages/lang/python/python-cffi/Makefile

# python-cryptography
rm -rf feeds/packages/lang/python/python-cryptography
svn co https://github.com/openwrt/packages/trunk/lang/python/python-cryptography feeds/packages/lang/python/python-cryptography

# python-distro
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.6.0/g' feeds/packages/lang/python/python-distro/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python-distro/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=83f5e5a09f9c5f68f60173de572930effbcc0287bb84fdc4426cb4168c088424/g' feeds/packages/lang/python/python-distro/Makefile

# python-dateutil
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.8.2/g' feeds/packages/lang/python/python-dateutil/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python-dateutil/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86/g' feeds/packages/lang/python/python-dateutil/Makefile

# python-requests
rm -rf feeds/packages/lang/python/python-requests
svn co https://github.com/openwrt/packages/trunk/lang/python/python-requests feeds/packages/lang/python/python-requests

# host-pip-requirements
sed -i 's/cffi==1.14.5 --hash=sha256:fd78e5fee591709f32ef6edb9a015b4aa1a5022598e36227500c8f4e02328d9c/cffi==1.15.0 --hash=sha256:920f0d66a896c2d99f0adbb391f990a84091179542c205fa53ce5787aff87954/g' feeds/packages/lang/python/host-pip-requirements/cffi.txt
sed -i 's/pycparser==2.20 --hash=sha256:2d475327684562c3a96cc71adf7dc8c4f0565175cf86b6d7a404ff4c771f15f0/pycparser==2.21 --hash=sha256:e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206/g' feeds/packages/lang/python/host-pip-requirements/cffi.txt
sed -i 's/Cython==0.29.21 --hash=sha256:e57acb89bd55943c8d8bf813763d20b9099cc7165c0f16b707631a7654be9cad/Cython==0.29.24 --hash=sha256:cdf04d07c3600860e8c2ebaad4e8f52ac3feb212453c1764a49ac08c827e8443/g' feeds/packages/lang/python/host-pip-requirements/Cython.txt
sed -i 's/setuptools-scm==4.1.2 --hash=sha256:a8994582e716ec690f33fec70cca0f85bd23ec974e3f783233e4879090a7faa8/setuptools-scm==6.0.1 --hash=sha256:d1925a69cb07e9b29416a275b9fadb009a23c148ace905b2fb220649a6c18e92/g' feeds/packages/lang/python/host-pip-requirements/setuptools-scm.txt

# gzip
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.11/g' feeds/packages/utils/gzip/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/gzip/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=9b9a95d68fdcb936849a4d6fada8bf8686cddf58b9b26c9c4289ed0c92a77907/g' feeds/packages/utils/gzip/Makefile

# libev
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.33/g' feeds/packages/libs/libev/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/libs/libev/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=507eb7b8d1015fbec5b935f34ebed15bf346bed04a11ab82b8eee848c4205aea/g' feeds/packages/libs/libev/Makefile

# zerotier
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.8.4/g' feeds/packages/net/zerotier/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=61b8c1ea5904cc87431939212033bb4d05d11f517860a01cac75f0090d94272b/g' feeds/packages/net/zerotier/Makefile

# luci-app-n2n_v2
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.0/g' package/lean/luci-app-n2n_v2/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' package/lean/luci-app-n2n_v2/Makefile

# openssh
sed -i '175i\	--with-sandbox=rlimit \\' feeds/packages/net/openssh/Makefile

# nss
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.73/g' feeds/packages/libs/nss/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=566d3a68da9b10d7da9ef84eb4fe182f8f04e20d85c55d1bf360bb2c0096d8e5/g' feeds/packages/libs/nss/Makefile

# softethervpn5
rm -rf feeds/packages/net/softethervpn5
svn co https://github.com/openwrt/packages/trunk/net/softethervpn5 feeds/packages/net/softethervpn5

# hwdata
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.354/g' feeds/packages/utils/hwdata/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=ed9a2c8b90371ccf4f0ff88972d87770c1c644e63ca44d2ac72c33200642cdde/g' feeds/packages/utils/hwdata/Makefile

# gawk
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.1.1/g' feeds/packages/utils/gawk/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=d87629386e894bbea11a5e00515fc909dc9b7249529dad9e6a3a2c77085f7ea2/g' feeds/packages/utils/gawk/Makefile

# ocserv
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.1.4/g' feeds/packages/net/ocserv/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=e8693f05ff412e3e6ea0c1370a8359dec5502a1ed05d21d2493e10cf15c83bc0/g' feeds/packages/net/ocserv/Makefile

# unrar
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=6.0.7/g' feeds/packages/utils/unrar/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=a7029942006cbcced3f3b7322ec197683f8e7be408972ca08099b196c038f518/g' feeds/packages/utils/unrar/Makefile

# at
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.2.2/g' feeds/packages/utils/at/Makefile
sed -i 's|PKG_SOURCE_VERSION:=.*|PKG_SOURCE_VERSION:=release/3.2.2|g' feeds/packages/utils/at/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH=93f7f99c4242dbc5218907981e32f74ddb5e09c5b7922617c8d84c16920f488d/g' feeds/packages/utils/at/Makefile

# mmc-utils
rm -rf feeds/packages/utils/mmc-utils
svn co https://github.com/openwrt/packages/trunk/utils/mmc-utils feeds/packages/utils/mmc-utils
#sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2021-12-11/g' feeds/packages/utils/mmc-utils/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=a1b233c2a31baa5b77cb67c0c3be4767be86f727/g' feeds/packages/utils/mmc-utils/Makefile
#sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=3a1b75afd51f22054bc06d5dce79408c0c20b1f26b85251c8964bbc1e04a4b4b/g' feeds/packages/utils/mmc-utils/Makefile

# nfs-kernel-server
rm -rf feeds/packages/net/nfs-kernel-server
svn co https://github.com/openwrt/packages/trunk/net/nfs-kernel-server feeds/packages/net/nfs-kernel-server

# alsa-utils
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2.6/g' feeds/packages/sound/alsa-utils/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=6a1efd8a1f1d9d38e489633eaec1fffa5c315663b316cab804be486887e6145d/g' feeds/packages/sound/alsa-utils/Makefile

# alsa-ucm-conf
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2.6.2/g' feeds/packages/libs/alsa-ucm-conf/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=8be24fb9fe789ee2778ae6f32e18e8043fe7f8bc735871e9d17c68a04566a822/g' feeds/packages/libs/alsa-ucm-conf/Makefile

# alsa-lib
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2.6.1/g' feeds/packages/libs/alsa-lib/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=ad582993d52cdb5fb159a0beab60a6ac57eab0cc1bdf85dc4db6d6197f02333f/g' feeds/packages/libs/alsa-lib/Makefile
rm -f feeds/packages/libs/alsa-lib/patches/*.patch
wget -P feeds/packages/libs/alsa-lib/patches https://github.com/openwrt/packages/raw/master/libs/alsa-lib/patches/100-link_fix.patch
wget -P feeds/packages/libs/alsa-lib/patches https://raw.githubusercontent.com/openwrt/packages/master/libs/alsa-lib/patches/200-usleep.patch

# hdparm
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=9.62/g' feeds/packages/utils/hdparm/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=2c0f9d75cdbeda928a25a128cd3d0b7120445ec0910c0b29d4c1038ed1be777f/g' feeds/packages/utils/hdparm/Makefile

# libcap-ng
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.8.2/g' feeds/packages/libs/libcap-ng/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=52c083b77c2b0d8449dee141f9c3eba76e6d4c5ad44ef05df25891126cb85ae9/g' feeds/packages/libs/libcap-ng/Makefile

# c-ares
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.18.1/g' feeds/packages/libs/c-ares/Makefile
sed -i 's|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=https://c-ares.org/download|g' feeds/packages/libs/c-ares/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=1a7d52a8a84a9fbffb1be9133c0f6e17217d91ea5a6fa61f6b4729cda78ebbcf/g' feeds/packages/libs/c-ares/Makefile

# libevdev
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.12.0/g' feeds/packages/libs/libevdev/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2f729e3480695791f9482e8388bd723402b89f0eaf118057bbdea3cecee9b237/g' feeds/packages/libs/libevdev/Makefile

# zstd
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.5.0/g' feeds/packages/utils/zstd/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=9aa8dfc1ca17f358b28988ca1f6e00ffe1c6f3198853f8d2022799e6f0669180/g' feeds/packages/utils/zstd/Makefile
#sed -i 's/Dlegacy_level=1/Dlegacy_level=7/g' feeds/packages/utils/zstd/Makefile
#sed -i 's/Dbin_control=false/Dbin_contrib=false/g' feeds/packages/utils/zstd/Makefile
#sed -i '77i\	-Dmulti_thread=enabled \\' feeds/packages/utils/zstd/Makefile
#rm -rf feeds/packages/utils/zstd/patches

# pigz
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.6/g' feeds/packages/utils/pigz/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=2eed7b0d7449d1d70903f2a62cd6005d262eb3a8c9e98687bc8cbb5809db2a7d/g' feeds/packages/utils/pigz/Makefile
rm -rf feeds/packages/utils/pigz/patches

# nano
#rm -rf feeds/packages/utils/nano
#svn co https://github.com/openwrt/packages/trunk/utils/nano feeds/packages/utils/nano

# dnsproxy
#rm -rf package/lean/dnsproxy
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.39.13/g' package/lean/dnsproxy/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=a6f865dd6970b3c6a3c34adbec6817535d33c48c93f9ab540280433d10c7169b/g' package/lean/dnsproxy/Makefile

# libnl-tiny
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' package/libs/libnl-tiny/Makefile
sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2021-11-21/g' package/libs/libnl-tiny/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=8e0555fb39f51a5d6436b4f1370850caa03611ea/g' package/libs/libnl-tiny/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=2cfbcc62384535674a2c0157cb24a0736520fcb66ed50be23bf9141c8488885f/g' package/libs/libnl-tiny/Makefile
sed -i '19,20d' package/libs/libnl-tiny/Makefile

# mac80211
rm -rf package/kernel/mac80211
svn co https://github.com/openwrt/openwrt/branches/openwrt-21.02/package/kernel/mac80211 package/kernel/mac80211

# mt76
rm -rf package/kernel/mt76
svn co https://github.com/openwrt/openwrt/branches/openwrt-21.02/package/kernel/mt76 package/kernel/mt76

# 可道云
#rm -rf package/lean/luci-app-kodexplorer
#cp -r $GITHUB_WORKSPACE/general/luci-app-kodexplorer package/lean/luci-app-kodexplorer

# exfatprogs
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.1.3/g' feeds/packages/utils/exfatprogs/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=e3ee4fb5af4abc9335aed7a749c319917c652ac1af687ba40aabd04a6b71f1ca/g' feeds/packages/utils/exfatprogs/Makefile

# shairport-sync
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.3.9/g' feeds/packages/sound/shairport-sync/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=17990cb2620551caa07a1c3b371889e55803071eaada04e958c356547a7e1795/g' feeds/packages/sound/shairport-sync/Makefile

# less
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=598/g' feeds/packages/utils/less/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=64e0eb24534ac70d15ff3a36c8853f7a48196aa230d2a104707fc4ff1a45e982/g' feeds/packages/utils/less/Makefile

# minizip
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.0.4/g' feeds/packages/libs/minizip/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=2ab219f651901a337a7d3c268128711b80330a99ea36bdc528c76b591a624c3c/g' feeds/packages/libs/minizip/Makefile
sed -i 's/DMZ_COMPAT=OFF/DMZ_COMPAT=ON/g' feeds/packages/libs/minizip/Makefile

# libupnp
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.14.12/g' feeds/packages/libs/libupnp/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=091c80aada1e939c2294245c122be2f5e337cc932af7f7d40504751680b5b5ac/g' feeds/packages/libs/libupnp/Makefile

# file
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.41/g' feeds/packages/libs/file/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=13e532c7b364f7d57e23dfeea3147103150cb90593a57af86c10e4f6e411603f/g' feeds/packages/libs/file/Makefile

# ariang
rm -rf feeds/packages/net/ariang
svn co https://github.com/openwrt/packages/trunk/net/ariang feeds/packages/net/ariang

# nginx
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.21.4/g' feeds/packages/net/nginx/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/nginx/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=d1f72f474e71bcaaf465dcc7e6f7b6a4705e4b1ed95c581af31df697551f3bfe/g' feeds/packages/net/nginx/Makefile

# 修改makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's|include\ \.\.\/\.\.\/devel/meson/meson.mk|include \$(INCLUDE_DIR)\/meson.mk|g' {}

# smartdns
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2021.34/g' feeds/packages/net/smartdns/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=756029f5e9879075c042030bd3aa3db06d700270/g' feeds/packages/net/smartdns/Makefile
#sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=c2979d956127946861977781beb3323ad9a614ae55014bc99ad39beb7a27d481/g' feeds/packages/net/smartdns/Makefile

# aliyundrive webdav
#svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav package/aliyundrive-webdav
#svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav package/luci-app-aliyundrive-webdav

# libpcap
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.10.1/g' package/libs/libpcap/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=$(AUTORELEASE)/g' package/libs/libpcap/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=ed285f4accaf05344f90975757b3dbfe772ba41d1c401c2648b7fa45b711bdd4/g' package/libs/libpcap/Makefile

# xray-plugin
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=4a178a2bacffcc2fd374c57e47b71eb0cb5667bfe747690a16501092c0618707/g' package/xray-plugin/Makefile

#readd cpufreq for aarch64
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile
sed -i 's/services/system/g'  package/lean/luci-app-cpufreq/luasrc/controller/cpufreq.lua

#fix NaïveProxy typo error
#sed -i 's/Na茂veProxy/NaïveProxy/g' package/naiveproxy/Makefile

#fix ntfs3 generating empty package
#sed -i 's/KCONFIG:=CONFIG_NLS_DEFAULT="utf8"/#KCONFIG:=CONFIG_NLS_DEFAULT="utf8"/'g package/lean/ntfs3/Makefile

#replace coremark.sh with the new one
#rm feeds/packages/utils/coremark/coremark.sh
#cp $GITHUB_WORKSPACE/general/coremark.sh feeds/packages/utils/coremark/

# fix luci-theme-opentomcat dockerman icon missing
rm -f package/luci-theme-opentomcat/files/htdocs/fonts/advancedtomato.woff
cp $GITHUB_WORKSPACE/general/advancedtomato.woff package/luci-theme-opentomcat/files/htdocs/fonts

./scripts/feeds update -a
./scripts/feeds install -a
