#!/bin/bash

TAG=latest
if [ ! -z "$1" ];then
	TAG=$1
fi

TMPDIR=openwrt_rootfs
OUTDIR=dockerimgs/docker
IMG_NAME=baltimore/openwrt-aarch64

[ -d "$TMPDIR" ] && rm -rf "$TMPDIR"

mkdir -p "$TMPDIR"  && \
mkdir -p "$OUTDIR"  && \
gzip -dc openwrt-armvirt-64-default-rootfs.tar.gz | ( cd "$TMPDIR" && tar xf - ) && \
cp -f patches/rc.local "$TMPDIR/etc/" && \
cp -f patches/cpustat "$TMPDIR/usr/bin/" && chmod 755 "$TMPDIR/usr/bin/cpustat" && \
cp -f patches/getcpu "$TMPDIR/bin/" && chmod 755 "$TMPDIR/bin/getcpu" && \
cat patches/luci-admin-status-index-html.patch | (cd "$TMPDIR/usr/lib/lua/luci/view/admin_status/" && patch -p0) && \
rm -f "$TMPDIR/etc/bench.log" && \
sed -e 's/\/opt/\/etc/' -i "${TMPDIR}/etc/config/qbittorrent" && \
#sed -e "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" -i "${TMPDIR}/etc/ssh/sshd_config" && \
sss=$(date +%s) && \
ddd=$((sss/86400)) && \
sed -e "s/:0:0:99999:7:::/:${ddd}:0:99999:7:::/" -i "${TMPDIR}/etc/shadow" && \
#sed -e "s/root::/root:$1$NA6OM0Li$99nh752vw4oe7A.gkm2xk1:/" -i "${TMPDIR}/etc/shadow" && \
sed -i '/DISTRIB_REVISION/d' "${TMPDIR}/etc/openwrt_release" && \
echo "DISTRIB_REVISION='R21.9.18'" >> "${TMPDIR}/etc/openwrt_release" && \
sed -i '/DISTRIB_DESCRIPTION/d' "${TMPDIR}/etc/openwrt_release" && \
echo "DISTRIB_DESCRIPTION='OpenWrt'" >> "${TMPDIR}/etc/openwrt_release" && \
echo "17 3 * * * /etc/coremark.sh" >> "$TMPDIR/etc/crontabs/root" && \
rm -rf "$TMPDIR/lib/firmware/*" "$TMPDIR/lib/modules/*" && \
(cd "$TMPDIR" && tar cf ../openwrt-armvirt-64-default-rootfs.tar .) && \
rm -f DockerImg-OpenwrtArm64-${TAG}.gz && \
#docker build -t ${IMG_NAME}:${TAG} . && \
docker buildx build --no-cache --platform=linux/arm64 -o type=docker -t ${IMG_NAME}:${TAG} . && \
rm -f  openwrt-armvirt-64-default-rootfs.tar && \
rm -rf "$TMPDIR" && \
docker save ${IMG_NAME}:${TAG} | pigz -9 > $OUTDIR/docker-img-openwrt-aarch64-${TAG}.gz
