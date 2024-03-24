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
#rm -rf feeds/packages/libs/libgd-full
#rm -rf feeds/luci/collections/luci-lib-docker
#rm -rf package/network
#rm -rf feeds/luci/themes/luci-theme-argon
#rm -rf package/libs/mbedtls
#rm -rf feeds/packages/net/kcptun
#rm -rf feeds/packages/net/xray-core
#rm -rf feeds/packages/devel/ninja
#rm -rf package/libs/elfutils
#rm -rf package/libs/libcap
#rm -rf package/libs/libnftnl
#rm -rf package/libs/libpcap
#rm -rf package/libs/nettle
#rm -rf package/libs/pcre
#rm -f tools/Makefile
#rm -f feeds/packages/net/dnsproxy/Makefile
#rm -rf feeds/packages/net/trojan-go

# Prepare

# Irqbalance
sed -i "s/enabled '0'/enabled '1'/g" feeds/packages/utils/irqbalance/files/irqbalance.config
# Victoria's Secret
#rm -rf ./scripts/download.pl
#rm -rf ./include/download.mk
#wget -P scripts/ https://github.com/immortalwrt/immortalwrt/raw/master/scripts/download.pl
#wget -P include/ https://github.com/immortalwrt/immortalwrt/raw/master/include/download.mk
#wget -P feeds/packages/net/dnsproxy https://raw.githubusercontent.com/coolsnowwolf/packages/master/net/dnsproxy/Makefile

# Important Patches
# ARM64: Add CPU model name in proc cpuinfo
#wget -P target/linux/generic/pending-5.15 https://github.com/immortalwrt/immortalwrt/raw/master/target/linux/generic/hack-5.15/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch
#wget -P target/linux/generic/pending-5.10 https://github.com/immortalwrt/immortalwrt/raw/master/target/linux/generic/hack-5.10/312-arm64-cpuinfo-Add-model-name-in-proc-cpuinfo-for-64bit-ta.patch

# Patch jsonc
#patch -p1 < $GITHUB_WORKSPACE/PATCH/new/package/use_json_object_new_int64.patch

# Patch kernel to fix fullcone conflict
pushd target/linux/generic/hack-5.15
wget https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/hack-5.15/952-add-net-conntrack-events-support-multiple-registrant.patch
popd
wget -P target/linux/generic/hack-5.10 https://raw.githubusercontent.com/coolsnowwolf/lede/master/target/linux/generic/hack-5.15/952-net-conntrack-events-support-multiple-registrant.patch
# Patch firewall to enable fullcone
#mkdir package/network/config/firewall/patches
#wget -P package/network/config/firewall/patches/ https://github.com/immortalwrt/immortalwrt/raw/ster/package/network/config/firewall/patches/fullconenat.patch
# Patch LuCI to add fullcone button
#patch -p1 < $GITHUB_WORKSPACE/PATCH/new/package/luci-app-firewall_add_fullcone.patch
# FullCone modules
#cp -rf $GITHUB_WORKSPACE/PATCH/duplicate/fullconenat ./package/network/fullconenat

#添加额外软件包
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/libs/mbedtls package/libs/mbedtls
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/mbedtls package/libs/mbedtls
#svn co https://github.com/coolsnowwolf/packages/trunk/devel/ninja feeds/packages/devel/ninja
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ntfs3-mount package/lean/ntfs3-mount
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ntfs3-oot package/lean/ntfs3-oot
#svn co https://github.com/breakings/OpenWrt/trunk/general/ntfs3 package/lean/ntfs3
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/elfutils package/libs/elfutils
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/libcap package/libs/libcap
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/libnftnl package/libs/libnftnl
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/libpcap package/libs/libpcap
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/nettle package/libs/nettle
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/pcre package/libs/pcre
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/upx tools/upx
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/ucl tools/ucl
#wget -P tools https://raw.githubusercontent.com/breakings/OpenWrt/main/general/tools/Makefile

# Extra Packages
# AutoCore
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/emortal/autocore package/lean/autocore
cp -rf $GITHUB_WORKSPACE/general/autocore package/autocore
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/autocore package/lean/autocore
#rm -rf ./feeds/packages/utils/coremark
#svn co https://github.com/immortalwrt/packages/trunk/utils/coremark feeds/packages/utils/coremark
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/lean/qt5 package/lean/qt5
#svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/libs/libdouble-conversion package/libs/libdouble-conversion
#svn co https://github.com/coolsnowwolf/lede/trunk/package/libs/libdouble-conversion package/libs/libdouble-conversion
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/lean/qt5 package/lean/qt5
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/qt5 package/lean/qt5
cp -rf $GITHUB_WORKSPACE/general/qtbase package/qtbase
cp -rf $GITHUB_WORKSPACE/general/qttools package/qttools
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/shortcut-fe package/lean/shortcut-fe
#svn co https://github.com/coolsnowwolf/packages/trunk/net/qBittorrent-static package/qBittorrent-static

#git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
git clone --depth=1 https://github.com/vernesong/OpenClash.git package/OpenClash
#git clone https://github.com/project-lede/luci-app-godproxy package/luci-app-godproxy
svn co https://github.com/iwrt/luci-app-ikoolproxy/trunk package/luci-app-ikoolproxy
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/lean/luci-app-haproxy-tcp package/lean/luci-app-haproxy-tcp
#svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-haproxy-tcp package/lean/luci-app-haproxy-tcp
# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/OpenClash/luci-app-openclash/tools/po2lmo
make && sudo make install
popd

#菜单定制
#git clone https://github.com/immortalwrt/luci-app-unblockneteasemusic package/luci-app-unblockneteasemusic
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/network package/network
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/lean/qBittorrent-Enhanced-Edition package/lean/qBittorrent-Enhanced-Edition
#svn co https://github.com/coolsnowwolf/packages/trunk/net/qBittorrent package/lean/qBittorrent
#svn co https://github.com/coolsnowwolf/packages/trunk/libs/rblibtorrent package/lean/rblibtorrent
cp -rf $GITHUB_WORKSPACE/general/luci-app-qbittorrent package/luci-app-qbittorrent
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
#svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/libs/luci-lib-fs package/lean/luci-lib-fs
#svn co https://github.com/immortalwrt/luci/trunk/applications/luci-app-zerotier package/luci-app-zerotier
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/coremark package/lean/coremark
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/network/fullconenat package/network/fullconenat 
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-docker package/lean/luci-app-docker
#svn co https://github.com/coolsnowwolf/packages/trunk/utils/docker-ce package/utils/docker-ce
#svn co https://github.com/Lienol/openwrt/trunk/package/diy/luci-lib-docker package/luci-lib-docker
#svn co https://github.com/lisaac/luci-lib-docker/trunk/collections/luci-lib-docker package/luci-lib-docker

svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-openvpn-server package/lean/luci-app-openvpn-server
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-autoreboot package/lean/luci-app-autoreboot
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-vlmcsd package/lean/luci-app-vlmcsd
svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/vlmcsd package/lean/vlmcsd
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-ramfree package/lean/luci-app-ramfree
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-guest-wifi package/lean/luci-app-guest-wifi
#svn co https://github.com/Lienol/openwrt/branches/21.02/package/diy/parted package/parted
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-21.02/package/lean/default-settings package/lean/default-settings
#svn co https://github.com/breakings/OpenWrt/trunk/general/default-settings package/lean/default-settings
#rm -f package/lean/default-settings/files/zzz-default-settings
#cp -f $GITHUB_WORKSPACE/general/zzz-default-settings package/lean/default-settings/files/

#svn co https://github.com/fw876/helloworld/trunk/xray-core package/xray-core
#svn co https://github.com/fw876/helloworld/trunk/xray-plugin package/xray-plugin
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-gost package/luci-app-gost
#svn co https://github.com/kenzok8/openwrt-packages/trunk/gost package/gost
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-gost package/luci-app-gost
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gost package/gost
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/luci-app-eqos
#git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/lean/luci-app-ssr-plus
svn co https://github.com/fw876/helloworld/trunk/lua-neturl package/lua-neturl
#pushd package/lean
#wget -qO - https://patch-diff.githubusercontent.com/raw/fw876/helloworld/pull/442.patch | patch -p1
#popd
#svn co https://github.com/fw876/helloworld/trunk/naiveproxy package/naiveproxy
svn co https://github.com/coolsnowwolf/packages/trunk/net/redsocks2 package/lean/redsocks2
svn co https://github.com/immortalwrt/packages/branches/openwrt-21.02/net/n2n_v2 package/lean/n2n_v2
svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-n2n_v2 package/lean/luci-app-n2n_v2
#svn co https://github.com/immortalwrt/luci/branches/openwrt-21.02/applications/luci-app-advancedsetting package/lean/luci-app-advancedsetting

#添加smartdns
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/smartdns package/smartdns
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns package/luci-app-smartdns
#svn co https://github.com/openwrt/packages/trunk/net/smartdns package/smartdns
#svn co https://github.com/openwrt/luci/trunk/applications/luci-app-smartdns package/luci-app-smartdns

# smartdns
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2022.36/g' feeds/packages/net/smartdns/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=24661c2419a81e660b11a0e3d35a3bc269cd4bfa/g' feeds/packages/net/smartdns/Makefile
#sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=0835be621f0359bec24fe2ec112f455aef8d403167be33a8366630db9fdbdbaa/g' feeds/packages/net/smartdns/Makefile
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2022.38/g' feeds/luci/applications/luci-app-smartdns/Makefile

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

# libtorrent-rasterbar
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=2.0.3/" package/lean/rblibtorrent/Makefile
#sed -i "s/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=af7a96c1df47fcc8fbe0d791c223b0ab8a7d2125/" package/lean/rblibtorrent/Makefile
rm -rf feeds/packages/libs/libtorrent-rasterbar/patches
cp -f $GITHUB_WORKSPACE/general/libtorrent-rasterbar/Makefile feeds/packages/libs/libtorrent-rasterbar

# qBittorrent
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=4.4.1/" package/lean/qBittorrent/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=144a609514a7b516e65c4a4e32e49529b5e3949a713daf86332cd95867c991ba/" package/lean/qBittorrent/Makefile
mkdir -pv package/qBittorrent
cp -rf $GITHUB_WORKSPACE/general/qBittorrent/Makefile.qt6 package/qBittorrent/Makefile

# Qt5 -qtbase
#sed -i "s/PKG_BUGFIX:=.*/PKG_BUGFIX:=6/" package/lean/qtbase/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=396bc6b0d773ac6a7c691a4c3d901999f571e3e7033d7fd6f65e4ef2b6eb7340/" package/lean/qtbase/Makefile
#rm -rf package/lean/qtbase/patches

# Qt5 -qttools
#sed -i "s/PKG_BUGFIX:=.*/PKG_BUGFIX:=6/" package/lean/qttools/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=2c1486ab7e6dad76fb34642cd4f91d533e5dfeec0ee527129c2c2ed4ab283c3b/" package/lean/qttools/Makefile

# samba4
#sed -i 's/PKG_VERSION:.*/PKG_VERSION:=4.14.10/' feeds/packages/net/samba4/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=107ee862f58062682cec362ec68a24251292805f89aa4c97e7ab80237f91c7af/' feeds/packages/net/samba4/Makefile

# ffmpeg
#sed -i 's/PKG_VERSION:.*/PKG_VERSION:=4.4.1/' feeds/packages/multimedia/ffmpeg/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=eadbad9e9ab30b25f5520fbfde99fae4a92a1ae3c0257a8d68569a4651e30e02/' feeds/packages/multimedia/ffmpeg/Makefile

# btrfs-progs
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=6.8/' feeds/packages/utils/btrfs-progs/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=9c21645feac182611e28b47769d5f613cb9e2ecab58ece60b10e6c55a9ead575/' feeds/packages/utils/btrfs-progs/Makefile
#rm -rf feeds/packages/utils/btrfs-progs/patches

# bsdtar
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.6.1/g' feeds/packages/libs/libarchive/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=5a411aceb978f43e626f0c2d1812ddd8807b645ed892453acabd532376c148e6/g' feeds/packages/libs/libarchive/Makefile

# docker
#sed -i 's/PKG_VERSION:=20.10.14/PKG_VERSION:=20.10.16/g' feeds/packages/utils/docker/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/docker/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=af34131b1f08a068906336092a4dc3dfd8921c8039528cb698b32491951c33e2/g' feeds/packages/utils/docker/Makefile
#sed -i 's/PKG_GIT_SHORT_COMMIT:=a224086/PKG_GIT_SHORT_COMMIT:=aa7e414/g' feeds/packages/utils/docker/Makefile

# dockerd
#sed -i 's/PKG_VERSION:=20.10.14/PKG_VERSION:=20.10.16/g' feeds/packages/utils/dockerd/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/dockerd/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2cd69e2cc67053300aa8d78988c92fd63ea0d0d84fe2071597191a149d5548f8/g' feeds/packages/utils/dockerd/Makefile
#sed -i 's/PKG_GIT_SHORT_COMMIT:=87a90dc/PKG_GIT_SHORT_COMMIT:=f756502/g' feeds/packages/utils/dockerd/Makefile
#sed -i 's/^\s*$[(]call\sEnsureVendoredVersion/#&/' feeds/packages/utils/dockerd/Makefile

# docker-compose
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.5.1/' feeds/packages/utils/docker-compose/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=f3eeaac99d2467fe482f499787ae38f66738bc0641dbf34a6045f34aaab893b7/' feeds/packages/utils/docker-compose/Makefile

# containerd
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.5.11/g' feeds/packages/utils/containerd/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=skip/g' feeds/packages/utils/containerd/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=3df54a852345ae127d1fa3092b95168e4a88e2f8/g' feeds/packages/utils/containerd/Makefile
#cp -f $GITHUB_WORKSPACE/general/containerd/Makefile feeds/packages/utils/containerd

# runc
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.1.2/g' feeds/packages/utils/runc/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=0ccce82b1d9c058d8fd7443d261c96fd7a803f2775bcb1fec2bdb725bc7640f6/g' feeds/packages/utils/runc/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=a916309fff0f838eb94e928713dbc3c0d0ac7aa4/g' feeds/packages/utils/runc/Makefile

# openwrt-fullconenat
#svn co https://github.com/coolsnowwolf/lede/trunk/package/network/services/fullconenat package/fullconenat

# openssh
#sed -i '175i\	--with-sandbox=rlimit \\' feeds/packages/net/openssh/Makefile
#rm -rf feeds/packages/net/openssh
#cp -rf $GITHUB_WORKSPACE/general/openssh feeds/packages/net

# hdparm
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=9.65/g' feeds/packages/utils/hdparm/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=d14929f910d060932e717e9382425d47c2e7144235a53713d55a94f7de535a4b/g' feeds/packages/utils/hdparm/Makefile

# pcre2
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=10.40/g' feeds/packages/libs/pcre2/Makefile
#sed -i 's|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=https://github.com/PhilipHazel/pcre2/releases/download/$(PKG_NAME)-$(PKG_VERSION)|g' feeds/packages/libs/pcre2/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=14e4b83c4783933dc17e964318e6324f7cae1bc75d8f3c79bc6969f00c159d68/g' feeds/packages/libs/pcre2/Makefile

# socat
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.7.4.4/g' feeds/packages/net/socat/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=fbd42bd2f0e54a3af6d01bdf15385384ab82dbc0e4f1a5e153b3e0be1b6380ac/g' feeds/packages/net/socat/Makefile
#sed -i '75i\	  sc_cv_getprotobynumber_r=2 \\' feeds/packages/net/socat/Makefile

# libseccomp
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.5.4/g' feeds/packages/libs/libseccomp/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=d82902400405cf0068574ef3dc1fe5f5926207543ba1ae6f8e7a1576351dcbdb/g' feeds/packages/libs/libseccomp/Makefile

# node 
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=v16.15.0/g" feeds/packages/lang/node/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=a0f812efc43f78321eca08957960a48f5e6bf97004d5058c8dd3b03c646ea4f7/g" feeds/packages/lang/node/Makefile
#rm -rf feeds/packages/lang/node
#cp -rf $GITHUB_WORKSPACE/general/node feeds/packages/lang

# nss
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.76/g' feeds/packages/libs/nss/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=1b8e0310add364d2ade40620cde0f1c37f4f00a6999b2d3e7ea8dacda4aa1630/g' feeds/packages/libs/nss/Makefile

# nspr
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.33/g' feeds/packages/libs/nspr/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=b23ee315be0e50c2fb1aa374d17f2d2d9146a835b1a79c1918ea15d075a693d7/g' feeds/packages/libs/nspr/Makefile

# unrar
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=6.2.6/g' feeds/packages/utils/unrar/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=0c2d4cbc8b34d0e3bec7b474e0f52bbcc6c4320ec089b4141223ee355f63c318/g' feeds/packages/utils/unrar/Makefile

# zstd
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.5.2/g' feeds/packages/utils/zstd/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=3ea06164971edec7caa2045a1932d757c1815858e4c2b68c7ef812647535c23f/g' feeds/packages/utils/zstd/Makefile

# pigz
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.7/g' feeds/packages/utils/pigz/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=b4c9e60344a08d5db37ca7ad00a5b2c76ccb9556354b722d56d55ca7e8b1c707/g' feeds/packages/utils/pigz/Makefile
#rm -rf feeds/packages/utils/pigz/patches

# gzip
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.12/g' feeds/packages/utils/gzip/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/gzip/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=ce5e03e519f637e1f814011ace35c4f87b33c0bbabeec35baf5fbd3479e91956/g' feeds/packages/utils/gzip/Makefile

# replace banner
#cp -f $GITHUB_WORKSPACE/general/openwrt_banner package/base-files/files/etc/banner

# xtables-addons
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.19/g' feeds/packages/net/xtables-addons/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/xtables-addons/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=5e36ea027ab15a84d9af1f3f8e84a78b80a617093657f08089bd44657722f661/g' feeds/packages/net/xtables-addons/Makefile
rm -rf feeds/packages/net/xtables-addons
cp -rf $GITHUB_WORKSPACE/general/xtables-addons feeds/packages/net

# libssh2
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.10.0/g' feeds/packages/libs/libssh2/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/libs/libssh2/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2d64e90f3ded394b91d3a2e774ca203a4179f69aebee03003e5a6fa621e41d51/g' feeds/packages/libs/libssh2/Makefile

# gnutls
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.7.6/g' feeds/packages/libs/gnutls/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=77065719a345bfb18faa250134be4c53bef70c1bd61f6c0c23ceb8b44f0262ff/g' feeds/packages/libs/gnutls/Makefile
#sed -i 's/libzstd/zstd/g' feeds/packages/libs/gnutls/Makefile
#rm -f feeds/packages/libs/gnutls/patches/020-dont-install-m4-files.patch

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

# frp
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.42.0/g' feeds/packages/net/frp/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASCONFIG_PACKAGE_kmod-crypto-sha3H:=4bb815e9c9a4588fce20c6ef33168f0ceb1f420937c4dcf03ce085666328043a/g' feeds/packages/net/frp/Makefile

# openvpn
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.5.6/g' feeds/packages/net/openvpn/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=13c7c3dc399d1b571cabf189c4d34ae34656ee72b6bde2a8059c1e9bc61574ed/g' feeds/packages/net/openvpn/Makefile

# php8
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.1.6/g' feeds/packages/lang/php8/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=da38d65bb0d5dd56f711cd478204f2b62a74a2c2b0d2d523a78d6eb865b2364c/g' feeds/packages/lang/php8/Makefile

# wolfSSL
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.2.0-stable/g' package/libs/wolfssl/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=409b4646c5f54f642de0e9f3544c3b83de7238134f5b1ff93fb44527bf119d05/g' package/libs/wolfssl/Makefile

# netdata
#sed -i 's/DEPENDS:=.*/DEPENDS:=+zlib +libuuid +libuv +libmnl +libjson-c +liblz4/g' feeds/packages/admin/netdata/Makefile

# fix speedtest-cli
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=2.1.3/" feeds/packages/lang/python/python3-speedtest-cli/Makefile
#sed -i "s/PKG_RELEASE:=.*/PKG_RELEASE:=1/" feeds/packages/lang/python/python3-speedtest-cli/Makefile
#sed -i "s/PKG_HASH:=.*/PKG_HASH:=5e2773233cedb5fa3d8120eb7f97bcc4974b5221b254d33ff16e2f1d413d90f0/" feeds/packages/lang/python/python3-speedtest-cli/Makefile

# themes
#svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/luci-theme-rosy
#git clone https://github.com/rosywrt/luci-theme-purple.git package/luci-theme-purple
#git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
#git clone https://github.com/kevin-morgan/luci-theme-argon-dark.git package/luci-theme-argon-dark
#svn co https://github.com/openwrt/luci/trunk/themes/luci-theme-openwrt-2020 package/luci-theme-openwrt-2020
#git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
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

# frp
sed -i 's/frp 客户端/FRP 客户端/g' feeds/luci/applications/luci-app-frpc/po/zh_Hans/frpc.po

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

# Vermagic 2203 SNAPSHOT ONLY
#wget https://downloads.openwrt.org/releases/22.03-SNAPSHOT/targets/armvirt/64/packages/Packages.gz
#zgrep -m 1 "Depends: kernel (=.*)$" Packages.gz | sed -e 's/.*-\(.*\))/\1/' > .vermagic
#sed -i -e 's/^\(.\).*vermagic$/\1cp $(TOPDIR)\/.vermagic $(LINUX_DIR)\/.vermagic/' include/kernel-defaults.mk

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

# autocoreapp-portage/repoman
#sed -i 's/DEPENDS:=@(.*/DEPENDS:=@(TARGET_bcm27xx||TARGET_bcm53xx||TARGET_ipq40xx||TARGET_ipq806x||TARGET_mvebu||TARGET_sunxi||TARGET_rockchip||TARGET_armvirt) \\/g' package/lean/autocore/Makefile

# fix nginx-ssl-util error (do not use fallthrough attribute)
#rm feeds/packages/net/nginx-util/src/nginx-ssl-util.hpp
#wget -P feeds/packages/net/nginx-util/src https://raw.githubusercontent.com/peter-stadler/packages/c102ecb4f59a3f76184cd3cc73a4e9653abdca84/net/nginx-util/src/nginx-ssl-util.hpp

# fix build on kernel 5.15
#cp -f $GITHUB_WORKSPACE/general/usb.mk package/kernel/linux/modules
#cp -f $GITHUB_WORKSPACE/general/netdevices.mk package/kernel/linux/modules

# expat
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.4.8/g' feeds/packages/libs/expat/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=f79b8f904b749e3e0d20afeadecf8249c55b2e32d4ebb089ae378df479dcaf25/g' feeds/packages/libs/expat/Makefile

# perl
#rm -rf feeds/packages/lang/perl
#cp -rf $GITHUB_WORKSPACE/general/perl feeds/packages/lang

# zerotier
#rm -rf feeds/packages/net/zerotier
#cp -rf $GITHUB_WORKSPACE/general/zerotier feeds/packages/net

# util-linux
rm -rf package/utils/util-linux
cp -rf $GITHUB_WORKSPACE/general/util-linux package/utils

# lsof
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.95.0/g' feeds/packages/utils/lsof/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=e9faa0fbcc48638c1d1f143e93573ac43b65e76646150f83e24bd8c18786303c/g' feeds/packages/utils/lsof/Makefile

# zsh
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.9/g' feeds/packages/utils/zsh/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=9b8d1ecedd5b5e81fbf1918e876752a7dd948e05c1a0dba10ab863842d45acd5/g' feeds/packages/utils/zsh/Makefile

# helloworld
git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld
#wget -P package/helloworld/shadowsocksr-libev/patches https://raw.githubusercontent.com/sbwml/openwrt_helloworld/v5/shadowsocksr-libev/patches/104-pointer-used-after-free.patch

# passwall
git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
git clone https://github.com/xiaorouji/openwrt-passwall2.git package/openwrt-passwall2
git clone https://github.com/xiaorouji/openwrt-passwall-packages.git package/openwrt-passwall-packages
rm -rf package/openwrt-passwall-packages/shadowsocksr-libev

# sing-box
rm -rf feeds/packages/net/sing-box
cp -rf $GITHUB_WORKSPACE/general/sing-box feeds/packages/net/sing-box

# Optimization level -Ofast
if [ "$platform" = "x86_64" ]; then
    curl -s https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/target-modify_for_x86_64.patch | patch -p1
fi

# x86 - disable intel_pstate
sed -i 's/noinitrd/noinitrd intel_pstate=disable/g' target/linux/x86/image/grub-efi.cfg

# libpfring
rm -rf feeds/packages/libs/libpfring
cp -rf $GITHUB_WORKSPACE/general/libpfring feeds/packages/libs/libpfring

# bash
if [ "$platform" = "x86_64" ]; then
sed -i 's#ash#bash#g' package/base-files/files/etc/passwd
fi
sed -i 's#\\u@\\h:\\w\\\$#\\[\\e[32;1m\\][\\u@\\h\\[\\e[0m\\] \\[\\033[01;34m\\]\\W\\[\\033[00m\\]\\[\\e[32;1m\\]]\\[\\e[0m\\]\\\$#g' package/base-files/files/etc/profile
mkdir -pv files/root
curl -so files/root/.bash_profile https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/files/root/.bash_profile
curl -so files/root/.bashrc https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/files/root/.bashrc

./scripts/feeds update -a
./scripts/feeds install -a
