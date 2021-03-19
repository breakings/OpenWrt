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

#移除不用软件包    
rm -rf feeds/packages/libs/libgd-full
rm -rf feeds/luci/collections/luci-lib-docker
rm -rf package/network

#添加额外软件包
#git clone https://github.com/jerrykuku/luci-app-jd-dailybonus.git package/luci-app-jd-dailybonus
git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
svn co https://github.com/vernesong/OpenClash/trunk/luci-app-openclash package/luci-app-openclash
git clone https://github.com/project-lede/luci-app-godproxy package/luci-app-godproxy
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
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-core package/xray-core
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/xray-plugin package/xray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/v2ray-plugin package/v2ray-plugin
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ssocks package/ssocks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/dns2socks package/dns2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/ipt2socks package/ipt2socks
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/microsocks package/microsocks 
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/pdnsd-alt package/pdnsd-alt
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/shadowsocksr-libev package/shadowsocksr-libev
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/simple-obfs package/simple-obfs
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/kcptun package/kcptun
svn co https://github.com/xiaorouji/openwrt-passwall/trunk/trojan package/trojan

#菜单定制
svn co https://github.com/Lienol/openwrt/branches/19.07/package/network package/network
svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-19.07/package/lean/luci-app-cpufreq package/lean/luci-app-cpufreq
#svn co https://github.com/immortalwrt/immortalwrt/branches/openwrt-19.07/package/lean/luci-app-airplay2 package/lean/luci-app-airplay2
svn co https://github.com/Lienol/openwrt/branches/19.07/package/lean/luci-app-flowoffload package/lean/luci-app-flowoffload
svn co https://github.com/Lienol/openwrt/branches/19.07/package/lean/luci-app-cifs-mount package/lean/luci-app-cifs-mount
svn co https://github.com/Lienol/openwrt/branches/19.07/package/lean/luci-app-nfs package/lean/luci-app-nfs
svn co https://github.com/Lienol/openwrt/branches/19.07/package/lean/luci-app-netdata package/lean/luci-app-netdata
svn co https://github.com/Lienol/openwrt/branches/19.07/package/lean/luci-app-usb-printer package/lean/luci-app-usb-printer
svn co https://github.com/Lienol/openwrt/branches/19.07/package/lean/luci-app-filetransfer package/lean/luci-app-filetransfer
svn co https://github.com/Lienol/openwrt/branches/19.07/package/lean/luci-lib-fs package/lean/luci-lib-fs
svn co https://github.com/Lienol/openwrt/branches/19.07/package/lean/luci-app-zerotier package/lean/luci-app-zerotier
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/coremark package/lean/coremark
svn co https://github.com/Lienol/openwrt/branches/19.07/package/network/fullconenat package/network/fullconenat 
#svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-docker package/lean/luci-app-docker
#svn co https://github.com/coolsnowwolf/packages/trunk/utils/docker-ce package/utils/docker-ce
svn co https://github.com/Lienol/openwrt/branches/19.07/package/diy/luci-lib-docker package/luci-lib-docker
svn co https://github.com/Lienol/openwrt/branches/19.07/package/lean/luci-app-openvpn-server package/lean/luci-app-openvpn-server
svn co https://github.com/Lienol/openwrt/branches/19.07/package/lean/luci-app-autoreboot package/lean/luci-app-autoreboot

#svn co https://github.com/fw876/helloworld/trunk/xray-core package/xray-core
#svn co https://github.com/fw876/helloworld/trunk/xray-plugin package/xray-plugin
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-gost package/luci-app-gost
#svn co https://github.com/kenzok8/openwrt-packages/trunk/gost package/gost
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-gost package/luci-app-gost
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gost package/gost
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/luci-app-eqos
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus
svn co https://github.com/fw876/helloworld/trunk/naiveproxy package/naiveproxy
svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/redsocks2 package/lean/redsocks2


#添加smartdns
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/smartdns package/smartdns
svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns package/luci-app-smartdns
#添加ddnsto
#svn co https://github.com/linkease/ddnsto-openwrt/trunk/ddnsto package/ddnsto
#svn co https://github.com/linkease/ddnsto-openwrt/trunk/luci-app-ddnsto package/luci-app-ddnsto
#添加udp2raw
#git clone https://github.com/sensec/openwrt-udp2raw package/openwrt-udp2raw
#git clone https://github.com/sensec/luci-app-udp2raw package/luci-app-udp2raw
#sed -i "s/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=f2f90a9a150be94d50af555b53657a2a4309f287/" package/openwrt-udp2raw/Makefile
#sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=20200920\.0/" package/openwrt-udp2raw/Makefile

#themes
#svn co https://github.com/rosywrt/luci-theme-rosy/trunk/luci-theme-rosy package/luci-theme-rosy
#git clone https://github.com/rosywrt/luci-theme-purple.git package/luci-theme-purple
#git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
#git clone https://github.com/kevin-morgan/luci-theme-argon-dark.git package/luci-theme-argon-dark
svn co https://github.com/openwrt/luci/trunk/themes/luci-theme-openwrt-2020 package/luci-theme-openwrt-2020
git clone https://github.com/jerrykuku/luci-theme-argon.git  package/luci-theme-argon

./scripts/feeds update -a
./scripts/feeds install -a

#readd cpufreq for aarch64
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile
sed -i 's/services/system/g'  package/lean/luci-app-cpufreq/luasrc/controller/cpufreq.lua

#默认设置
#sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/aria2.lua
#sed -i 's/\"services\"/\"nas\"/g' /usr/lib/lua/luci/controller/usb_printer.lua
#sed -i 's/services/nas/g' /root/usr/share/luci/menu.d/luci-app-p910nd.json
#sed -i 's/services/nas/g' /root/usr/share/luci/menu.d/luci-app-minidlna.json
#sed -i 's/services/nas/g' /root/usr/share/luci/menu.d/luci-app-hd-idle.json

#replace coremark.sh with the new one
#rm package/lean/coremark/coremark.sh
#cp $GITHUB_WORKSPACE/general/coremark.sh package/lean/coremark/
svn co https://github.com/openwrt/packages/trunk/utils/coremark package/utils/coremark
cp $GITHUB_WORKSPACE/general/coremark.sh package/utils/coremark/
cp $GITHUB_WORKSPACE/general/coremark package/utils/coremark/

#同步官方kernel-version.mk
#rm include/kernel-version.mk
#svn co --depth=empty  https://github.com/openwrt/openwrt/trunk/include kerner-version
#cd kerner-version
#svn up kernel-version.mk
