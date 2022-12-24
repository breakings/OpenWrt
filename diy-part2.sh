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
 #rm -rf feeds/packages/utils/lvm2
 #rm -rf feeds/packages/utils/tini
 #rm -rf feeds/packages/net/kcptun
 #rm -rf package/lean/ntfs3
 #rm -rf package/lean/luci-app-cpufreq
 #rm include/feeds.mk
 #wget -P include https://raw.githubusercontent.com/openwrt/openwrt/master/include/feeds.mk
 #rm -rf package/libs/elfutils
 #rm -rf feeds/packages/utils/gnupg
 #rm -rf feeds/packages/lang/python/python3
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
#svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-socat package/luci-app-socat
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
svn co https://github.com/xiaorouji/openwrt-passwall/branches/luci/luci-app-passwall package/luci-app-passwall
svn co https://github.com/xiaorouji/openwrt-passwall2/trunk/luci-app-passwall2 package/luci-app-passwall2
#cp -rf $GITHUB_WORKSPACE/general/luci-app-passwall package/luci-app-passwall
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
svn co https://github.com/fw876/helloworld/trunk/lua-neturl package/lua-neturl
#svn co https://github.com/fw876/helloworld/trunk/tcping package/tcping
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-core package/v2ray-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-plugin package/v2ray-plugin
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-geodata package/v2ray-geodata
#svn co https://github.com/fw876/helloworld/trunk/v2ray-plugin package/v2ray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/simple-obfs package/simple-obfs
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/kcptun package/kcptun
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan package/trojan
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/hysteria
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/dns2tcp package/dns2tcp
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/sagernet-core package/sagernet-core

svn co https://github.com/fw876/helloworld/trunk/dns2tcp package/dns2tcp
svn co https://github.com/fw876/helloworld/trunk/v2ray-geodata package/v2ray-geodata
#svn co https://github.com/fw876/helloworld/trunk/xray-core package/xray-core
#svn co https://github.com/fw876/helloworld/trunk/xray-plugin package/xray-plugin
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-gost package/luci-app-gost
cp -rf $GITHUB_WORKSPACE/general/luci-app-gost package/luci-app-gost
svn co https://github.com/kenzok8/openwrt-packages/trunk/gost package/gost
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-gost package/luci-app-gost
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gost package/gost
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/luci-app-eqos
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus
#svn co https://github.com/fw876/helloworld/trunk/naiveproxy package/naiveproxy
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/naiveproxy package/naiveproxy
svn co https://github.com/fw876/helloworld/trunk/redsocks2 package/redsocks2
svn co https://github.com/rufengsuixing/luci-app-adguardhome/trunk package/luci-app-adguardhome
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-filebrowser package/luci-app-filebrowser
svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-ssr-mudb-server package/luci-app-ssr-mudb-server
svn co https://gh.fakev.cn/kiddin9/openwrt-packages/trunk/luci-app-speederv2 package/luci-app-speederv2

#添加smartdns
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/smartdns package/smartdns
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns package/luci-app-smartdns
#svn co https://github.com/openwrt/luci/trunk/applications/luci-app-smartdns package/luci-app-smartdns
svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-smartdns package/luci-app-smartdns

#mosdns
#svn co https://github.com/QiuSimons/openwrt-mos/trunk/mosdns package/mosdns
#svn co https://github.com/QiuSimons/openwrt-mos/trunk/luci-app-mosdns package/luci-app-mosdns

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
svn co https://github.com/thinktip/luci-theme-neobird/trunk package/luci-theme-neobird

# fix nginx-ssl-util error (do not use fallthrough attribute)
#rm feeds/packages/net/nginx-util/src/nginx-ssl-util.hpp
#wget -P feeds/packages/net/nginx-util/src https://raw.githubusercontent.com/openwrt/packages/master/net/nginx-util/src/nginx-ssl-util.hpp

# fdk-aac
#svn co https://github.com/openwrt/packages/trunk/sound/fdk-aac feeds/packages/sound/fdk-aac

# lvm2
#svn co https://github.com/openwrt/packages/trunk/utils/lvm2 feeds/packages/utils/lvm2

# tini
#svn co https://github.com/openwrt/packages/trunk/utils/tini feeds/packages/utils/tini

#删除docker无脑初始化教程
#sed -i '31,39d' package/lean/luci-app-docker/po/zh-cn/docker.po
#rm -rf lean/luci-app-docker/root/www

# samba4
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.14.13/g' feeds/packages/net/samba4/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=e1df792818a17d8d21faf33580d32939214694c92b84fb499464210d86a7ff75/g' feeds/packages/net/samba4/Makefile
rm -rf feeds/packages/net/samba4
svn co https://github.com/openwrt/packages/trunk/net/samba4 feeds/packages/net/samba4

# ffmpeg
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.1.1/g' feeds/packages/multimedia/ffmpeg/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=95bf3ff8c496511e71e958fb249e663c8c9c3de583c5bebc0f5a9745abbc0435/g' feeds/packages/multimedia/ffmpeg/Makefile
#rm -f feeds/packages/multimedia/ffmpeg/patches/030-h264-mips.patch
#rm -rf feeds/packages/multimedia/ffmpeg
#cp -rf $GITHUB_WORKSPACE/general/ffmpeg feeds/packages/multimedia

# 晶晨宝盒
sed -i "s|https.*/amlogic-s9xxx-openwrt|https://github.com/breakings/OpenWrt|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|http.*/library|https://github.com/breakings/OpenWrt/opt/kernel|g" package/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|s9xxx_lede|ARMv8|g" package/luci-app-amlogic/root/etc/config/amlogic
#sed -i "s|.img.gz|..OPENWRT_SUFFIX|g" package/luci-app-amlogic/root/etc/config/amlogic

# btrfs-progs
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=6.0.2/g' feeds/packages/utils/btrfs-progs/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=6665863049d945fc32ccdacc55a7306767aa8f640f3b8b1fa5e0568a39ae7018/g' feeds/packages/utils/btrfs-progs/Makefile
rm -rf feeds/packages/utils/btrfs-progs/patches
#sed -i '68i\	--disable-libudev \\' feeds/packages/utils/btrfs-progs/Makefile

# qBittorrent (use cmake)
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.4.0/g' feeds/packages/net/qBittorrent/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=da240744c6cc5953d7c4d298a02a0cf36d2c8897931819f1e6459bd5270a7c5c/g' feeds/packages/net/qBittorrent/Makefile
#sed -i '41i\		+qt5-sql \\' feeds/packages/net/qBittorrent/Makefile
#cp -f $GITHUB_WORKSPACE/general/qBittorrent/Makefile feeds/packages/net/qBittorrent
cp -f $GITHUB_WORKSPACE/general/qBittorrent/Makefile feeds/packages/net/qBittorrent/Makefile

# libtorrent-rasterbar_v2
rm -rf feeds/packages/libs/libtorrent-rasterbar/patches
cp -f $GITHUB_WORKSPACE/general/libtorrent-rasterbar/Makefile feeds/packages/libs/libtorrent-rasterbar

# golang
sed -i 's/GO_VERSION_MAJOR_MINOR:=.*/GO_VERSION_MAJOR_MINOR:=1.19/g' feeds/packages/lang/golang/golang/Makefile
sed -i 's/GO_VERSION_PATCH:=.*/GO_VERSION_PATCH:=4/g' feeds/packages/lang/golang/golang/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=eda74db4ac494800a3e66ee784e495bfbb9b8e535df924a8b01b1a8028b7f368/g' feeds/packages/lang/golang/golang/Makefile
#rm -rf feeds/packages/lang/golang
#cp -rf $GITHUB_WORKSPACE/general/golang feeds/packages/lang/golang

# curl
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=7.86.0/g' feeds/packages/net/curl/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2d61116e5f485581f6d59865377df4463f2e788677ac43222b496d4e49fb627b/g' feeds/packages/net/curl/Makefile
#rm -f feeds/packages/net/curl
#svn co https://github.com/openwrt/packages/trunk/net/curl feeds/packages/net/curl

# Qt5 -qtbase
#sed -i "s/PKG_BUGFIX:=.*/PKG_BUGFIX:=6/g" feeds/packages/libs/qtbase/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=396bc6b0d773ac6a7c691a4c3d901999f571e3e7033d7fd6f65e4ef2b6eb7340/g" feeds/packages/libs/qtbase/Makefile
#rm -rf feeds/packages/libs/qtbase/patches
#cp -rf $GITHUB_WORKSPACE/general/qt6base feeds/packages/libs

# Qt5 -qttools
#sed -i "s/PKG_BUGFIX:=.*/PKG_BUGFIX:=6/g" feeds/packages/libs/qttools/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=2c1486ab7e6dad76fb34642cd4f91d533e5dfeec0ee527129c2c2ed4ab283c3b/g" feeds/packages/libs/qttools/Makefile
#rm -rf feeds/packages/libs/qttools
#cp -rf $GITHUB_WORKSPACE/general/qt6tools feeds/packages/libs

#fix speedtest-cli
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=2.1.3/g" feeds/packages/lang/python/python3-speedtest-cli/Makefile
#sed -i "s/PKG_RELEASE:=.*/PKG_RELEASE:=1/g" feeds/packages/lang/python/python3-speedtest-cli/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=5e2773233cedb5fa3d8120eb7f97bcc4974b5221b254d33ff16e2f1d413d90f0/g" feeds/packages/lang/python/python3-speedtest-cli/Makefile

# node 
#sed -i "s/PKG_VERSION:=v14.18.3/PKG_VERSION:=v14.19.2/g" feeds/packages/lang/node/Makefile
#sed -i "s/PKG_HASH:=783ac443cd343dd6c68d2abcf7e59e7b978a6a428f6a6025f9b84918b769d608/PKG_HASH:=ef4375a9152ff69f2823d7b20a3b53767a046164bbac7824429cb216d1688cf0/g" feeds/packages/lang/node/Makefile
#rm -f feeds/packages/lang/node/patches/v14.x/003-path.patch
#wget -P feeds/packages/lang/node/patches/v14.x https://raw.githubusercontent.com/openwrt/packages/master/lang/node/patches/003-path.patch
#rm -f feeds/packages/lang/node/patches/v14.x/999-fix_building_with_system_c-ares_on_Linux.patch

# mbedtls
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.16.12/g' package/libs/mbedtls/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=$(AUTORELEASE)/g' package/libs/mbedtls/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=294871ab1864a65d0b74325e9219d5bcd6e91c34a3c59270c357bb9ae4d5c393/g' package/libs/mbedtls/Makefile

# docker
sed -i 's/PKG_VERSION:=20.10.17/PKG_VERSION:=20.10.22/g' feeds/packages/utils/docker/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/docker/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=84d71ac2b508b54e8df9f3ea425aa33e254fd3645fe9bad5619b98eaffb33408/g' feeds/packages/utils/docker/Makefile
sed -i 's/PKG_GIT_SHORT_COMMIT:=100c701/PKG_GIT_SHORT_COMMIT:=3a2c30b/g' feeds/packages/utils/docker/Makefile

# dockerd
sed -i 's/PKG_VERSION:=20.10.17/PKG_VERSION:=20.10.22/g' feeds/packages/utils/dockerd/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/dockerd/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=ee0e2168e27ec87f1b0650e86af5d3e167a07fd2ff8c1ce3bb588f0b4f9a4658/g' feeds/packages/utils/dockerd/Makefile
sed -i 's/PKG_GIT_SHORT_COMMIT:=a89b842/PKG_GIT_SHORT_COMMIT:=42c8b31/g' feeds/packages/utils/dockerd/Makefile
#sed -i 's/^\s*$[(]call\sEnsureVendoredVersion/#&/' feeds/packages/utils/dockerd/Makefile

# docker-compose
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.14.1/g' feeds/packages/utils/docker-compose/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=4e3e92169ad9142718a168b71dc5027f173be4cdb6563f42c60677818efd7509/g' feeds/packages/utils/docker-compose/Makefile

# containerd
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.5.11/g' feeds/packages/utils/containerd/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=skip/g' feeds/packages/utils/containerd/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=3df54a852345ae127d1fa3092b95168e4a88e2f8/g' feeds/packages/utils/containerd/Makefile
cp -f $GITHUB_WORKSPACE/general/containerd/Makefile feeds/packages/utils/containerd

# runc
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.1.4/g' feeds/packages/utils/runc/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=4f02077432642eebd768fc857318ae7929290b3a3511eb1be338005e360cfa34/g' feeds/packages/utils/runc/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=5fd4c4d144137e991c4acebb2146ab1483a97925/g' feeds/packages/utils/runc/Makefile
#sed -i '12d' feeds/packages/utils/runc/Makefile

# bsdtar
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.6.2/g' feeds/packages/libs/libarchive/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=9e2c1b80d5fbe59b61308fdfab6c79b5021d7ff4ff2489fb12daf0a96a83551d/g' feeds/packages/libs/libarchive/Makefile

# pcre
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.45/g' package/libs/pcre/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' package/libs/pcre/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=4dae6fdcd2bb0bb6c37b5f97c33c2be954da743985369cddac3546e3218bffb8/g' package/libs/pcre/Makefile

# pcre2
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=10.41/g' feeds/packages/libs/pcre2/Makefile
sed -i 's|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=https://github.com/PCRE2Project/pcre2/releases/download/$(PKG_NAME)-$(PKG_VERSION)|g' feeds/packages/libs/pcre2/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=0f78cebd3e28e346475fb92e95fe9999945b4cbaad5f3b42aca47b887fb53308/g' feeds/packages/libs/pcre2/Makefile
#sed -i '58i\	-DPCRE2_SUPPORT_UNICODE=ON \\' feeds/packages/libs/pcre2/Makefile

# libseccomp
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.5.4/g' feeds/packages/libs/libseccomp/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=d82902400405cf0068574ef3dc1fe5f5926207543ba1ae6f8e7a1576351dcbdb/g' feeds/packages/libs/libseccomp/Makefile

# wsdd2
sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2022-04-25/g' feeds/packages/net/wsdd2//Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=e37443ac4c757dbf14167ec3f754ebe88244ad4b/g' feeds/packages/net/wsdd2//Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=45e0c37b8e275c8d088506f953aa25b30a31600ce67ccb4f60b1eda6688a5a8b/g' feeds/packages/net/wsdd2//Makefile

# openvpn
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.5.6/g' feeds/packages/net/openvpn/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=13c7c3dc399d1b571cabf189c4d34ae34656ee72b6bde2a8059c1e9bc61574ed/g' feeds/packages/net/openvpn/Makefile
#rm -rf feeds/packages/net/openvpn
#cp -rf $GITHUB_WORKSPACE/general/openvpn feeds/packages/net

# php8
#rm -rf feeds/packages/lang/php8
#svn co https://github.com/openwrt/packages/trunk/lang/php8 feeds/packages/lang/php8
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.1.13/g' feeds/packages/lang/php8/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=b15ef0ccdd6760825604b3c4e3e73558dcf87c75ef1d68ef4289d8fd261ac856/g' feeds/packages/lang/php8/Makefile

# python-docker
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=6.0.1/g' feeds/packages/lang/python/python-docker/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=896c4282e5c7af5c45e8b683b0b0c33932974fe6e50fc6906a0a83616ab3da97/g' feeds/packages/lang/python/python-docker/Makefile
#cp -f $GITHUB_WORKSPACE/general/python-docker/Makefile feeds/packages/lang/python/python-docker

# coremark
#sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2022-07-27/g' feeds/packages/utils/coremark//Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/coremarkMakefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=eefc986ebd3452d6adde22eafaff3e5c859f29e4/g' feeds/packages/utils/coremark/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=a5964bf215786d65d08941b6f9a9a4f4e50524f5391fa3826db2994c47d5e7f3/g' feeds/packages/utils/coremark/Makefile

# kcptun
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=20210922/g' package/kcptun/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=f6a08f0fe75fa85d15f9c0c28182c69a5ad909229b4c230a8cbe38f91ba2d038/g' package/kcptun/Makefile

# parted
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.5/g' feeds/packages/utils/parted/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=4938dd5c1c125f6c78b1f4b3e297526f18ee74aa43d45c248578b1d2470c05a2/g' feeds/packages/utils/parted/Makefile

# wolfSSL
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.4.0-stable/g' package/libs/wolfssl/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=dc36cc19dad197253e5c2ecaa490c7eef579ad448706e55d73d79396e814098b/g' package/libs/wolfssl/Makefile
#rm -rf package/libs/wolfssl
#cp -rf $GITHUB_WORKSPACE/general/wolfssl package/libs

# ustream-ssl
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' package/libs/ustream-ssl/Makefile
#sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2022-01-16/g' package/libs/ustream-ssl/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=868fd8812f477c110f9c6c5252c0bd172167b94c/g' package/libs/ustream-ssl/Makefile
#sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=dd28d5e846b391917cf83d66176653bdfa4e8a0d5b11144b65a012fe7693ddeb/g' package/libs/ustream-ssl/Makefile

# expat
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.5.0/g' feeds/packages/libs/expat/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=ef2420f0232c087801abf705e89ae65f6257df6b7931d37846a193ef2e8cdcbe/g' feeds/packages/libs/expat/Makefile
#cp -f $GITHUB_WORKSPACE/general/expat/Makefile feeds/packages/libs/expat

# socat
#rm -rf feeds/packages/net/socat
#svn co https://github.com/openwrt/packages/trunk/net/socat feeds/packages/net/socat
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.7.4.3/g' feeds/packages/net/socat/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/socat/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=d47318104415077635119dfee44bcfb41de3497374a9a001b1aff6e2f0858007/g' feeds/packages/net/socat/Makefile
sed -i '75i\	  sc_cv_getprotobynumber_r=2 \\' feeds/packages/net/socat/Makefile
#rm -f feeds/packages/net/socat/patches/100-usleep.patch

# transmission-web-control
sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2021-09-25/g' feeds/packages/net/transmission-web-control/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=4b2e1858f7a46ee678d5d1f3fa1a6cf2c739b88a/g' feeds/packages/net/transmission-web-control/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=ea014c295766e2efc7b890dc6a6940176ba9c5bdcf85a029090f2bb850e59708/g' feeds/packages/net/transmission-web-control/Makefile

# htop
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.2.1/g' feeds/packages/admin/htop/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=b5ffac1949a8daaabcffa659c0964360b5008782aae4dfa7702d2323cfb4f438/g' feeds/packages/admin/htop/Makefile

# python3
#sed -i 's/PYTHON3_VERSION_MICRO:=.*/PYTHON3_VERSION_MICRO:=15/g' feeds/packages/lang/python/python3-version.mk
#sed -i 's/PYTHON3_SETUPTOOLS_VERSION:=.*/PYTHON3_SETUPTOOLS_VERSION:=58.1.0/g' feeds/packages/lang/python/python3-version.mk
#sed -i 's/PYTHON3_PIP_VERSION:=.*/PYTHON3_PIP_VERSION:=21.2.4/g' feeds/packages/lang/python/python3-version.mk
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python3/Makefile
#svn co https://github.com/openwrt/packages/branches/openwrt-21.02/lang/python/python3 feeds/packages/lang/python/python3
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=12daff6809528d9f6154216950423c9e30f0e47336cb57c6aa0b4387dd5eb4b2/g' feeds/packages/lang/python/python3/Makefile
#sed -i '28i\python3-readline: readline\' feeds/packages/lang/python/python3-find-stdlib-depends.sh

# python-yaml
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=6.0/g' feeds/packages/lang/python/python-yaml/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python-yaml/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=68fb519c14306fec9720a2a5b45bc9f0c8d1b9c72adf45c37baedfcd949c35a2/g' feeds/packages/lang/python/python-yaml/Makefile
#sed -i '22i\HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:=Cython\n' feeds/packages/lang/python/python-yaml/Makefile

# python-websocket-client
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.4.2/g' feeds/packages/lang/python/python-websocket-client/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=d6e8f90ca8e2dd4e8027c4561adeb9456b54044312dba655e7cae652ceb9ae59/g' feeds/packages/lang/python/python-websocket-client/Makefile

# python-texttable
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.6.4/g' feeds/packages/lang/python/python-texttable/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=42ee7b9e15f7b225747c3fa08f43c5d6c83bc899f80ff9bae9319334824076e9/g' feeds/packages/lang/python/python-texttable/Makefile

# python-urllib3
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.26.12/g' feeds/packages/lang/python/python-urllib3/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=3fa96cf423e6987997fc326ae8df396db2a8b7c667747d47ddd8ecba91f4a74e/g' feeds/packages/lang/python/python-urllib3/Makefile

# python-sqlalchemy
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.4.44/g' feeds/packages/lang/python/python-sqlalchemy/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=2dda5f96719ae89b3ec0f1b79698d86eb9aecb1d54e990abb3fdd92c04b46a90/g' feeds/packages/lang/python/python-sqlalchemy/Makefile

# python-simplejson
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.18.0/g' feeds/packages/lang/python/python-simplejson/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=58a429d2c2fa80834115b923ff689622de8f214cf0dc4afa9f59e824b444ab31/g' feeds/packages/lang/python/python-simplejson/Makefile

# python-pyrsistent
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.19.2/g' feeds/packages/lang/python/python-pyrsistent/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=bfa0351be89c9fcbcb8c9879b826f4353be10f58f8a677efab0c017bf7137ec2/g' feeds/packages/lang/python/python-pyrsistent/Makefile

# python-pycparser
#rm -rf feeds/packages/lang/python/python-pycparser
#svn co https://github.com/openwrt/packages/trunk/lang/python/python-pycparser feeds/packages/lang/python/python-pycparser
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.21/g' feeds/packages/lang/python/python-pycparser/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python-pycparser/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206/g' feeds/packages/lang/python/python-pycparser/Makefile

# python-paramiko
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.12.0/g' feeds/packages/lang/python/python-paramiko/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=376885c05c5d6aa6e1f4608aac2a6b5b0548b1add40274477324605903d9cd49/g' feeds/packages/lang/python/python-paramiko/Makefile

# python-lxml
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.9.1/g' feeds/packages/lang/python/python-lxml/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=fe749b052bb7233fe5d072fcb549221a8cb1a16725c47c37e42b0b9cb3ff2c3f/g' feeds/packages/lang/python/python-lxml/Makefile

# python-idna
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.4/g' feeds/packages/lang/python/python-idna/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4/g' feeds/packages/lang/python/python-idna/Makefile

# python-dns
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.2.1/g' feeds/packages/lang/python/python-dns/Makefile
sed -i 's/PYPI_SOURCE_EXT:=.*/PYPI_SOURCE_EXT:=tar.gz/g' feeds/packages/lang/python/python-dns/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=0f7569a4a6ff151958b64304071d370daa3243d15941a7beedf0c9fe5105603e/g' feeds/packages/lang/python/python-dns/Makefile

# python-certifi
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2022.9.24/g' feeds/packages/lang/python/python-certifi/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=0d9c601124e5a6ba9712dbc60d9c53c21e34f5f641fe83002317394311bdce14/g' feeds/packages/lang/python/python-certifi/Makefile
#sed -i 's/DEPENDS:=.*/DEPENDS:=+python3-light +python3-urllib/g' feeds/packages/lang/python/python-certifi/Makefile

# bcrypt
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.2.2/g' feeds/packages/lang/python/bcrypt/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/bcrypt/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=433c410c2177057705da2a9f2cd01dd157493b2a7ac14c8593a16b3dab6b6bfb/g' feeds/packages/lang/python/bcrypt/Makefile

# python-dotenv
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.21.0/g' feeds/packages/lang/python/python-dotenv/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=b77d08274639e3d34145dfa6c7008e66df0f04b7be7a75fd0d5292c191d79045/g' feeds/packages/lang/python/python-dotenv/Makefile
#sed -i 's/DEPENDS:=.*/DEPENDS:=+python3-click +python3-light +python3-logging/g' feeds/packages/lang/python/python-dotenv/Makefile

# python-cffi
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.15.1/g' feeds/packages/lang/python/python-cffi/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=d400bfb9a37b1351253cb402671cea7e89bdecc294e8016a707f6d1d8ac934f9/g' feeds/packages/lang/python/python-cffi/Makefile

# python-cryptography
#rm -rf feeds/packages/lang/python/python-cryptography
#svn co https://github.com/openwrt/packages/trunk/lang/python/python-cryptography feeds/packages/lang/python/python-cryptography

# python-distro
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.8.0/g' feeds/packages/lang/python/python-distro/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python-distro/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=02e111d1dc6a50abb8eed6bf31c3e48ed8b0830d1ea2a1b78c61765c2513fdd8/g' feeds/packages/lang/python/python-distro/Makefile

# python-dateutil
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.8.2/g' feeds/packages/lang/python/python-dateutil/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python-dateutil/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86/g' feeds/packages/lang/python/python-dateutil/Makefile

# python-requests
#rm -rf feeds/packages/lang/python/python-requests/patches
#svn co https://github.com/openwrt/packages/trunk/lang/python/python-requests feeds/packages/lang/python/python-requests
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.28.1/g' feeds/packages/lang/python/python-requests/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python-requests/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=7c5599b102feddaa661c826c56ab4fee28bfd17f5abca1ebbe3e7f19d7c97983/g' feeds/packages/lang/python/python-requests/Makefile

# host-pip-requirements
#sed -i 's/cffi==1.50.0 --hash=sha256:920f0d66a896c2d99f0adbb391f990a84091179542c205fa53ce5787aff87954/cffi==1.15.1 --hash=sha256:d400bfb9a37b1351253cb402671cea7e89bdecc294e8016a707f6d1d8ac934f9/g' feeds/packages/lang/python/host-pip-requirements/cffi.txt
#sed -i 's/pycparser==2.20 --hash=sha256:2d475327684562c3a96cc71adf7dc8c4f0565175cf86b6d7a404ff4c771f15f0/pycparser==2.21 --hash=sha256:e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206/g' feeds/packages/lang/python/host-pip-requirements/cffi.txt
#sed -i 's/Cython==0.29.21 --hash=sha256:e57acb89bd55943c8d8bf813763d20b9099cc7165c0f16b707631a7654be9cad/Cython==0.29.24 --hash=sha256:cdf04d07c3600860e8c2ebaad4e8f52ac3feb212453c1764a49ac08c827e8443/g' feeds/packages/lang/python/host-pip-requirements/Cython.txt
#sed -i 's/setuptools-scm==4.1.2 --hash=sha256:a8994582e716ec690f33fec70cca0f85bd23ec974e3f783233e4879090a7faa8/setuptools-scm==6.0.1 --hash=sha256:d1925a69cb07e9b29416a275b9fadb009a23c148ace905b2fb220649a6c18e92/g' feeds/packages/lang/python/host-pip-requirements/setuptools-scm.txt

# gzip
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.12/g' feeds/packages/utils/gzip/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/gzip/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=ce5e03e519f637e1f814011ace35c4f87b33c0bbabeec35baf5fbd3479e91956/g' feeds/packages/utils/gzip/Makefile

# libev
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.33/g' feeds/packages/libs/libev/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/libs/libev/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=507eb7b8d1015fbec5b935f34ebed15bf346bed04a11ab82b8eee848c4205aea/g' feeds/packages/libs/libev/Makefile

# zerotier
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.10.2/g' feeds/packages/net/zerotier/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=9f98b1670785f42294b9858068d42c6b8c2fdee6402e871a36562b47559e74e7/g' feeds/packages/net/zerotier/Makefile
#rm -rf feeds/packages/net/zerotier
#cp -rf $GITHUB_WORKSPACE/general/zerotier feeds/packages/net

# luci-app-n2n_v2
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.0/g' feeds/luci/applications/luci-app-n2n/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/luci/applications/luci-app-n2n/Makefile

# openssh
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.9p1/g' feeds/packages/net/openssh/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/openssh/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=fd497654b7ab1686dac672fb83dfb4ba4096e8b5ffcdaccd262380ae58bec5e7/g' feeds/packages/net/openssh/Makefile
#sed -i '175i\	--with-sandbox=no \\' feeds/packages/net/openssh/Makefile
rm -rf feeds/packages/net/openssh
cp -rf $GITHUB_WORKSPACE/general/openssh feeds/packages/net

# nss
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.85/g' feeds/packages/libs/nss/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=afd9d64510b1154debbd6cab3571e9ff64a3373898e03483e4c85cdada13d297/g' feeds/packages/libs/nss/Makefile

# nspr
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.33/g' feeds/packages/libs/nspr/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=b23ee315be0e50c2fb1aa374d17f2d2d9146a835b1a79c1918ea15d075a693d7/g' feeds/packages/libs/nspr/Makefile

# softethervpn5
#rm -rf feeds/packages/net/softethervpn5
#svn co https://github.com/openwrt/packages/trunk/net/softethervpn5 feeds/packages/net/softethervpn5

# hwdata
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.364/g' feeds/packages/utils/hwdata/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=e79ee7e0251c94273ac8ffa7f68892152d3cfc243a471bc61771d8ab53da3331/g' feeds/packages/utils/hwdata/Makefile

# gawk
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.2.1/g' feeds/packages/utils/gawk/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=673553b91f9e18cc5792ed51075df8d510c9040f550a6f74e09c9add243a7e4f/g' feeds/packages/utils/gawk/Makefile

# ocserv
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.1.6/g' feeds/packages/net/ocserv/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=6a6cbe92212e32280426a51c634adc3d4803579dd049cfdb7e014714cc82c693/g' feeds/packages/net/ocserv/Makefile

# unrar
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=6.2.2/g' feeds/packages/utils/unrar/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=477d6ca7e246caec5412cc83b36c15a4ac837726a892df022919800129107cd5/g' feeds/packages/utils/unrar/Makefile

# at
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.2.2/g' feeds/packages/utils/at/Makefile
#sed -i 's|PKG_SOURCE_VERSION:=.*|PKG_SOURCE_VERSION:=release/3.2.2|g' feeds/packages/utils/at/Makefile
#sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH=93f7f99c4242dbc5218907981e32f74ddb5e09c5b7922617c8d84c16920f488d/g' feeds/packages/utils/at/Makefile
rm -rf feeds/packages/utils/at
cp -rf $GITHUB_WORKSPACE/general/at feeds/packages/utils

# mmc-utils
#rm -rf feeds/packages/utils/mmc-utils
#svn co https://github.com/openwrt/packages/trunk/utils/mmc-utils feeds/packages/utils/mmc-utils
#sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2022-04-17/g' feeds/packages/utils/mmc-utils/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=b7e4d5a6ae9942d26a11de9b05ae7d52c0802802/g' feeds/packages/utils/mmc-utils/Makefile
#sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=7865294ec7619d6696bb06a6e2ad4a3803a0bfbd9754b7d0d617bfb30ab828a1/g' feeds/packages/utils/mmc-utils/Makefile

# nfs-kernel-server
#rm -rf feeds/packages/net/nfs-kernel-server
#svn co https://github.com/openwrt/packages/trunk/net/nfs-kernel-server feeds/packages/net/nfs-kernel-server

# alsa-utils
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2.6/g' feeds/packages/sound/alsa-utils/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=6a1efd8a1f1d9d38e489633eaec1fffa5c315663b316cab804be486887e6145d/g' feeds/packages/sound/alsa-utils/Makefile

# alsa-ucm-conf
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2.6.2/g' feeds/packages/libs/alsa-ucm-conf/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=8be24fb9fe789ee2778ae6f32e18e8043fe7f8bc735871e9d17c68a04566a822/g' feeds/packages/libs/alsa-ucm-conf/Makefile

# alsa-lib
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2.6.1/g' feeds/packages/libs/alsa-lib/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=ad582993d52cdb5fb159a0beab60a6ac57eab0cc1bdf85dc4db6d6197f02333f/g' feeds/packages/libs/alsa-lib/Makefile
#rm -f feeds/packages/libs/alsa-lib/patches/*.patch
#wget -P feeds/packages/libs/alsa-lib/patches https://github.com/openwrt/packages/raw/master/libs/alsa-lib/patches/100-link_fix.patch
#wget -P feeds/packages/libs/alsa-lib/patches https://raw.githubusercontent.com/openwrt/packages/master/libs/alsa-lib/patches/200-usleep.patch

# hdparm
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=9.65/g' feeds/packages/utils/hdparm/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=d14929f910d060932e717e9382425d47c2e7144235a53713d55a94f7de535a4b/g' feeds/packages/utils/hdparm/Makefile

# libcap-ng
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.8.3/g' feeds/packages/libs/libcap-ng/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=bed6f6848e22bb2f83b5f764b2aef0ed393054e803a8e3a8711cb2a39e6b492d/g' feeds/packages/libs/libcap-ng/Makefile

# c-ares
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.18.1/g' feeds/packages/libs/c-ares/Makefile
#sed -i 's|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=https://c-ares.org/download|g' feeds/packages/libs/c-ares/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=1a7d52a8a84a9fbffb1be9133c0f6e17217d91ea5a6fa61f6b4729cda78ebbcf/g' feeds/packages/libs/c-ares/Makefile

# libevdev
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.12.0/g' feeds/packages/libs/libevdev/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2f729e3480695791f9482e8388bd723402b89f0eaf118057bbdea3cecee9b237/g' feeds/packages/libs/libevdev/Makefile

# zstd
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.5.2/g' feeds/packages/utils/zstd/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=3ea06164971edec7caa2045a1932d757c1815858e4c2b68c7ef812647535c23f/g' feeds/packages/utils/zstd/Makefile
#sed -i 's/Dlegacy_level=1/Dlegacy_level=7/g' feeds/packages/utils/zstd/Makefile
#sed -i 's/Dbin_control=false/Dbin_contrib=false/g' feeds/packages/utils/zstd/Makefile
#sed -i '77i\	-Dmulti_thread=enabled \\' feeds/packages/utils/zstd/Makefile
#rm -rf feeds/packages/utils/zstd/patches

# pigz
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.7/g' feeds/packages/utils/pigz/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=b4c9e60344a08d5db37ca7ad00a5b2c76ccb9556354b722d56d55ca7e8b1c707/g' feeds/packages/utils/pigz/Makefile
rm -rf feeds/packages/utils/pigz/patches

# nano
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=6.2/g' feeds/packages/utils/nano/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2bca1804bead6aaf4ad791f756e4749bb55ed860eec105a97fba864bc6a77cb3/g' feeds/packages/utils/nano/Makefile
#cp -rf $GITHUB_WORKSPACE/general/nano feeds/packages/utils

# dnsproxy
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.46.2/g' feeds/packages/net/dnsproxy/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=8ce720f258747b0ff74b9889c93c616efe3b7267d04283a1338d2ff1e24d661e/g' feeds/packages/net/dnsproxy/Makefile

# libnl-tiny
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' package/libs/libnl-tiny/Makefile
#sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2022-05-17/g' package/libs/libnl-tiny/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=b5b2ba09c4f1c8b3c21580aea7223edc2f5e92be/g' package/libs/libnl-tiny/Makefile
#sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=b957d56aa8c2e7b55184111be69eb8dea734f1feba19e670a91f302459a48a78/g' package/libs/libnl-tiny/Makefile
#sed -i 's/ABI_VERSION:=.*/ABI_VERSION:=$(PKG_SOURCE_DATE)/g' package/libs/libnl-tiny/Makefile
#sed -i '19,20d' package/libs/libnl-tiny/Makefile

# mac80211
#rm -rf package/kernel/mac80211
#svn co https://github.com/openwrt/openwrt/branches/openwrt-21.02/package/kernel/mac80211 package/kernel/mac80211
#svn co https://github.com/openwrt/openwrt/trunk/package/kernel/mac80211 package/kernel/mac80211

# mt76
#rm -rf package/kernel/mt76
#svn co https://github.com/openwrt/openwrt/branches/openwrt-21.02/package/kernel/mt76 package/kernel/mt76

# 可道云
#rm -rf package/lean/luci-app-kodexplorer
#cp -r $GITHUB_WORKSPACE/general/luci-app-kodexplorer package/lean/luci-app-kodexplorer

# exfatprogs
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.1.3/g' feeds/packages/utils/exfatprogs/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=e3ee4fb5af4abc9335aed7a749c319917c652ac1af687ba40aabd04a6b71f1ca/g' feeds/packages/utils/exfatprogs/Makefile

# shairport-sync
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.3.9/g' feeds/packages/sound/shairport-sync/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=17990cb2620551caa07a1c3b371889e55803071eaada04e958c356547a7e1795/g' feeds/packages/sound/shairport-sync/Makefile

# less
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=608/g' feeds/packages/utils/less/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=a69abe2e0a126777e021d3b73aa3222e1b261f10e64624d41ec079685a6ac209/g' feeds/packages/utils/less/Makefile

# minizip
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.0.4/g' feeds/packages/libs/minizip/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2ab219f651901a337a7d3c268128711b80330a99ea36bdc528c76b591a624c3c/g' feeds/packages/libs/minizip/Makefile
#sed -i 's/DMZ_COMPAT=OFF/DMZ_COMPAT=ON/g' feeds/packages/libs/minizip/Makefile

# libupnp
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.14.12/g' feeds/packages/libs/libupnp/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=091c80aada1e939c2294245c122be2f5e337cc932af7f7d40504751680b5b5ac/g' feeds/packages/libs/libupnp/Makefile

# file
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.43/g' feeds/packages/libs/file/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=8c8015e91ae0e8d0321d94c78239892ef9dbc70c4ade0008c0e95894abfb1991/g' feeds/packages/libs/file/Makefile

# ariang
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.3.2/g' feeds/packages/net/ariang
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2186dacf57c9d1650e00084c0454f2227e910f3203d89c6190f547b40cac7243/g' feeds/packages/net/ariang

# nginx
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.21.4/g' feeds/packages/net/nginx/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/nginx/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=d1f72f474e71bcaaf465dcc7e6f7b6a4705e4b1ed95c581af31df697551f3bfe/g' feeds/packages/net/nginx/Makefile

# openssl
#sed -i 's/PKG_BUGFIX:=.*/PKG_BUGFIX:=s/g' package/libs/openssl/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' package/libs/openssl/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=c5ac01e760ee6ff0dab61d6b2bbd30146724d063eb322180c6f18a6f74e4b6aa/g' package/libs/openssl/Makefile

# 修改makefile
#find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's|include\ \.\.\/\.\.\/devel/meson/meson.mk|include \$(INCLUDE_DIR)\/meson.mk|g' {}

# smartdns
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2022.39/g' feeds/packages/net/smartdns/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=9176bb9eb550d36bc6c03365a0ee86e3a7c32742/g' feeds/packages/net/smartdns/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=7f420a016d71d8776856a835a7110467c52da1c44462007efc5789c65fb603b3/g' feeds/packages/net/smartdns/Makefile
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2022.39/g' package/luci-app-smartdns/Makefile

# aliyundrive webdav
#svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/aliyundrive-webdav package/aliyundrive-webdav
#svn co https://github.com/messense/aliyundrive-webdav/trunk/openwrt/luci-app-aliyundrive-webdav package/luci-app-aliyundrive-webdav

# libpcap
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.10.1/g' package/libs/libpcap/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=$(AUTORELEASE)/g' package/libs/libpcap/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=ed285f4accaf05344f90975757b3dbfe772ba41d1c401c2648b7fa45b711bdd4/g' package/libs/libpcap/Makefile

# xray-core
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.5.5/g' package/xray-core/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=3f8d04fef82a922c83bab43cac6c86a76386cf195eb510ccf1cc175982693893/g' package/xray-core/Makefile

# xray-plugin
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.5.5/g' package/xray-plugin/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=0edc575765fc3523d475f9d28d14d42facf00060fc8ef60bb50f42e0a6730496/g' package/xray-plugin/Makefile

# icu
#rm -rf feeds/packages/libs/icu
#svn co https://github.com/openwrt/packages/trunk/libs/icu feeds/packages/libs/icu
#sed -i 's/MAJOR_VERSION:=.*/MAJOR_VERSION:=72/g' feeds/packages/libs/icu/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=a2d2d38217092a7ed56635e34467f92f976b370e20182ad325edea6681a71d68/g' feeds/packages/libs/icu/Makefile

# ucode
#cp -rf $GITHUB_WORKSPACE/general/ucode package/utils

# readd cpufreq for aarch64
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' feeds/luci/applications/luci-app-cpufreq/Makefile
sed -i 's/services/system/g'  feeds/luci/applications/luci-app-cpufreq/luasrc/controller/cpufreq.lua

# luci-app-openvpn
sed -i 's/services/vpn/g'  feeds/luci/applications/luci-app-openvpn/luasrc/controller/openvpn.lua
sed -i 's/services/vpn/g'  feeds/luci/applications/luci-app-openvpn/luasrc/model/cbi/openvpn.lua
sed -i 's/services/vpn/g'  feeds/luci/applications/luci-app-openvpn/luasrc/view/openvpn/pageswitch.htm

# NaïveProxy
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=98.0.4758.80-2/g' package/naiveproxy/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=687a1c43f5bff61b2c1857d65031a5234af358053cf00e20911b75b073e55df4/g' package/naiveproxy/Makefile
#rm -rf package/naiveproxy
#cp -rf $GITHUB_WORKSPACE/general/naiveproxy package/naiveproxy

#fix ntfs3 generating empty package
#sed -i 's/KCONFIG:=CONFIG_NLS_DEFAULT="utf8"/#KCONFIG:=CONFIG_NLS_DEFAULT="utf8"/'g package/lean/ntfs3/Makefile
#sed -i 's/mount -t ntfs3 -o nls=utf8 "$@"/mount -t ntfs3 "$@"/g'  package/lean/ntfs3-mount/files/mount.ntfs
sed -i 's/DEPENDS:=.*/DEPENDS:=@(LINUX_5_4||LINUX_5_10) +kmod-nls-utf8/g' package/lean/ntfs3-oot/Makefile

# fix kernel modules missing nfs_ssc.ko
##cp -f $GITHUB_WORKSPACE/general/fs.mk package/kernel/linux/modules
##rm -f target/linux/generic/backport-5.10/350-v5.12-NFSv4_2-SSC-helper-should-use-its-own-config.patch
##rm -f target/linux/generic/backport-5.10/351-v5.13-NFSv4_2-Remove-ifdef-CONFIG_NFSD-from-client-SSC.patch
##cp -f $GITHUB_WORKSPACE/general/01-export-nfs_ssc.patch target/linux/generic/backport-5.15
#cp -f $GITHUB_WORKSPACE/general/003-add-module_supported_device-macro.patch target/linux/generic/backport-5.15
#cp -f $GITHUB_WORKSPACE/general/crypto.mk package/kernel/linux/modules
#cp -f $GITHUB_WORKSPACE/general/netsupport.mk package/kernel/linux/modules
#cp -f $GITHUB_WORKSPACE/general/netdevices.mk package/kernel/linux/modules
#cp -f $GITHUB_WORKSPACE/general/651-rt2x00-driver-compile-with-kernel-5.15.patch package/kernel/mac80211/patches/rt2x00
#rm -f target/linux/generic/pending-5.10/701-net-ethernet-mtk_eth_soc-add-ipv6-flow-offloading-support.patch
#rm -f target/linux/generic/hack-5.10/220-gc_sections.patch
#cp -f $GITHUB_WORKSPACE/general/220-arm-gc_sections.patch target/linux/generic/hack-5.10
#cp -f $GITHUB_WORKSPACE/general/781-dsa-register-every-port-with-of_platform.patch target/linux/generic/hack-5.10
#cp -f $GITHUB_WORKSPACE/general/900-regulator-consumer-Add-missing-stubs-to-regulator-co.patch target/linux/generic/backport-5.10
#rm -f package/kernel/mac80211/patches/brcm/999-backport-to-linux-5.18.patch

#replace coremark.sh with the new one
#rm feeds/packages/utils/coremark/coremark.sh
#cp $GITHUB_WORKSPACE/general/coremark.sh feeds/packages/utils/coremark/

# replace banner
cp -f $GITHUB_WORKSPACE/general/openwrt_banner package/base-files/files/etc/banner

# boost
#rm -rf feeds/packages/libs/boost
#cp -r $GITHUB_WORKSPACE/general/boost feeds/packages/libs

# wxbase
#rm -rf feeds/packages/libs/wxbase
#cp -r $GITHUB_WORKSPACE/general/wxbase feeds/packages/libs

# fix luci-theme-opentomcat dockerman icon missing
rm -f package/luci-theme-opentomcat/files/htdocs/fonts/advancedtomato.woff
cp $GITHUB_WORKSPACE/general/advancedtomato.woff package/luci-theme-opentomcat/files/htdocs/fonts
sed -i 's/e025/e02c/g' package/luci-theme-opentomcat/files/htdocs/css/style.css
sed -i 's/66CC00/00b2ee/g' package/luci-theme-opentomcat/files/htdocs/css/style.css

# zsh
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.9/g' feeds/packages/utils/zsh/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=9b8d1ecedd5b5e81fbf1918e876752a7dd948e05c1a0dba10ab863842d45acd5/g' feeds/packages/utils/zsh/Makefile

# flac
rm -rf feeds/packages/libs/flac
cp -r $GITHUB_WORKSPACE/general/flac feeds/packages/libs

# libogg
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.3.5/g' feeds/packages/libs/libogg/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=c4d91be36fc8e54deae7575241e03f4211eb102afb3fc0775fbbc1b740016705/g' feeds/packages/libs/libogg/Makefile

# coreutils
#rm -rf feeds/packages/utils/coreutils
#cp -r $GITHUB_WORKSPACE/general/coreutils feeds/packages/utils

# frp
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.46.0/g' feeds/packages/net/frp/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=bf617b7c5b3f9a34b4edbac73ca2b7b6781c4f09f33666a7d331d9fe8302679e/g' feeds/packages/net/frp/Makefile

# openconnect
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.20/g' feeds/packages/net/openconnect/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/openconnect/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=c1452384c6f796baee45d4e919ae1bfc281d6c88862e1f646a2cc513fc44e58b/g' feeds/packages/net/openconnect/Makefile

# xtables-addons
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.21/g' feeds/packages/net/xtables-addons/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/xtables-addons/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2e09ac129a14f5e9c23b115ebcdfff4aa84e2aeba1268dbdf39b2d752bd71e19/g' feeds/packages/net/xtables-addons/Makefile

# libssh2
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.10.0/g' feeds/packages/libs/libssh2/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/libs/libssh2/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2d64e90f3ded394b91d3a2e774ca203a4179f69aebee03003e5a6fa621e41d51/g' feeds/packages/libs/libssh2/Makefile

# gnutls
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.7.8/g' feeds/packages/libs/gnutls/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=c58ad39af0670efe6a8aee5e3a8b2331a1200418b64b7c51977fb396d4617114/g' feeds/packages/libs/gnutls/Makefile
#sed -i 's/libzstd/zstd/g' feeds/packages/libs/gnutls/Makefile
#rm -rf feeds/packages/libs/gnutls
#svn co https://github.com/breakings/packages/branches/gnutls/libs/gnutls feeds/packages/libs/gnutls

# smartmontools
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=7.3/g' feeds/packages/utils/smartmontools/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/smartmontools/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=a544f8808d0c58cfb0e7424ca1841cb858a974922b035d505d4e4c248be3a22b/g' feeds/packages/utils/smartmontools/Makefile

# libxml2
#cp -f $GITHUB_WORKSPACE/general/libxml2/Makefile feeds/packages/libs/libxml2

# sqlite3
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3380500/g' feeds/packages/libs/sqlite3/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=5af07de982ba658fd91a03170c945f99c971f6955bc79df3266544373e39869c/g' feeds/packages/libs/sqlite3/Makefile
#sed -i 's|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=https://www.sqlite.org/2022/|g' feeds/packages/libs/sqlite3/Makefile
#sed -i '39d' feeds/packages/libs/sqlite3/Makefile
#cp -rf $GITHUB_WORKSPACE/general/sqlite3 feeds/packages/libs

# zoneinfo
#cp -f $GITHUB_WORKSPACE/general/zoneinfo/Makefile feeds/packages/utils/zoneinfo

# adguardhome
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.107.5/g' feeds/packages/net/adguardhome/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=5282d58b1a8d52f02af4ab7a5d6089aba6f7d20929bd49fd844c930110262dcb/g' feeds/packages/net/adguardhome/Makefile

# iperf3
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.12/g' feeds/packages/net/iperf3/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=72034ecfb6a7d6d67e384e19fb6efff3236ca4f7ed4c518d7db649c447e1ffd6/g' feeds/packages/net/iperf3/Makefile

# verysync
#rm -rf feeds/packages/net/verysync
#svn co https://github.com/immortalwrt/packages/trunk/net/verysync feeds/packages/net/verysync

# haproxy
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.6.6/g' feeds/packages/net/haproxy/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/haproxy/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=d0c80c90c04ae79598b58b9749d53787f00f7b515175e7d8203f2796e6a6594d/g' feeds/packages/net/haproxy/Makefile
#sed -i 's/BASE_TAG:=.*/BASE_TAG=v2.6.6/g' feeds/packages/net/haproxy/get-latest-patches.sh

# perl
rm -rf feeds/packages/lang/perl
cp -rf $GITHUB_WORKSPACE/general/perl feeds/packages/lang

# zlib
#rm -rf package/libs/zlib
#svn co https://github.com/openwrt/openwrt/trunk/package/libs/zlib package/libs/zlib

# tailscale
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.34.1/g' feeds/packages/net/tailscale/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=192e23ab7d0039b031ef4386088f612b93abe038f33699c6366297f572ae07ff/g' feeds/packages/net/tailscale/Makefile

# ruby
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.0.4/g' feeds/packages/lang/ruby/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/ruby/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=8e22fc7304520435522253210ed0aa9a50545f8f13c959fe01a05aea06bef2f0/g' feeds/packages/lang/ruby/Makefile

# libnetfilter-conntrack
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.0.9/g' package/libs/libnetfilter-conntrack/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=67bd9df49fe34e8b82144f6dfb93b320f384a8ea59727e92ff8d18b5f4b579a8/g' package/libs/libnetfilter-conntrack/Makefile
#cp -rf $GITHUB_WORKSPACE/general/libnetfilter-conntrack/patches package/libs/libnetfilter-conntrack

# util-linux
rm -rf package/utils/util-linux
cp -rf $GITHUB_WORKSPACE/general/util-linux package/utils

# lsof
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.95.0/g' feeds/packages/utils/lsof/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=e9faa0fbcc48638c1d1f143e93573ac43b65e76646150f83e24bd8c18786303c/g' feeds/packages/utils/lsof/Makefile

# libnetwork
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=dcdf8f176d1e13ad719e913e796fb698d846de98/g' feeds/packages/utils/libnetwork/Makefile
sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2022-11-11/g' feeds/packages/utils/libnetwork/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=bece10d04ab07cc557b424082a1c2fdf46afe0501541b4a05123b7e90fb42f89/g' feeds/packages/utils/libnetwork/Makefile

# iptables
#rm -rf package/network/utils/iptables
#cp -rf $GITHUB_WORKSPACE/general/iptables package/network/utils

# nghttp2
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.51.0/g' feeds/packages/libs/nghttp2/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=66aa76d97c143f42295405a31413e5e7d157968dad9f957bb4b015b598882e6b/g' feeds/packages/libs/nghttp2/Makefile

# libiconv-full
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.17/g' package/libs/libiconv-full/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=8f74213b56238c85a50a5329f77e06198771e70dd9a739779f4c02f65d971313/g' package/libs/libiconv-full/Makefile

# sagernet-core
sed -i 's|$(LN) v2ray $(1)/usr/bin/xray|#$(LN) v2ray $(1)/usr/bin/xray|g' package/sagernet-core/Makefile
sed -i 's|CONFLICTS:=v2ray-core xray-core|#CONFLICTS:=v2ray-core xray-core|g' package/sagernet-core/Makefile

# bind
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=9.18.8/g' feeds/packages/net/bind/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=0e3c3ab9378db84ba0f37073d67ba125ae4f2ff8daf366c9db287e3f1b2c35f0/g' feeds/packages/net/bind/Makefile

# libwebp
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2.4/g' feeds/packages/libs/libwebp/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=7bf5a8a28cc69bcfa8cb214f2c3095703c6b73ac5fba4d5480c205331d9494df/g' feeds/packages/libs/libwebp/Makefile

# lighttpd
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.4.66/g' feeds/packages/net/lighttpd/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=47ac6e60271aa0196e65472d02d019556dc7c6d09df3b65df2c1ab6866348e3b/g' feeds/packages/net/lighttpd/Makefile

# xz
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.2.9/g' feeds/packages/utils/xz/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/xz/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=287ef163e7e57561e9de590b2a9037457af24f03a46bbd12bf84f3263679e8d2/g' feeds/packages/utils/xz/Makefile

# vim
rm -rf feeds/packages/utils/vim
cp -rf $GITHUB_WORKSPACE/general/vim feeds/packages/utils

# python-packaging
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=21.3/g' feeds/packages/lang/python/python-packaging/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=dd47c42927d89ab911e606518907cc2d3a1f38bbd026385970643f9c5b8ecfeb/g' feeds/packages/lang/python/python-packaging/Makefile

# python-click
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.1.3/g' feeds/packages/lang/python/click/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=7682dc8afb30297001674575ea00d1814d808d6a36af415a82bd481d37ba7b8e/g' feeds/packages/lang/python/click/Makefile

# rsync
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.2.7/g' feeds/packages/net/rsync/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=4e7d9d3f6ed10878c58c5fb724a67dacf4b6aac7340b13e488fb2dc41346f2bb/g' feeds/packages/net/rsync/Makefile

# python-jsonschema
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.17.0/g' feeds/packages/lang/python/python-jsonschema/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=5bfcf2bca16a087ade17e02b282d34af7ccd749ef76241e7f9bd7c0cb8a9424d/g' feeds/packages/lang/python/python-jsonschema/Makefile

# ttyd
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.7.2/g' feeds/packages/utils/ttyd/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/ttyd/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=edc44cd5319c0c9d0858081496cae36fc5c54ee7722e0a547dde39537dfb63de/g' feeds/packages/utils/ttyd/Makefile
rm -f feeds/packages/utils/ttyd/patches/090*.patch

# sed
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.8/g' tools/sed/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=f79b0cfea71b37a8eeec8490db6c5f7ae7719c35587f21edb0617f370eeff633/g' tools/sed/Makefile

# fullcone patch from lede(Non-public)
#mv -v package/network/config/firewall/patches/fullconenat.patch package/network/config/firewall/patches/100-fullconenat.patch
#cp -f $GITHUB_WORKSPACE/general/101-bcm-fullconenat.patch package/network/config/firewall/patches
#cp -f $GITHUB_WORKSPACE/general/900-bcm-fullconenat.patch package/network/utils/iptables/patches
#cp -f $GITHUB_WORKSPACE/general/982-add-bcm-fullconenat-support.patch target/linux/generic/hack-5.15

./scripts/feeds update -a
./scripts/feeds install -a
