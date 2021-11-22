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

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

#git clone --single-branch -b openwrt-21.02 https://github.com/openwrt/openwrt

#移除不用软件包    
rm -rf feeds/packages/libs/libgd-full
rm -rf feeds/luci/collections/luci-lib-docker
#rm -rf package/network
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf package/libs/mbedtls
rm -rf feeds/packages/net/kcptun
rm -rf feeds/packages/net/xray-core
#rm -rf feeds/packages/devel/ninja
#rm -rf package/libs/elfutils
#rm -rf package/libs/libcap
#rm -rf package/libs/libnftnl
#rm -rf package/libs/libpcap
#rm -rf package/libs/nettle
#rm -rf package/libs/pcre
rm -f tools/Makefile
rm -f feeds/packages/net/dnsproxy/Makefile

# Prepare

# Irqbalance
sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config
# Victoria's Secret
#rm -rf ./scripts/download.pl
#rm -rf ./include/download.mk
#wget -P scripts/ https://github.com/immortalwrt/immortalwrt/raw/master/scripts/download.pl
#wget -P include/ https://github.com/immortalwrt/immortalwrt/raw/master/include/download.mk
wget -P feeds/packages/net/dnsproxy https://raw.githubusercontent.com/coolsnowwolf/lede/master/package/lean/dnsproxy/Makefile

# Important Patches
# ARM64: Add CPU model name in proc cpuinfo
wget -P target/linux/generic/pending-5.4 https://github.com/immortalwrt/immortalwrt/raw/master/target/linux/generic/hack-5.4/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch

# Patch jsonc
#patch -p1 < $GITHUB_WORKSPACE/PATCH/new/package/use_json_object_new_int64.patch

# Patch kernel to fix fullcone conflict
#pushd target/linux/generic/hack-5.4
#wget https://github.com/coolsnowwolf/lede/raw/master/target/linux/generic/hack-5.4/952-net-conntrack-events-support-multiple-registrant.patch
#popd
# Patch firewall to enable fullcone
mkdir package/network/config/firewall/patches
wget -P package/network/config/firewall/patches/ https://github.com/immortalwrt/immortalwrt/raw/master/package/network/config/firewall/patches/fullconenat.patch
# Patch LuCI to add fullcone button
patch -p1 < $GITHUB_WORKSPACE/PATCH/new/package/luci-app-firewall_add_fullcone.patch
# FullCone modules
cp -rf $GITHUB_WORKSPACE/PATCH/duplicate/fullconenat ./package/network/fullconenat

#添加额外软件包
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/libs/mbedtls package/libs/mbedtls
svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/mbedtls package/libs/mbedtls
#svn co https://github.com/coolsnowwolf/packages/trunk/devel/ninja feeds/packages/devel/ninja
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ntfs3-mount package/lean/ntfs3-mount
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ntfs3 package/lean/ntfs3
#svn co https://github.com/breakings/OpenWrt/trunk/general/ntfs3 package/lean/ntfs3
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/elfutils package/libs/elfutils
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/libcap package/libs/libcap
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/libnftnl package/libs/libnftnl
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/libpcap package/libs/libpcap
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/nettle package/libs/nettle
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/pcre package/libs/pcre
svn co https://github.com/coolsnowwolf/lede/trunk/tools/upx tools/upx
svn co https://github.com/coolsnowwolf/lede/trunk/tools/ucl tools/ucl
wget -P tools https://raw.githubusercontent.com/breakings/OpenWrt/main/general/tools/Makefile

# Extra Packages
# AutoCore
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/emortal/autocore package/lean/autocore
svn co https://github.com/breakings/OpenWrt/trunk/general/autocore package/lean/autocore
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/autocore package/lean/autocore
rm -rf ./feeds/packages/utils/coremark
svn co https://github.com/immortalwrt/packages/trunk/utils/coremark feeds/packages/utils/coremark
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/lean/qt5 package/lean/qt5
#svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/libs/libdouble-conversion package/libs/libdouble-conversion
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/libdouble-conversion package/libs/libdouble-conversion
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/lean/qt5 package/lean/qt5
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qt5 package/lean/qt5
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qtbase package/lean/qtbase
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qttools package/lean/qttools

#git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
git clone https://github.com/project-lede/luci-app-godproxy package/luci-app-godproxy
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/lean/luci-app-haproxy-tcp package/lean/luci-app-haproxy-tcp
#svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-haproxy-tcp package/lean/luci-app-haproxy-tcp
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
#svn co https://github.com/1715173329/packages-official/branches/xray-2102/net/xray-core feeds/packages/net/xray-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-plugin package/xray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-core package/v2ray-core
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-plugin package/v2ray-plugin
svn co https://github.com/fw876/helloworld/trunk/v2ray-plugin package/v2ray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks package/ssocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/dns2socks package/dns2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ipt2socks package/ipt2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/microsocks package/microsocks 
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/pdnsd-alt package/pdnsd-alt
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/shadowsocksr-libev package/shadowsocksr-libev
svn co https://github.com/fw876/helloworld/trunk/shadowsocksr-libev package/shadowsocksr-libev
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/simple-obfs package/simple-obfs
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/kcptun package/kcptun
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan package/trojan
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/naiveproxy package/naiveproxy
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/hysteria package/hysteria
#svn co https://github.com/fw876/helloworld/trunk/naiveproxy package/naiveproxy
mkdir package/xray-core/patches
wget -P package/xray-core/patches https://raw.githubusercontent.com/openwrt/packages/master/net/xray-core/patches/100-go-1.17-deps.patch
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/dnsforwarder package/lean/dnsforwarder

#菜单定制
git clone https://github.com/immortalwrt/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/network package/network
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/lean/qBittorrent-Enhanced-Edition package/lean/qBittorrent-Enhanced-Edition
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qBittorrent package/lean/qBittorrent
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/rblibtorrent package/lean/rblibtorrent
svn co https://github.com/breakings/OpenWrt/trunk/general/luci-app-qbittorrent package/lean/luci-app-qbittorrent
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-qbittorrent package/lean/luci-app-qbittorrent
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/lean/luci-app-qbittorrent package/lean/luci-app-qbittorrent
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-cpufreq package/lean/luci-app-cpufreq
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cpufreq package/lean/luci-app-cpufreq
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-airplay2 package/lean/luci-app-airplay2
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/lean/luci-app-flowoffload package/lean/luci-app-flowoffload
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/lean/luci-app-flowoffload package/lean/luci-app-flowoffload
svn co https://github.com/breakings/OpenWrt/trunk/general/luci-app-flowoffload package/lean/luci-app-flowoffload
svn co https://github.com/breakings/OpenWrt/trunk/general/luci-app-turboacc package/lean/luci-app-turboacc
#svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-turboacc package/lean/turboacc
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-cifs-mount package/lean/luci-app-cifs-mount
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-nfs package/lean/luci-app-nfs
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/lean/luci-app-netdata package/lean/luci-app-netdata
svn co https://github.com/breakings/OpenWrt/trunk/general/luci-app-netdata package/lean/luci-app-netdata
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-usb-printer package/lean/luci-app-usb-printer
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-filetransfer package/lean/luci-app-filetransfer
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/libs/luci-lib-fs package/lean/luci-lib-fs
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-zerotier package/lean/luci-app-zerotier
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/coremark package/lean/coremark
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/network/fullconenat package/network/fullconenat 
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-docker package/lean/luci-app-docker
#svn co https://github.com/coolsnowwolf/packages/trunk/utils/docker-ce package/utils/docker-ce
#svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-lib-docker package/luci-lib-docker
svn co https://github.com/lisaac/luci-lib-docker/trunk/collections/luci-lib-docker package/luci-lib-docker

svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-openvpn-server package/lean/luci-app-openvpn-server
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-autoreboot package/lean/luci-app-autoreboot
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-vlmcsd package/lean/luci-app-vlmcsd
svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/vlmcsd package/lean/vlmcsd
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-ramfree package/lean/luci-app-ramfree
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-guest-wifi package/lean/luci-app-guest-wifi
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/diy/parted package/parted
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/lean/default-settings package/lean/default-settings
svn co https://github.com/breakings/OpenWrt/trunk/general/default-settings package/lean/default-settings
#rm -f package/lean/default-settings/files/zzz-default-settings
#cp -f $GITHUB_WORKSPACE/general/zzz-default-settings package/lean/default-settings/files/

#svn co https://github.com/fw876/helloworld/trunk/xray-core package/xray-core
#svn co https://github.com/fw876/helloworld/trunk/xray-plugin package/xray-plugin
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-gost package/luci-app-gost
#svn co https://github.com/kenzok8/openwrt-packages/trunk/gost package/gost
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-gost package/luci-app-gost
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gost package/gost
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/luci-app-eqos
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/lean/luci-app-ssr-plus
#pushd package/lean
#wget -qO - https://patch-diff.githubusercontent.com/raw/fw876/helloworld/pull/442.patch | patch -p1
#popd
#svn co https://github.com/fw876/helloworld/trunk/naiveproxy package/naiveproxy
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2 package/lean/redsocks2
svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/n2n_v2 package/lean/n2n_v2
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-n2n_v2 package/lean/luci-app-n2n_v2
#svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-advancedsetting package/lean/luci-app-advancedsetting

#添加smartdns
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/smartdns package/smartdns
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns package/luci-app-smartdns
#svn co https://github.com/openwrt/packages/trunk/net/smartdns package/smartdns
#svn co https://github.com/openwrt/luci/trunk/applications/luci-app-smartdns package/luci-app-smartdns

# smartdns
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2021.34/' feeds/packages/net/smartdns/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=756029f5e9879075c042030bd3aa3db06d700270/' feeds/packages/net/smartdns/Makefile
#sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=c2979d956127946861977781beb3323ad9a614ae55014bc99ad39beb7a27d481/' feeds/packages/net/smartdns/Makefile
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2021.35/' feeds/luci/applications/luci-app-smartdns/Makefile

# mbedtls
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.6.11/' package/libs/mbedtls/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=$(AUTORELEASE)/' package/libs/mbedtls/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=c18e7e9abf95e69e425260493720470021384a1728417042060a35d0b7b18b41/' package/libs/mbedtls/Makefile

# 添加ddnsto
#svn co https://github.com/linkease/ddnsto-openwrt/trunk/ddnsto package/ddnsto
#svn co https://github.com/linkease/ddnsto-openwrt/trunk/luci-app-ddnsto package/luci-app-ddnsto
# 添加udp2raw
#git clone https://github.com/sensec/openwrt-udp2raw package/openwrt-udp2raw
#git clone https://github.com/sensec/luci-app-udp2raw package/luci-app-udp2raw
#sed -i "s/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=f2f90a9a150be94d50af555b53657a2a4309f287/" package/openwrt-udp2raw/Makefile
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=20200920\.0/" package/openwrt-udp2raw/Makefile

# rblibtorrent
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=2.0.3/" package/lean/rblibtorrent/Makefile
#sed -i "s/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=af7a96c1df47fcc8fbe0d791c223b0ab8a7d2125/" package/lean/rblibtorrent/Makefile

# qBittorrent
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=4.3.8/" package/lean/qBittorrent/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=cc11f797dd146e6aac8feee8feffb1e429d61551f48b577d32b2239ec5e72ccb/" package/lean/qBittorrent/Makefile

# Qt5 -qtbase
#sed -i "s/PKG_BUGFIX:=.*/PKG_BUGFIX:=2/" package/lean/qtbase/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=909fad2591ee367993a75d7e2ea50ad4db332f05e1c38dd7a5a274e156a4e0f8/" package/lean/qtbase/Makefile
#mkdir package/lean/qtbase/patches
#wget -P package/lean/qtbase/patches/ https://raw.githubusercontent.com/breakings/OpenWrt/main/general/001-gcc11.patch

# Qt5 -qttools
#sed -i "s/PKG_BUGFIX:=.*/PKG_BUGFIX:=2/" package/lean/qttools/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=c189d0ce1ff7c739db9a3ace52ac3e24cb8fd6dbf234e49f075249b38f43c1cc/" package/lean/qttools/Makefile

# samba4
sed -i 's/PKG_VERSION:.*/PKG_VERSION:=4.14.10/' feeds/packages/net/samba4/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=107ee862f58062682cec362ec68a24251292805f89aa4c97e7ab80237f91c7af/' feeds/packages/net/samba4/Makefile

# ffmpeg
sed -i 's/PKG_VERSION:.*/PKG_VERSION:=4.4/' feeds/packages/multimedia/ffmpeg/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=06b10a183ce5371f915c6bb15b7b1fffbe046e8275099c96affc29e17645d909/' feeds/packages/multimedia/ffmpeg/Makefile

# btrfs-progs
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.13.1/' feeds/packages/utils/btrfs-progs/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=3d7e5a01e68fbaf485c5f1da15c6b8a7d1455fb57b6e75a706f8e2bb37f4f399/' feeds/packages/utils/btrfs-progs/Makefile

# docker
sed -i 's/PKG_VERSION:=20.10.10/PKG_VERSION:=20.10.11/' feeds/packages/utils/docker/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=55d55fdead906cbea8608ef39d5a62d54d1118e604a5ae7e2d58b4fb54a599a7/' feeds/packages/utils/docker/Makefile
sed -i 's/PKG_GIT_SHORT_COMMIT:=b485636/PKG_GIT_SHORT_COMMIT:=dea9396/' feeds/packages/utils/docker/Makefile

# dockerd
sed -i 's/PKG_VERSION:=20.10.10/PKG_VERSION:=20.10.11/' feeds/packages/utils/dockerd/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=6fa7835bf7c17c293621967bd5096642fa1e3e1b597fbc7d7bd35f455d886495/' feeds/packages/utils/dockerd/Makefile
sed -i 's/PKG_GIT_SHORT_COMMIT:=e2f740d/PKG_GIT_SHORT_COMMIT:=847da18/' feeds/packages/utils/dockerd/Makefile

# docker-compose
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.1.1/' feeds/packages/utils/docker-compose/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=5c9246c34cafeb51b3289c016cb2cbdd08b3eda87b0f8d4cc02fd7630cfdbd7b/' feeds/packages/utils/docker-compose/Makefile

# containerd
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.4.12/' feeds/packages/utils/containerd/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=85a531725f15e2d136131119d42af4507a5389e0947015152075c4c93816fb5c/' feeds/packages/utils/containerd/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=7b11cfaabd73bb80907dd23182b9347b4245eb5d/' feeds/packages/utils/containerd/Makefile

# runc
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.0.2/' feeds/packages/utils/runc/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=6c3cca4bbeb5d9b2f5e3c0c401c9d27bc8a5d2a0db8a2f6a06efd03ad3c38a33/' feeds/packages/utils/runc/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=52b36a2dd837e8462de8e01458bf02cf9eea47dd/' feeds/packages/utils/runc/Makefile

# use upx for frp
#sed -i '58 a\    $(STAGING_DIR_HOST)/bin/upx --lzma --best $$(1)/usr/bin/$(1) || true' feeds/packages/net/frp/Makefile
#rm -r feeds/packages/net/frp/Makefile
#wget -P feeds/packages/net/frp https://raw.githubusercontent.com/breakings/OpenWrt/main/general/frp/Makefile

# fix speedtest-cli
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=2.1.3/" feeds/packages/lang/python/python3-speedtest-cli/Makefile
sed -i "s/PKG_RELEASE:=.*/PKG_RELEASE:=1/" feeds/packages/lang/python/python3-speedtest-cli/Makefile
sed -i "s/PKG_HASH:=.*/PKG_HASH:=5e2773233cedb5fa3d8120eb7f97bcc4974b5221b254d33ff16e2f1d413d90f0/" feeds/packages/lang/python/python3-speedtest-cli/Makefile

# themes
#svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/luci-theme-rosy
#git clone https://github.com/rosywrt/luci-theme-purple.git package/luci-theme-purple
#git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
#git clone https://github.com/kevin-morgan/luci-theme-argon-dark.git package/luci-theme-argon-dark
#svn co https://github.com/openwrt/luci/trunk/themes/luci-theme-openwrt-2020 package/luci-theme-openwrt-2020
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
#git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# readd cpufreq for aarch64
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile
sed -i 's/services/system/g'  package/lean/luci-app-cpufreq/luasrc/controller/cpufreq.lua

# Add cputemp.sh
cp -rf $GITHUB_WORKSPACE/PATCH/new/script/cputemp.sh ./package/base-files/files/bin/cputemp.sh

# Conntrack_Max
sed -i 's/16384/65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# Mbedtls AES HW-Crypto
#cp -f $GITHUB_WORKSPACE/PATCH/new/package/100-Implements-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch ./package/libs/mbedtls/patches/100-Implements-AES-and-GCM-with-ARMv8-Crypto-Extensions.patch

# Addition-Trans-zh-master
# cp -rf $GITHUB_WORKSPACE/PATCH/duplicate/addition-trans-zh-r2s ./package/lean/lean-translate

# GCC CFlags for N1
#sed -i 's/Os/O3/g' include/target.mk
sed -i 's,-mcpu=generic,-march=armv8-a+crypto+crc -mabi=lp64,g' include/target.mk

# parted
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:3.4/' package/parted/Makefile
#sed -i 's/PKG_MD5SUM:=.*/PKG_MD5SUM:357d19387c6e7bc4a8a90fe2d015fe80/' package/parted/Makefile

# Transmission
sed -i 's/发送/Transmission/g' feeds/luci/applications/luci-app-transmission/po/zh_Hans/transmission.po
#sed -i '/"file": {/a\\t\t\t\t"/etc/passwd": [ "read" ],\n\t\t\t\t"/etc/group": [ "read" ],' /usr/share/rpcd/acl.d/luci-app-transmission.json

# p910nd
sed -i 's/p910nd - 打印服务器/打印服务器/g' feeds/luci/applications/luci-app-p910nd/po/zh_Hans/p910nd.po

# fix NaïveProxy typo error
#sed -i 's/Na茂veProxy/NaïveProxy/g' package/naiveproxy/Makefile

# CIFSD
#sed -i 's/网络共享/网络共享(CIFSD)/g' feeds/luci/applications/luci-app-ksmbd/po/zh_Hans/ksmbd.po

# Xray-core
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:1.4.2/" feeds/packages/net/xray-core/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:565255d8c67b254f403d498b9152fa7bc097d649c50cb318d278c2be644e92cc/" feeds/packages/net/xray-core/Makefile

<<'COMMENT'
#Vermagic
latest_version="$(curl -s https://github.com/openwrt/openwrt/releases |grep -Eo "v[0-9\.]+\-*r*c*[0-9]*.tar.gz" |sed -n '/21/p' |sed -n 1p |sed 's/v//g' |sed 's/.tar.gz//g')"
wget https://downloads.openwrt.org/releases/${latest_version}/targets/armvirt/64/packages/Packages.gz
zgrep -m 1 "Depends: kernel (=.*)$" Packages.gz | sed -e 's/.*-\(.*\))/\1/' > .vermagic
sed -i -e 's/^\(.\).*vermagic$/\1cp $(TOPDIR)\/.vermagic $(LINUX_DIR)\/.vermagic/' include/kernel-defaults.mk
COMMENT

# Vermagic 2102 SNAPSHOT ONLY
wget https://downloads.openwrt.org/releases/21.02-SNAPSHOT/targets/armvirt/64/packages/Packages.gz
zgrep -m 1 "Depends: kernel (=.*)$" Packages.gz | sed -e 's/.*-\(.*\))/\1/' > .vermagic
sed -i -e 's/^\(.\).*vermagic$/\1cp $(TOPDIR)\/.vermagic $(LINUX_DIR)\/.vermagic/' include/kernel-defaults.mk

# Crypto and Devfreq

#默认设置
#sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/aria2.lua
#sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/usb_printer.lua
#sed -i 's/services/nas/g' /root/usr/share/luci/menu.d/luci-app-p910nd.json
#sed -i 's/services/nas/g' /root/usr/share/luci/menu.d/luci-app-minidlna.json
#sed -i 's/services/nas/g' /root/usr/share/luci/menu.d/luci-app-hd-idle.json
#sed -i 's/option lang auto/option lang zh_cn/g' feeds/luci/modules/luci-base/root/etc/config/luci

#replace coremark.sh with the new one
#rm feeds/packages/utils/coremark/coremark.sh
#svn co https://github.com/openwrt/packages/trunk/utils/coremark feeds/package/utils/coremark
#cp $GITHUB_WORKSPACE/general/coremark.sh feeds/packages/utils/coremark/
#cp $GITHUB_WORKSPACE/general/coremark feeds/packages/utils/coremark/
#rm package/lean/default-settings/files/openwrt_banner
#cp $GITHUB_WORKSPACE/general/openwrt_banner package/lean/default-settings/files/
#rm package/lean/default-settings/files/zzz-default-settings
#cp $GITHUB_WORKSPACE/general/zzz-default-settings package/lean/default-settings/files/
#rm package/lean/qt5/Makefile
#cp -f $GITHUB_WORKSPACE/general/Makefile package/lean/qt5/

# 内核切换
#sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=5.10/g' ./target/linux/armvirt/Makefile

#同步官方kernel-version.mk
#rm include/kernel-version.mk
#svn co --depth=empty  https://github.com/openwrt/openwrt/trunk/include kerner-version
#cd kerner-version
#svn up kernel-version.mk

# Fix n2n_v2 luci 
#sed -e 's/page..acl_depends/page.acl_depends/' -i package/lean/luci-app-n2n_v2/luasrc/controller/n2n_v2.lua

# 修改makefile
find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's/include\ \.\.\/\.\.\/luci\.mk/include \$(TOPDIR)\/feeds\/luci\/luci\.mk/g' {}

# autocore
#sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_mvebu||TARGET_sunxi||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile

# fix nginx-ssl-util error (do not use fallthrough attribute)
#rm feeds/packages/net/nginx-util/src/nginx-ssl-util.hpp
#wget -P feeds/packages/net/nginx-util/src https://raw.githubusercontent.com/peter-stadler/packages/c102ecb4f59a3f76184cd3cc73a4e9653abdca84/net/nginx-util/src/nginx-ssl-util.hpp

./scripts/feeds update -a
./scripts/feeds install -a
