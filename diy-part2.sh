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

echo "开始 DIY2 配置……"
echo "========================="

function merge_package(){
    repo=`echo $1 | rev | cut -d'/' -f 1 | rev`
    pkg=`echo $2 | rev | cut -d'/' -f 1 | rev`
    # find package/ -follow -name $pkg -not -path "package/custom/*" | xargs -rt rm -rf
    git clone --depth=1 --single-branch $1
    mv $2 package/custom/
    rm -rf $repo
}
function drop_package(){
    find package/ -follow -name $1 -not -path "package/custom/*" | xargs -rt rm -rf
}
function merge_feed(){
    if [ ! -d "feed/$1" ]; then
        echo >> feeds.conf.default
        echo "src-git $1 $2" >> feeds.conf.default
    fi
    ./scripts/feeds update $1
    ./scripts/feeds install -a -p $1
}
rm -rf package/custom; mkdir package/custom

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
 rm -rf package/libs/elfutils
 #rm -rf feeds/packages/utils/gnupg
 #rm -rf feeds/packages/lang/python/python3
 #rm -rf package/lean/n2n_v2

# BTF: fix failed to validate module
# config/Config-kernel.in patch
curl -s https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/generic/0001-kernel-add-MODULE_ALLOW_BTF_MISMATCH-option.patch | patch -p1
patch -p1 < $GITHUB_WORKSPACE/PATCH/add-xdp-diag.patch
#atch -p1 < $GITHUB_WORKSPACE/PATCH/lede_add_immotalwrt_download_method.patch

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
merge_package https://github.com/jerrykuku/lua-maxminddb lua-maxminddb
merge_package https://github.com/xiangfeidexiaohuo/extra-ipk extra-ipk/patch/wall-luci/luci-app-vssr
merge_package https://github.com/vernesong/OpenClash OpenClash/luci-app-openclash
#git clone https://github.com/project-lede/luci-app-godproxy package/luci-app-godproxy
merge_package https://github.com/ilxp/luci-app-ikoolproxy luci-app-ikoolproxy
#svn co https://github.com/openwrt/luci/trunk/modules/luci-mod-dashboard feeds/luci/modules/luci-mod-dashboard
#svn co https://github.com/openwrt/packages/trunk/net/openssh package/openssh
#svn co https://github.com/openwrt/packages/trunk/libs/libfido2 package/libfido2
#svn co https://github.com/openwrt/packages/trunk/libs/libcbor package/libcbor
merge_package https://github.com/ophub/luci-app-amlogic luci-app-amlogic
#svn co https://github.com/breakings/OpenWrt/trunk/general/luci-app-cpufreq package/luci-app-cpufreq
#svn co https://github.com/breakings/OpenWrt/trunk/general/ntfs3 package/lean/ntfs3
#svn co https://github.com/Lienol/openwrt-package/trunk/luci-app-socat package/luci-app-socat
merge_package https://github.com/openwrt/openwrt.git openwrt/package/libs/elfutils
#svn co https://github.com/breakings/OpenWrt/trunk/general/gnupg feeds/packages/utils/gnupg
#svn co https://github.com/breakings/OpenWrt/trunk/general/n2n_v2 package/lean/n2n_v2

# 编译 po2lmo (如果有po2lmo可跳过)
pushd package/custom/luci-app-openclash/tools/po2lmo
make && sudo make install
popd
#svn co https://github.com/xiaorouji/openwrt-passwall/trunk/brook package/brook
cp -rf $GITHUB_WORKSPACE/general/brook package/brook
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/chinadns-ng
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/tcping
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/trojan-go
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/trojan-plus
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-filebrowser package/luci-app-filebrowser
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/filebrowser package/filebrowser
#svn co https://github.com/project-openwrt/openwrt/trunk/package/lienol/luci-app-fileassistant package/luci-app-fileassistant
merge_package https://github.com/xiaorouji/openwrt-passwall openwrt-passwall/luci-app-passwall
merge_package https://github.com/xiaorouji/openwrt-passwall2 openwrt-passwall2/luci-app-passwall2
#cp -rf $GITHUB_WORKSPACE/general/luci-app-passwall package/luci-app-passwall
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/shadowsocks-rust
#svn co https://github.com/fw876/helloworld/trunk/shadowsocks-rust package/shadowsocks-rust
#svn co https://github.com/xiaorouji/openwrt-passwall-packages/trunk/xray-core package/xray-core
#svn co https://github.com/xiaorouji/openwrt-passwall-packages/trunk/xray-plugin package/xray-plugin
cp -rf $GITHUB_WORKSPACE/general/xray-core package/xray-core
cp -rf $GITHUB_WORKSPACE/general/xray-plugin package/xray-plugin
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/ssocks
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/dns2socks
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/ipt2socks
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/microsocks 
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/pdnsd-alt
#svn co https://github.com/xiaorouji/openwrt-passwall-packages/trunk/shadowsocksr-libev package/shadowsocksr-libev
#svn co https://github.com/fw876/helloworld/trunk/shadowsocksr-libev package/shadowsocksr-libev
merge_package https://github.com/fw876/helloworld helloworld/shadowsocksr-libev
#svn co https://github.com/fw876/helloworld/trunk/lua-neturl package/lua-neturl
merge_package https://github.com/fw876/helloworld helloworld/lua-neturl
#svn co https://github.com/fw876/helloworld/trunk/tcping package/tcping
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/v2ray-core
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/v2ray-plugin
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/v2ray-geodata
#svn co https://github.com/fw876/helloworld/trunk/v2ray-plugin package/v2ray-plugin
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/simple-obfs
#svn co https://github.com/xiaorouji/openwrt-passwall-packages/trunk/kcptun package/kcptun
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/trojan
merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/hysteria
#svn co https://github.com/xiaorouji/openwrt-passwall-packages/trunk/dns2tcp package/dns2tcp
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/sing-box

merge_package https://github.com/fw876/helloworld helloworld/shadow-tls
merge_package https://github.com/fw876/helloworld helloworld/tuic-client
merge_package https://github.com/fw876/helloworld helloworld/dns2tcp
#merge_package https://github.com/fw876/helloworld helloworld/v2ray-geodata
#svn co https://github.com/fw876/helloworld/trunk/xray-core package/xray-core
#svn co https://github.com/fw876/helloworld/trunk/xray-plugin package/xray-plugin
#merge_package https://github.com/kenzok8/openwrt-packages openwrt-packages/luci-app-gost
cp -rf $GITHUB_WORKSPACE/general/luci-app-gost package/luci-app-gost
cp -rf $GITHUB_WORKSPACE/general/gost package/gost
#svn co https://github.com/kenzok8/openwrt-packages/trunk/gost package/gost
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-gost package/luci-app-gost
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/gost package/gost
merge_package https://github.com/kenzok8/openwrt-packages openwrt-packages/luci-app-eqos
git clone https://github.com/tty228/luci-app-serverchan.git package/luci-app-serverchan
#svn co https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus package/luci-app-ssr-plus
merge_package https://github.com/fw876/helloworld helloworld/luci-app-ssr-plus
#svn co https://github.com/fw876/helloworld/trunk/naiveproxy package/naiveproxy
#merge_package https://github.com/xiaorouji/openwrt-passwall-packages openwrt-passwall-packages/naiveproxy
merge_package https://github.com/fw876/helloworld helloworld/redsocks2
merge_package https://github.com/rufengsuixing/luci-app-adguardhome luci-app-adguardhome
merge_package https://github.com/Lienol/openwrt-package openwrt-package/luci-app-filebrowser
merge_package https://github.com/Lienol/openwrt-package openwrt-package/luci-app-ssr-mudb-server
merge_package https://github.com/kiddin9/openwrt-packages openwrt-packages/luci-app-speederv2

#添加smartdns
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/smartdns package/smartdns
#svn co https://github.com/project-openwrt/openwrt/trunk/package/ntlf9t/luci-app-smartdns package/luci-app-smartdns
#svn co https://github.com/openwrt/luci/trunk/applications/luci-app-smartdns package/luci-app-smartdns
merge_package https://github.com/kenzok8/openwrt-packages openwrt-packages/luci-app-smartdns

#mosdns
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
merge_package https://github.com/sbwml/luci-app-mosdns luci-app-mosdns
merge_package https://github.com/sbwml/luci-app-mosdns luci-app-mosdns/mosdns

#修改bypass的makefile
#git clone https://github.com/garypang13/luci-app-bypass package/luci-app-bypass
#find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
#find package/*/ feeds/*/ -maxdepth 2 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}
#find package/luci-app-bypass/*/ -maxdepth 8 -path "*" | xargs -i sed -i 's/smartdns-le/smartdns/g' {}

#添加ddnsto
#svn co https://github.com/linkease/ddnsto-openwrt/trunk/ddnsto package/ddnsto
#svn co https://github.com/linkease/ddnsto-openwrt/trunk/luci-app-ddnsto package/luci-app-ddnsto
git clone https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
#添加udp2raw
#git clone https://github.com/sensec/openwrt-udp2raw package/openwrt-udp2raw
merge_package https://github.com/sensec/openwrt-udp2raw openwrt-udp2raw
#git clone https://github.com/sensec/luci-app-udp2raw package/luci-app-udp2raw
merge_package https://github.com/sensec/luci-app-udp2raw luci-app-udp2raw
sed -i "s/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=f2f90a9a150be94d50af555b53657a2a4309f287/" package/custom/openwrt-udp2raw/Makefile
sed -i "s/PKG_VERSION:=.*/PKG_VERSION:=20200920\.0/" package/custom/openwrt-udp2raw/Makefile

#themes
merge_package https://github.com/rosywrt/luci-theme-rosy luci-theme-rosy
#git clone https://github.com/rosywrt/luci-theme-purple.git package/luci-theme-purple
#git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
merge_package https://github.com/Leo-Jo-My/luci-theme-opentomcat luci-theme-opentomcat
merge_package https://github.com/Leo-Jo-My/luci-theme-opentomato luci-theme-opentomato
#svn co https://github.com/sirpdboy/luci-theme-opentopd/trunk package/luci-theme-opentopd
#git clone https://github.com/kevin-morgan/luci-theme-argon-dark.git package/luci-theme-argon-dark
#svn co https://github.com/kevin-morgan/luci-theme-argon-dark/trunk package/luci-theme-argon-dark
#svn co https://github.com/openwrt/luci/trunk/themes/luci-theme-openwrt-2020 package/luci-theme-openwrt-2020
merge_package https://github.com/thinktip/luci-theme-neobird luci-theme-neobird
rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon

# nginx-util
rm -rf feeds/packages/net/nginx-util
merge_package https://github.com/openwrt/packages packages/net/nginx-util

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
#merge_package https://github.com/openwrt/packages packages/net/samba4
git clone https://github.com/sbwml/feeds_packages_net_samba4 feeds/packages/net/samba4
# enable multi-channel
sed -i '/workgroup/a \\n\t## enable multi-channel' feeds/packages/net/samba4/files/smb.conf.template
sed -i '/enable multi-channel/a \\tserver multi channel support = yes' feeds/packages/net/samba4/files/smb.conf.template
# default config
sed -i 's/#aio read size = 0/aio read size = 0/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/#aio write size = 0/aio write size = 0/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/invalid users = root/#invalid users = root/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/bind interfaces only = yes/bind interfaces only = no/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/#create mask/create mask/g' feeds/packages/net/samba4/files/smb.conf.template
sed -i 's/#directory mask/directory mask/g' feeds/packages/net/samba4/files/smb.conf.template
#sed -i 's/0666/0644/g;s/0744/0755/g;s/0777/0755/g' feeds/luci/applications/luci-app-samba4/htdocs/luci-static/resources/view/samba4.js
sed -i 's/0666/0644/g;s/0777/0755/g' feeds/packages/net/samba4/files/samba.config
sed -i 's/0666/0644/g;s/0777/0755/g' feeds/packages/net/samba4/files/smb.conf.template

# ffmpeg
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.1.4/g' feeds/packages/multimedia/ffmpeg/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=54383bb890a1cd62580e9f1eaa8081203196ed53bde9e98fb6b0004423f49063/g' feeds/packages/multimedia/ffmpeg/Makefile
rm -rf feeds/packages/multimedia/ffmpeg
cp -rf $GITHUB_WORKSPACE/general/ffmpeg feeds/packages/multimedia

# btrfs-progs
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=6.8/g' feeds/packages/utils/btrfs-progs/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=9c21645feac182611e28b47769d5f613cb9e2ecab58ece60b10e6c55a9ead575/g' feeds/packages/utils/btrfs-progs/Makefile
rm -rf feeds/packages/utils/btrfs-progs/patches
#sed -i '68i\	--disable-libudev \\' feeds/packages/utils/btrfs-progs/Makefile

# qBittorrent (use cmake)
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.4.0/g' feeds/packages/net/qBittorrent/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=da240744c6cc5953d7c4d298a02a0cf36d2c8897931819f1e6459bd5270a7c5c/g' feeds/packages/net/qBittorrent/Makefile
#sed -i '41i\		+qt5-sql \\' feeds/packages/net/qBittorrent/Makefile
#cp -rf $GITHUB_WORKSPACE/general/qBittorrent/patches feeds/packages/net/qBittorrent
cp -f $GITHUB_WORKSPACE/general/qBittorrent/Makefile feeds/packages/net/qBittorrent/Makefile
#sed -i 's/zh/zh_CN/g' feeds/luci/applications/luci-app-qbittorrent/root/etc/config/qbittorrent

# libtorrent-rasterbar_v2
rm -rf feeds/packages/libs/libtorrent-rasterbar/patches
cp -f $GITHUB_WORKSPACE/general/libtorrent-rasterbar/Makefile feeds/packages/libs/libtorrent-rasterbar

# golang
#sed -i 's/GO_VERSION_MAJOR_MINOR:=.*/GO_VERSION_MAJOR_MINOR:=1.19/g' feeds/packages/lang/golang/golang/Makefile
#sed -i 's/GO_VERSION_PATCH:=.*/GO_VERSION_PATCH:=7/g' feeds/packages/lang/golang/golang/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=775bdf285ceaba940da8a2fe20122500efd7a0b65dbcee85247854a8d7402633/g' feeds/packages/lang/golang/golang/Makefile
rm -rf feeds/packages/lang/golang
cp -rf $GITHUB_WORKSPACE/general/golang feeds/packages/lang/golang

# curl
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.6.0/g' feeds/packages/net/curl/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=b4785f2d8877fa92c0e45d7155cf8cc6750dbda961f4b1a45bcbec990cf2fa9b/g' feeds/packages/net/curl/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/curl/Makefile
rm -rf feeds/packages/net/curl
merge_package https://github.com/openwrt/packages packages/net/curl

# Qt5 -qtbase
sed -i "s/PKG_BUGFIX:=.*/PKG_BUGFIX:=13/g" feeds/packages/libs/qtbase/Makefile
sed -i "s/PKG_HASH:=.*/PKG_HASH:=4cca51dcc1f22ceeee6b3e33cd1c3a60b14e85e24644dca3af89a2c2989ab809/g" feeds/packages/libs/qtbase/Makefile
#rm -rf feeds/packages/libs/qtbase
#cp -rf $GITHUB_WORKSPACE/general/qt6base feeds/packages/libs

# Qt5 -qttools
sed -i "s/PKG_BUGFIX:=.*/PKG_BUGFIX:=13/g" feeds/packages/libs/qttools/Makefile
sed -i "s/PKG_HASH:=.*/PKG_HASH:=57c9794c572c4e02871f2e7581525752b0cf85ea16cfab23a4ac9ba7b39a5d34/g" feeds/packages/libs/qttools/Makefile
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
#sed -i 's/PKG_VERSION:=20.10.17/PKG_VERSION:=20.10.23/g' feeds/packages/utils/docker/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/docker/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=55563b87050ce7b9b2124a9b882fdef4fa17e23f431ad502c8227101d5e789fd/g' feeds/packages/utils/docker/Makefile
#sed -i 's/PKG_GIT_SHORT_COMMIT:=100c701/PKG_GIT_SHORT_COMMIT:=7155243/g' feeds/packages/utils/docker/Makefile
rm -rf feeds/packages/utils/docker
cp -rf $GITHUB_WORKSPACE/general/docker feeds/packages/utils/docker

# dockerd
#sed -i 's/PKG_VERSION:=20.10.17/PKG_VERSION:=20.10.23/g' feeds/packages/utils/dockerd/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/dockerd/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=61bb3f4f0c935ac9a719adbac69fca0d727b6b5c3eb889571e00b1cc3ff1e368/g' feeds/packages/utils/dockerd/Makefile
#sed -i 's/PKG_GIT_SHORT_COMMIT:=a89b842/PKG_GIT_SHORT_COMMIT:=6051f14/g' feeds/packages/utils/dockerd/Makefile
#sed -i 's/^\s*$[(]call\sEnsureVendoredVersion/#&/' feeds/packages/utils/dockerd/Makefile
rm -rf feeds/packages/utils/dockerd
cp -rf $GITHUB_WORKSPACE/general/dockerd feeds/packages/utils/dockerd

# docker-compose
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.27.0/g' feeds/packages/utils/docker-compose/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=29b2232d1609dff03db74188a7944c85ba8b612f47a7e39938a43db8fb7d7067/g' feeds/packages/utils/docker-compose/Makefile

# containerd
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.5.11/g' feeds/packages/utils/containerd/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=skip/g' feeds/packages/utils/containerd/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=3df54a852345ae127d1fa3092b95168e4a88e2f8/g' feeds/packages/utils/containerd/Makefile
cp -f $GITHUB_WORKSPACE/general/containerd/Makefile feeds/packages/utils/containerd

# runc
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.1.12/g' feeds/packages/utils/runc/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=be31b07d6a54a8f234016501c300ad04b6c428c56588e7eca8c3b663308db208/g' feeds/packages/utils/runc/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=51d5e94601ceffbbd85688df1c928ecccbfa4685/g' feeds/packages/utils/runc/Makefile
#sed -i '12d' feeds/packages/utils/runc/Makefile

# bsdtar
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.7.2/g' feeds/packages/libs/libarchive/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=04357661e6717b6941682cde02ad741ae4819c67a260593dfb2431861b251acb/g' feeds/packages/libs/libarchive/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/libs/libarchive/Makefile

# pcre
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.45/g' package/libs/pcre/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' package/libs/pcre/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=4dae6fdcd2bb0bb6c37b5f97c33c2be954da743985369cddac3546e3218bffb8/g' package/libs/pcre/Makefile

# pcre2
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=10.42/g' feeds/packages/libs/pcre2/Makefile
#sed -i 's|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=https://github.com/PCRE2Project/pcre2/releases/download/$(PKG_NAME)-$(PKG_VERSION)|g' feeds/packages/libs/pcre2/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=8d36cd8cb6ea2a4c2bb358ff6411b0c788633a2a45dabbf1aeb4b701d1b5e840/g' feeds/packages/libs/pcre2/Makefile
#sed -i '69i\	-DPCRE2_STATIC_PIC=ON \\' feeds/packages/libs/pcre2/Makefile
rm -rf feeds/packages/libs/pcre2
cp -rf $GITHUB_WORKSPACE/general/pcre2 feeds/packages/libs/pcre2

# libseccomp
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.5.4/g' feeds/packages/libs/libseccomp/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=d82902400405cf0068574ef3dc1fe5f5926207543ba1ae6f8e7a1576351dcbdb/g' feeds/packages/libs/libseccomp/Makefile

# wsdd2
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/wsdd2//Makefile
sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2023-12-21/g' feeds/packages/net/wsdd2//Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=b676d8ac8f1aef792cb0761fb68a0a589ded3207/g' feeds/packages/net/wsdd2//Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=ac817f63605508779ebebf612fcb7d594ff87d3050b788f240d1fea9fdbaa3a0/g' feeds/packages/net/wsdd2/Makefile

# openvpn
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.5.6/g' feeds/packages/net/openvpn/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=13c7c3dc399d1b571cabf189c4d34ae34656ee72b6bde2a8059c1e9bc61574ed/g' feeds/packages/net/openvpn/Makefile
#rm -rf feeds/packages/net/openvpn
#cp -rf $GITHUB_WORKSPACE/general/openvpn feeds/packages/net

# php8
#rm -rf feeds/packages/lang/php8
#svn co https://github.com/openwrt/packages/trunk/lang/php8 feeds/packages/lang/php8
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.3.6/g' feeds/packages/lang/php8/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=53c8386b2123af97626d3438b3e4058e0c5914cb74b048a6676c57ac647f5eae/g' feeds/packages/lang/php8/Makefile

# python-docker
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=7.0.0/g' feeds/packages/lang/python/python-docker/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=323736fb92cd9418fc5e7133bc953e11a9da04f4483f828b527db553f1e7e5a3/g' feeds/packages/lang/python/python-docker/Makefile
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
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.6/g' feeds/packages/utils/parted/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=3b43dbe33cca0f9a18601ebab56b7852b128ec1a3df3a9b30ccde5e73359e612/g' feeds/packages/utils/parted/Makefile

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
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.6.2/g' feeds/packages/libs/expat/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=ee14b4c5d8908b1bec37ad937607eab183d4d9806a08adee472c3c3121d27364/g' feeds/packages/libs/expat/Makefile
cp -f $GITHUB_WORKSPACE/general/expat/Makefile feeds/packages/libs/expat

# socat
#rm -rf feeds/packages/net/socat
#svn co https://github.com/openwrt/packages/trunk/net/socat feeds/packages/net/socat
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.8.0.0/g' feeds/packages/net/socat/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/socat/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=e1de683dd22ee0e3a6c6bbff269abe18ab0c9d7eb650204f125155b9005faca7/g' feeds/packages/net/socat/Makefile

# transmission-web-control
sed -i 's/PKG_SOURCE_DATE:=.*/PKG_SOURCE_DATE:=2021-09-25/g' feeds/packages/net/transmission-web-control/Makefile
sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=4b2e1858f7a46ee678d5d1f3fa1a6cf2c739b88a/g' feeds/packages/net/transmission-web-control/Makefile
sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=ea014c295766e2efc7b890dc6a6940176ba9c5bdcf85a029090f2bb850e59708/g' feeds/packages/net/transmission-web-control/Makefile

# htop
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.3.0/g' feeds/packages/admin/htop/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=1e5cc328eee2bd1acff89f860e3179ea24b85df3ac483433f92a29977b14b045/g' feeds/packages/admin/htop/Makefile

# python3
sed -i 's/PYTHON3_VERSION_MICRO:=.*/PYTHON3_VERSION_MICRO:=9/g' feeds/packages/lang/python/python3-version.mk
sed -i 's/PYTHON3_SETUPTOOLS_VERSION:=.*/PYTHON3_SETUPTOOLS_VERSION:=65.5.0/g' feeds/packages/lang/python/python3-version.mk
sed -i 's/PYTHON3_PIP_VERSION:=.*/PYTHON3_PIP_VERSION:=22.3.1/g' feeds/packages/lang/python/python3-version.mk
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python3/Makefile
#svn co https://github.com/openwrt/packages/branches/openwrt-21.02/lang/python/python3 feeds/packages/lang/python/python3
sed -i 's/PKG_HASH:=.*/PKG_HASH:=5ae03e308260164baba39921fdb4dbf8e6d03d8235a939d4582b33f0b5e46a83/g' feeds/packages/lang/python/python3/Makefile
rm -rf feeds/packages/lang/python/python3/patches-pip

# python-yaml
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=6.0/g' feeds/packages/lang/python/python-yaml/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python-yaml/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=68fb519c14306fec9720a2a5b45bc9f0c8d1b9c72adf45c37baedfcd949c35a2/g' feeds/packages/lang/python/python-yaml/Makefile
#sed -i '22i\HOST_PYTHON3_PACKAGE_BUILD_DEPENDS:=Cython\n' feeds/packages/lang/python/python-yaml/Makefile

# python-websocket-client
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.7.0/g' feeds/packages/lang/python/python-websocket-client/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=10e511ea3a8c744631d3bd77e61eb17ed09304c413ad42cf6ddfa4c7787e8fe6/g' feeds/packages/lang/python/python-websocket-client/Makefile

# python-texttable
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.6.4/g' feeds/packages/lang/python/python-texttable/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=42ee7b9e15f7b225747c3fa08f43c5d6c83bc899f80ff9bae9319334824076e9/g' feeds/packages/lang/python/python-texttable/Makefile

# python-urllib3
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.26.15/g' feeds/packages/lang/python/python-urllib3/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=8a388717b9476f934a21484e8c8e61875ab60644d29b9b39e11e4b9dc1c6b305/g' feeds/packages/lang/python/python-urllib3/Makefile

# python-sqlalchemy
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.0.23/g' feeds/packages/lang/python/python-sqlalchemy/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=c1bda93cbbe4aa2aa0aa8655c5aeda505cd219ff3e8da91d1d329e143e4aff69/g' feeds/packages/lang/python/python-sqlalchemy/Makefile

# python-simplejson
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.19.1/g' feeds/packages/lang/python/python-simplejson/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=6277f60848a7d8319d27d2be767a7546bc965535b28070e310b3a9af90604a4c/g' feeds/packages/lang/python/python-simplejson/Makefile

# python-pyrsistent
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.19.3/g' feeds/packages/lang/python/python-pyrsistent/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=1a2994773706bbb4995c31a97bc94f1418314923bd1048c6d964837040376440/g' feeds/packages/lang/python/python-pyrsistent/Makefile

# python-pycparser
#rm -rf feeds/packages/lang/python/python-pycparser
#svn co https://github.com/openwrt/packages/trunk/lang/python/python-pycparser feeds/packages/lang/python/python-pycparser
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.21/g' feeds/packages/lang/python/python-pycparser/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python-pycparser/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206/g' feeds/packages/lang/python/python-pycparser/Makefile

# python-paramiko
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.1.0/g' feeds/packages/lang/python/python-paramiko/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=6950faca6819acd3219d4ae694a23c7a87ee38d084f70c1724b0c0dbb8b75769/g' feeds/packages/lang/python/python-paramiko/Makefile

# python-lxml
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.9.2/g' feeds/packages/lang/python/python-lxml/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=2455cfaeb7ac70338b3257f41e21f0724f4b5b0c0e7702da67ee6c3640835b67/g' feeds/packages/lang/python/python-lxml/Makefile

# python-idna
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.4/g' feeds/packages/lang/python/python-idna/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=814f528e8dead7d329833b91c5faa87d60bf71824cd12a7530b5526063d02cb4/g' feeds/packages/lang/python/python-idna/Makefile

# python-dns
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.2.1/g' feeds/packages/lang/python/python-dns/Makefile
sed -i 's/PYPI_SOURCE_EXT:=.*/PYPI_SOURCE_EXT:=tar.gz/g' feeds/packages/lang/python/python-dns/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=0f7569a4a6ff151958b64304071d370daa3243d15941a7beedf0c9fe5105603e/g' feeds/packages/lang/python/python-dns/Makefile

# python-certifi
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2023.7.22/g' feeds/packages/lang/python/python-certifi/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=539cc1d13202e33ca466e88b2807e29f4c13049d6d87031a3c110744495cb082/g' feeds/packages/lang/python/python-certifi/Makefile
#sed -i 's/DEPENDS:=.*/DEPENDS:=+python3-light +python3-urllib/g' feeds/packages/lang/python/python-certifi/Makefile

# bcrypt
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.2.2/g' feeds/packages/lang/python/bcrypt/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/bcrypt/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=433c410c2177057705da2a9f2cd01dd157493b2a7ac14c8593a16b3dab6b6bfb/g' feeds/packages/lang/python/bcrypt/Makefile

# python-dotenv
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.0.0/g' feeds/packages/lang/python/python-dotenv/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=a8df96034aae6d2d50a4ebe8216326c61c3eb64836776504fcca410e5937a3ba/g' feeds/packages/lang/python/python-dotenv/Makefile
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
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.30.0/g' feeds/packages/lang/python/python-requests/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/python/python-requests/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=239d7d4458afcb28a692cdd298d87542235f4ca8d36d03a15bfc128a6559a2f4/g' feeds/packages/lang/python/python-requests/Makefile

# host-pip-requirements
#sed -i 's/cffi==1.50.0 --hash=sha256:920f0d66a896c2d99f0adbb391f990a84091179542c205fa53ce5787aff87954/cffi==1.15.1 --hash=sha256:d400bfb9a37b1351253cb402671cea7e89bdecc294e8016a707f6d1d8ac934f9/g' feeds/packages/lang/python/host-pip-requirements/cffi.txt
#sed -i 's/pycparser==2.20 --hash=sha256:2d475327684562c3a96cc71adf7dc8c4f0565175cf86b6d7a404ff4c771f15f0/pycparser==2.21 --hash=sha256:e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206/g' feeds/packages/lang/python/host-pip-requirements/cffi.txt
#sed -i 's/Cython==0.29.21 --hash=sha256:e57acb89bd55943c8d8bf813763d20b9099cc7165c0f16b707631a7654be9cad/Cython==0.29.24 --hash=sha256:cdf04d07c3600860e8c2ebaad4e8f52ac3feb212453c1764a49ac08c827e8443/g' feeds/packages/lang/python/host-pip-requirements/Cython.txt
#sed -i 's/setuptools-scm==4.1.2 --hash=sha256:a8994582e716ec690f33fec70cca0f85bd23ec974e3f783233e4879090a7faa8/setuptools-scm==6.0.1 --hash=sha256:d1925a69cb07e9b29416a275b9fadb009a23c148ace905b2fb220649a6c18e92/g' feeds/packages/lang/python/host-pip-requirements/setuptools-scm.txt

# gzip
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.13/g' feeds/packages/utils/gzip/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/gzip/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=7454eb6935db17c6655576c2e1b0fabefd38b4d0936e0f87f48cd062ce91a057/g' feeds/packages/utils/gzip/Makefile

# libev
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.33/g' feeds/packages/libs/libev/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/libs/libev/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=507eb7b8d1015fbec5b935f34ebed15bf346bed04a11ab82b8eee848c4205aea/g' feeds/packages/libs/libev/Makefile

# zerotier
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.12.2/g' feeds/packages/net/zerotier/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=7c6512cfc208374ea9dc9931110e35f71800c34890e0f35991ea485aae66e31c/g' feeds/packages/net/zerotier/Makefile
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
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.93/g' feeds/packages/libs/nss/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=15f54bb72048eb105f8c0e936a04b899e74c3db9a19bbc1e00acee2af9476a8a/g' feeds/packages/libs/nss/Makefile

# nspr
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.33/g' feeds/packages/libs/nspr/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=b23ee315be0e50c2fb1aa374d17f2d2d9146a835b1a79c1918ea15d075a693d7/g' feeds/packages/libs/nspr/Makefile

# softethervpn5
#rm -rf feeds/packages/net/softethervpn5
#svn co https://github.com/openwrt/packages/trunk/net/softethervpn5 feeds/packages/net/softethervpn5

# hwdata
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.381/g' feeds/packages/utils/hwdata/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=53435c73964ddc24ac53fa86e29e8b9244ca1cab0578ffdd82fd280f35863004/g' feeds/packages/utils/hwdata/Makefile

# gawk
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.3.0/g' feeds/packages/utils/gawk/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=ca9c16d3d11d0ff8c69d79dc0b47267e1329a69b39b799895604ed447d3ca90b/g' feeds/packages/utils/gawk/Makefile

# ocserv
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2.4/g' feeds/packages/net/ocserv/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=d30f29c5967715f7b118e89bba496011b2be2af0f49bb9e332f12be7fbf693d7/g' feeds/packages/net/ocserv/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/ocserv/Makefile

# unrar
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=6.2.12/g' feeds/packages/utils/unrar/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=a008b5f949bca9bb4ffa1bebbfc8b3c14b89df10a10354809b845232d5f582e5/g' feeds/packages/utils/unrar/Makefile
rm -rf feeds/packages/utils/unrar
cp -rf $GITHUB_WORKSPACE/general/unrar feeds/packages/utils

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
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2.11/g' feeds/packages/sound/alsa-utils/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=9ac6ca3a883f151e568dcf979b8d2e5cbecc51b819bb0e6bb8a2e9b34cc428a7/g' feeds/packages/sound/alsa-utils/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/sound/alsa-utils/Makefile
#wget -P feeds/packages/sound/alsa-utils/patches https://raw.githubusercontent.com/immortalwrt/packages/master/sound/alsa-utils/patches/010-nhlt-dmic-info-c-include-sys-types-h.patch
#wget -P feeds/packages/sound/alsa-utils/patches https://raw.githubusercontent.com/immortalwrt/packages/master/sound/alsa-utils/patches/020-topology-include-locale-h.patch

# alsa-ucm-conf
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2.11/g' feeds/packages/libs/alsa-ucm-conf/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=387c01cf30e2a1676d7b8f72b2681cf219abca70dd1ec2a9e33add5bf3feae81/g' feeds/packages/libs/alsa-ucm-conf/Makefile

# alsa-lib
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2.11/g' feeds/packages/libs/alsa-lib/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=9f3f2f69b995f9ad37359072fbc69a3a88bfba081fc83e9be30e14662795bb4d/g' feeds/packages/libs/alsa-lib/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/libs/alsa-lib/Makefile
rm -rf feeds/packages/libs/alsa-lib
cp -rf $GITHUB_WORKSPACE/general/alsa-lib feeds/packages/libs

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
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.5.5/g' feeds/packages/utils/zstd/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=9c4396cc829cfae319a6e2615202e82aad41372073482fce286fac78646d3ee4/g' feeds/packages/utils/zstd/Makefile
sed -i 's/Dbacktrace=false/Dbacktrace=disabled/g' feeds/packages/utils/zstd/Makefile
#sed -i 's/Dbin_control=false/Dbin_contrib=false/g' feeds/packages/utils/zstd/Makefile
#sed -i '77i\	-Dmulti_thread=enabled \\' feeds/packages/utils/zstd/Makefile

# pigz
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.8/g' feeds/packages/utils/pigz/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=eb872b4f0e1f0ebe59c9f7bd8c506c4204893ba6a8492de31df416f0d5170fd0/g' feeds/packages/utils/pigz/Makefile
#rm -rf feeds/packages/utils/pigz/patches

# nano
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=7.2/g' feeds/packages/utils/nano/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=86f3442768bd2873cec693f83cdf80b4b444ad3cc14760b74361474fc87a4526/g' feeds/packages/utils/nano/Makefile
rm -rf feeds/packages/utils/nano
cp -rf $GITHUB_WORKSPACE/general/nano feeds/packages/utils

# dnsproxy
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.71.1/g' feeds/packages/net/dnsproxy/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=9c55c83ce3521c5197293a7618ed3ff103d236344aabf73ba37055e3964d2087/g' feeds/packages/net/dnsproxy/Makefile

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
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.3.2/g' feeds/packages/sound/shairport-sync/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=dfb485c0603398032a00e51f84b874749bbf155b257adda3d270d5989de08bfd/g' feeds/packages/sound/shairport-sync/Makefile
rm -rf feeds/packages/sound/shairport-sync
cp -rf $GITHUB_WORKSPACE/general/shairport-sync feeds/packages/sound/shairport-sync

# less
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=643/g' feeds/packages/utils/less/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=2911b5432c836fa084c8a2e68f6cd6312372c026a58faaa98862731c8b6052e8/g' feeds/packages/utils/less/Makefile

# minizip
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.0.4/g' feeds/packages/libs/minizip/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2ab219f651901a337a7d3c268128711b80330a99ea36bdc528c76b591a624c3c/g' feeds/packages/libs/minizip/Makefile
#sed -i 's/DMZ_COMPAT=OFF/DMZ_COMPAT=ON/g' feeds/packages/libs/minizip/Makefile

# libupnp
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.14.12/g' feeds/packages/libs/libupnp/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=091c80aada1e939c2294245c122be2f5e337cc932af7f7d40504751680b5b5ac/g' feeds/packages/libs/libupnp/Makefile

# file
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.43/g' feeds/packages/libs/file/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=8c8015e91ae0e8d0321d94c78239892ef9dbc70c4ade0008c0e95894abfb1991/g' feeds/packages/libs/file/Makefile
cp -f $GITHUB_WORKSPACE/general/file/Makefile feeds/packages/libs/file/Makefile

# aria2
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.37.0/g' feeds/packages/net/aria2/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/aria2/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=60a420ad7085eb616cb6e2bdf0a7206d68ff3d37fb5a956dc44242eb2f79b66b/g' feeds/packages/net/aria2/Makefile

# ariang
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.3.2/g' feeds/packages/net/ariang/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2186dacf57c9d1650e00084c0454f2227e910f3203d89c6190f547b40cac7243/g' feeds/packages/net/ariang/Makefile
cp -f $GITHUB_WORKSPACE/general/ariang/Makefile feeds/packages/net/ariang/Makefile

# nginx
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.21.4/g' feeds/packages/net/nginx/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/nginx/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=d1f72f474e71bcaaf465dcc7e6f7b6a4705e4b1ed95c581af31df697551f3bfe/g' feeds/packages/net/nginx/Makefile
rm -rf feeds/packages/net/nginx
cp -rf $GITHUB_WORKSPACE/general/nginx feeds/packages/net/nginx

# openssl
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.0.13/g' package/libs/openssl/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' package/libs/openssl/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=88525753f79d3bec27d2fa7c66aa0b92b3aa9498dafd93d7cfa4b3780cdae313/g' package/libs/openssl/Makefile

# 修改makefile
#find package/*/ -maxdepth 2 -path "*/Makefile" | xargs -i sed -i 's|include\ \.\.\/\.\.\/devel/meson/meson.mk|include \$(INCLUDE_DIR)\/meson.mk|g' {}

# smartdns
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2023.40/g' feeds/packages/net/smartdns/Makefile
#sed -i 's/PKG_SOURCE_VERSION:=.*/PKG_SOURCE_VERSION:=ee4816da5c66619c4210f7fda6245adf4c1c7ee8/g' feeds/packages/net/smartdns/Makefile
#sed -i 's/PKG_MIRROR_HASH:=.*/PKG_MIRROR_HASH:=fb4661291e79450f51a70f9b988c7452710acd1599529de48fef42c7dda0b29c/g' feeds/packages/net/smartdns/Makefile
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.2023.41/g' package/luci-app-smartdns/Makefile
cp -f $GITHUB_WORKSPACE/general/smartdns/Makefile feeds/packages/net/smartdns/Makefile

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
rm -rf feeds/packages/libs/icu
merge_package https://github.com/openwrt/packages packages/libs/icu
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
rm -rf package/naiveproxy
cp -rf $GITHUB_WORKSPACE/general/naiveproxy package/naiveproxy

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
rm -f feeds/packages/utils/coremark/coremark.sh
cp -f $GITHUB_WORKSPACE/general/coremark.sh feeds/packages/utils/coremark

# replace banner
cp -f $GITHUB_WORKSPACE/general/openwrt_banner package/base-files/files/etc/banner

# boost
rm -rf feeds/packages/libs/boost
cp -r $GITHUB_WORKSPACE/general/boost feeds/packages/libs

# wxbase
#rm -rf feeds/packages/libs/wxbase
#cp -r $GITHUB_WORKSPACE/general/wxbase feeds/packages/libs

# fix luci-theme-opentomcat dockerman icon missing
rm -f package/custom/luci-theme-opentomcat/files/htdocs/fonts/advancedtomato.woff
cp $GITHUB_WORKSPACE/general/advancedtomato.woff package/custom/luci-theme-opentomcat/files/htdocs/fonts
sed -i 's/e025/e02c/g' package/custom/luci-theme-opentomcat/files/htdocs/css/style.css
sed -i 's/66CC00/00b2ee/g' package/custom/luci-theme-opentomcat/files/htdocs/css/style.css

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
rm -rf feeds/packages/utils/coreutils
cp -r $GITHUB_WORKSPACE/general/coreutils feeds/packages/utils

# frp
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.56.0/g' feeds/packages/net/frp/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=084542bad79f9bed7fb18f31e7763589663e1dca243fe1c3d3dbfec45610ad5a/g' feeds/packages/net/frp/Makefile

# openconnect
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=8.20/g' feeds/packages/net/openconnect/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/openconnect/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=c1452384c6f796baee45d4e919ae1bfc281d6c88862e1f646a2cc513fc44e58b/g' feeds/packages/net/openconnect/Makefile
merge_package https://github.com/openwrt/packages packages/net/openconnect
rm -f feeds/packages/net/openconnect/patches/001-Use-OpenSSL_version-not-deprecated-SSLeay_version.patch

# xtables-addons
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.21/g' feeds/packages/net/xtables-addons/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/xtables-addons/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=2e09ac129a14f5e9c23b115ebcdfff4aa84e2aeba1268dbdf39b2d752bd71e19/g' feeds/packages/net/xtables-addons/Makefile

# libssh2
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.11.0/g' feeds/packages/libs/libssh2/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/libs/libssh2/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=3736161e41e2693324deb38c26cfdc3efe6209d634ba4258db1cecff6a5ad461/g' feeds/packages/libs/libssh2/Makefile

# gnutls
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.7.8/g' feeds/packages/libs/gnutls/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=c58ad39af0670efe6a8aee5e3a8b2331a1200418b64b7c51977fb396d4617114/g' feeds/packages/libs/gnutls/Makefile
#sed -i 's/libzstd/zstd/g' feeds/packages/libs/gnutls/Makefile
rm -rf feeds/packages/libs/gnutls
merge_package https://github.com/openwrt/packages packages/libs/gnutls

# smartmontools
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=7.4/g' feeds/packages/utils/smartmontools/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/smartmontools/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=e9a61f641ff96ca95319edfb17948cd297d0cd3342736b2c49c99d4716fb993d/g' feeds/packages/utils/smartmontools/Makefile

# libxml2
#cp -f $GITHUB_WORKSPACE/general/libxml2/Makefile feeds/packages/libs/libxml2

# sqlite3
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3410200/g' feeds/packages/libs/sqlite3/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=e98c100dd1da4e30fa460761dab7c0b91a50b785e167f8c57acc46514fae9499/g' feeds/packages/libs/sqlite3/Makefile
#sed -i 's|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=https://www.sqlite.org/2023/|g' feeds/packages/libs/sqlite3/Makefile
#sed -i '39d' feeds/packages/libs/sqlite3/Makefile
rm -rf feeds/packages/libs/sqlite3
cp -rf $GITHUB_WORKSPACE/general/sqlite3 feeds/packages/libs

# zoneinfo
cp -f $GITHUB_WORKSPACE/general/zoneinfo/Makefile feeds/packages/utils/zoneinfo

# adguardhome
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=0.107.5/g' feeds/packages/net/adguardhome/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=5282d58b1a8d52f02af4ab7a5d6089aba6f7d20929bd49fd844c930110262dcb/g' feeds/packages/net/adguardhome/Makefile

# iperf3
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.16/g' feeds/packages/net/iperf3/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=cc740c6bbea104398cc3e466befc515a25896ec85e44a662d5f4a767b9cf713e/g' feeds/packages/net/iperf3/Makefile

# verysync
#rm -rf feeds/packages/net/verysync
#svn co https://github.com/immortalwrt/packages/trunk/net/verysync feeds/packages/net/verysync

# haproxy
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.8.7/g' feeds/packages/net/haproxy/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/haproxy/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=0d1a61161789c8ec50662955deffba50ab4ebe7efc6c0d947ff570ee7098e7f8/g' feeds/packages/net/haproxy/Makefile
sed -i 's/BASE_TAG:=.*/BASE_TAG=v2.8.7/g' feeds/packages/net/haproxy/get-latest-patches.sh
sed -i 's|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=https://www.haproxy.org/download/2.8/src|g' feeds/packages/net/haproxy/Makefile

# perl
rm -rf feeds/packages/lang/perl
cp -rf $GITHUB_WORKSPACE/general/perl feeds/packages/lang

# zlib
rm -rf package/libs/zlib
merge_package https://github.com/openwrt/openwrt openwrt/package/libs/zlib
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.3/g' tools/zlib/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=8a9ba2898e1d0d774eca6ba5b4627a11e5588ba85c8851336eb38de4683050a7/g' tools/zlib/Makefile

# tailscale
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.38.1/g' feeds/packages/net/tailscale/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=395ba90c80ae0b5a6e3a25f19709ca83a6be015ed11efe4d73ef5d6d714d273d/g' feeds/packages/net/tailscale/Makefile
rm -rf feeds/packages/net/tailscale
cp -rf $GITHUB_WORKSPACE/general/tailscale feeds/packages/net/tailscale

# ruby
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.0.4/g' feeds/packages/lang/ruby/Makefile
#sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/lang/ruby/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=8e22fc7304520435522253210ed0aa9a50545f8f13c959fe01a05aea06bef2f0/g' feeds/packages/lang/ruby/Makefile
rm -rf feeds/packages/lang/ruby
merge_package https://github.com/openwrt/packages packages/lang/ruby

# libnetfilter-conntrack
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.0.9/g' package/libs/libnetfilter-conntrack/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=67bd9df49fe34e8b82144f6dfb93b320f384a8ea59727e92ff8d18b5f4b579a8/g' package/libs/libnetfilter-conntrack/Makefile
#cp -rf $GITHUB_WORKSPACE/general/libnetfilter-conntrack/patches package/libs/libnetfilter-conntrack

# util-linux
rm -rf package/utils/util-linux
cp -rf $GITHUB_WORKSPACE/general/util-linux package/utils

# lsof
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.95.0/g' feeds/packages/utils/lsof/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=e9faa0fbcc48638c1d1f143e93573ac43b65e76646150f83e24bd8c18786303c/g' feeds/packages/utils/lsof/Makefile
rm -rf feeds/packages/utils/lsof
#merge_package https://github.com/openwrt/packages packages/utils/lsof
cp -rf $GITHUB_WORKSPACE/general/lsof feeds/packages/utils

# iptables
#rm -rf package/network/utils/iptables
#cp -rf $GITHUB_WORKSPACE/general/iptables package/network/utils

# nghttp2
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.57.0/g' feeds/packages/libs/nghttp2/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=9210b0113109f43be526ac5835d58a701411821a4d39e155c40d67c40f47a958/g' feeds/packages/libs/nghttp2/Makefile

# libiconv-full
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.17/g' package/libs/libiconv-full/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=8f74213b56238c85a50a5329f77e06198771e70dd9a739779f4c02f65d971313/g' package/libs/libiconv-full/Makefile

# bind
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=9.18.26/g' feeds/packages/net/bind/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=75ffee52731e9604c849b658df29e927f1c4f01d5a71ea3ebcbeb63702cb6651/g' feeds/packages/net/bind/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/net/bind/Makefile

# libwebp
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.3.2/g' feeds/packages/libs/libwebp/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=2a499607df669e40258e53d0ade8035ba4ec0175244869d1025d460562aa09b4/g' feeds/packages/libs/libwebp/Makefile

# lighttpd
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.4.66/g' feeds/packages/net/lighttpd/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=47ac6e60271aa0196e65472d02d019556dc7c6d09df3b65df2c1ab6866348e3b/g' feeds/packages/net/lighttpd/Makefile

# xz
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=5.4.6/g' feeds/packages/utils/xz/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/xz/Makefile
#sed -i 's|PKG_SOURCE_URL:=.*|PKG_SOURCE_URL:=https://github.com/tukaani-project/xz/releases/download/v$(PKG_VERSION)|g' feeds/packages/utils/xz/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=913851b274e8e1d31781ec949f1c23e8dbcf0ecf6e73a2436dc21769dd3e6f49/g' feeds/packages/utils/xz/Makefile

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
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=3.3.0/g' feeds/packages/net/rsync/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=7399e9a6708c32d678a72a63219e96f23be0be2336e50fd1348498d07041df90/g' feeds/packages/net/rsync/Makefile

# python-jsonschema
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.17.3/g' feeds/packages/lang/python/python-jsonschema/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=0f864437ab8b6076ba6707453ef8f98a6a0d512a80e93f8abdb676f737ecb60d/g' feeds/packages/lang/python/python-jsonschema/Makefile

# ttyd
sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=1.7.3/g' feeds/packages/utils/ttyd/Makefile
sed -i 's/PKG_RELEASE:=.*/PKG_RELEASE:=1/g' feeds/packages/utils/ttyd/Makefile
sed -i 's/PKG_HASH:=.*/PKG_HASH:=c9cf5eece52d27c5d728000f11315d36cb400c6948d1964a34a7eae74b454099/g' feeds/packages/utils/ttyd/Makefile
rm -f feeds/packages/utils/ttyd/patches/090*.patch

# sed
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=4.8/g' tools/sed/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=f79b0cfea71b37a8eeec8490db6c5f7ae7719c35587f21edb0617f370eeff633/g' tools/sed/Makefile

# fullcone patch from lede(Non-public)
#mv -v package/network/config/firewall/patches/fullconenat.patch package/network/config/firewall/patches/100-fullconenat.patch
#cp -f $GITHUB_WORKSPACE/general/101-bcm-fullconenat.patch package/network/config/firewall/patches
#cp -f $GITHUB_WORKSPACE/general/900-bcm-fullconenat.patch package/network/utils/iptables/patches
#cp -f $GITHUB_WORKSPACE/general/982-add-bcm-fullconenat-support.patch target/linux/generic/hack-5.15

# libpfring
rm -rf feeds/packages/libs/libpfring
#merge_package https://github.com/openwrt/packages packages/libs/libpfring
cp -rf $GITHUB_WORKSPACE/general/libpfring feeds/packages/libs/libpfring

# alist
merge_package https://github.com/sbwml/luci-app-alist luci-app-alist/alist
merge_package https://github.com/sbwml/luci-app-alist luci-app-alist/luci-app-alist
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=b7d1929d9aef511b263673dba8e5b787f695e1b4fa4555fe562f8060ee0bdea4/g' package/alist/Makefile

# luajit2
merge_package https://github.com/openwrt/packages packages/lang/luajit2

# ymal
rm -rf feeds/packages/libs/yaml
merge_package https://github.com/openwrt/packages packages/libs/yaml

# v2raya
merge_package https://github.com/v2rayA/v2raya-openwrt v2raya-openwrt/v2raya
merge_package https://github.com/v2rayA/v2raya-openwrt v2raya-openwrt/luci-app-v2raya

# nqptp
merge_package https://github.com/openwrt/packages packages/net/nqptp

# libnghttp3
merge_package https://github.com/openwrt/packages packages/libs/nghttp3

# ngtcp2
merge_package https://github.com/openwrt/packages packages/libs/ngtcp2

# cryptsetup
#sed -i 's/PKG_VERSION:=.*/PKG_VERSION:=2.7.1/g' feeds/packages/utils/cryptsetup/Makefile
#sed -i 's|PKG_SOURCE_URL:=.*/PKG_SOURCE_URL:=@KERNEL/linux/utils/cryptsetup/v2.7|g' feeds/packages/utils/cryptsetup/Makefile
#sed -i 's/PKG_HASH:=.*/PKG_HASH:=da5d1419e2a86e01aa32fd79582cd54d208857cb541bca2fd426a5ff1aaabbc3/g' feeds/#packages/utils/cryptsetup/Makefile
#sed -i '21i\PKG_CPE_ID:=cpe:/a:cryptsetup_project:cryptsetup\' feeds/packages/utils/cryptsetup/Makefile
#sed -i '79i\TARGET_CFLAGS += -D_LARGEFILE64_SOURCE\' feeds/packages/utils/cryptsetup/Makefile
rm -rf feeds/packages/utils/cryptsetup
cp -rf $GITHUB_WORKSPACE/general/cryptsetup feeds/packages/utils

# inih
cp -rf $GITHUB_WORKSPACE/general/inih feeds/packages/libs

# xfsprogs
rm -rf feeds/packages/utils/xfsprogs
cp -rf $GITHUB_WORKSPACE/general/xfsprogs feeds/packages/utils

# shadowsocks-rust
cp -rf $GITHUB_WORKSPACE/general/shadowsocks-rust package/shadowsocks-rust

# 晶晨宝盒
sed -i "s|https.*/amlogic-s9xxx-openwrt|https://github.com/breakings/OpenWrt|g" package/custom/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|http.*/library|https://github.com/breakings/OpenWrt|g" package/custom/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic
sed -i "s|s9xxx_lede|ARMv8|g" package/custom/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic
#sed -i "s|.img.gz|..OPENWRT_SUFFIX|g" package/custom/luci-app-amlogic/luci-app-amlogic/root/etc/config/amlogic

# jq 
rm -rf feeds/packages/utils/jq
cp -rf $GITHUB_WORKSPACE/general/jq feeds/packages/utils

# sing-box
cp -rf $GITHUB_WORKSPACE/general/sing-box package/sing-box

# v2dta
sed -i '/CGO_ENABLED=0/{N;d;}' feeds/packages/utils/v2dat/Makefile

# dae
cp -rf $GITHUB_WORKSPACE/general/dae package/dae
cp -rf $GITHUB_WORKSPACE/general/luci-app-dae package/luci-app-dae

# dnsmasq
#rm -rf package/network/services/dnsmasq
#cp -rf $GITHUB_WORKSPACE/general/dnsmasq package/network/services

# Optimization level -Ofast
if [ "$platform" = "x86_64" ]; then
    curl -s https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/patch/target-modify_for_x86_64.patch | patch -p1
fi

# x86 - disable intel_pstate
sed -i 's/noinitrd/noinitrd intel_pstate=disable/g' target/linux/x86/image/grub-efi.cfg

# bash
if [ "$platform" = "x86_64" ]; then
sed -i 's#ash#bash#g' package/base-files/files/etc/passwd
fi
sed -i 's#\\u@\\h:\\w\\\$#\\[\\e[32;1m\\][\\u@\\h\\[\\e[0m\\] \\[\\033[01;34m\\]\\W\\[\\033[00m\\]\\[\\e[32;1m\\]]\\[\\e[0m\\]\\\$#g' package/base-files/files/etc/profile
mkdir -pv files/root
curl -so files/root/.bash_profile https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/files/root/.bash_profile
curl -so files/root/.bashrc https://raw.githubusercontent.com/sbwml/r4s_build_script/master/openwrt/files/root/.bashrc

# musl patch
cp -fv $GITHUB_WORKSPACE/PATCH/001-elf.h-add-typedefs-for-Elf-_Relr.patch toolchain/musl/patches

./scripts/feeds update -a
./scripts/feeds install -a

echo "========================="
echo " DIY2 配置完成……"
