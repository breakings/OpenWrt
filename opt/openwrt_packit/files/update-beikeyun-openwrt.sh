#!/bin/sh

# check cmd param
if [ "$1" == "" ];then
	echo "Usage: $0 xxx.img"
	exit 1
fi

# check image file
IMG_NAME=$1
if [ ! -f "$IMG_NAME" ];then
	echo "$IMG_NAME not exists!"
	exit 1
fi

# find boot partition 
BOOT_PART_MSG=$(lsblk -l -o NAME,PATH,TYPE,UUID,MOUNTPOINT | awk '$3~/^part$/ && $5 ~ /^\/boot$/ {print $0}')
if [ "${BOOT_PART_MSG}" == "" ];then
	echo "The boot partition is not exists or not mounted, so it cannot be upgraded with this script!"
	exit 1
fi

BR_FLAG=1
echo -ne "Do you want to backup old config files and restore to new system? y/n [y]\b\b"
read yn
case $yn in
    n*|N*) BR_FLAG=0;;
esac

BOOT_NAME=$(echo $BOOT_PART_MSG | awk '{print $1}')
BOOT_PATH=$(echo $BOOT_PART_MSG | awk '{print $2}')
BOOT_UUID=$(echo $BOOT_PART_MSG | awk '{print $4}')

# find root partition 
ROOT_PART_MSG=$(lsblk -l -o NAME,PATH,TYPE,UUID,MOUNTPOINT | awk '$3~/^part$/ && $5 ~ /^\/$/ {print $0}')
ROOT_NAME=$(echo $ROOT_PART_MSG | awk '{print $1}')
ROOT_PATH=$(echo $ROOT_PART_MSG | awk '{print $2}')
ROOT_UUID=$(echo $ROOT_PART_MSG | awk '{print $4}')
case $ROOT_NAME in 
  mmcblk0p2) NEW_ROOT_NAME=mmcblk0p3
	     NEW_ROOT_LABEL=EMMC_ROOTFS2
	     ;;
  mmcblk0p3) NEW_ROOT_NAME=mmcblk0p2
	     NEW_ROOT_LABEL=EMMC_ROOTFS1
	     ;;
          *) echo "The root partition location is invalid, so it cannot be upgraded with this script!"
             exit 1
             ;;
esac

# find new root partition
NEW_ROOT_PART_MSG=$(lsblk -l -o NAME,PATH,TYPE,UUID,MOUNTPOINT | grep "${NEW_ROOT_NAME}" | awk '$3 ~ /^part$/ && $5 !~ /^\/$/ && $5 !~ /^\/boot$/ {print $0}')
if [ "${NEW_ROOT_PART_MSG}" == "" ];then
	echo "The new root partition is not exists, so it cannot be upgraded with this script!"
	exit 1
fi
NEW_ROOT_NAME=$(echo $NEW_ROOT_PART_MSG | awk '{print $1}')
NEW_ROOT_PATH=$(echo $NEW_ROOT_PART_MSG | awk '{print $2}')
NEW_ROOT_UUID=$(echo $NEW_ROOT_PART_MSG | awk '{print $4}')
NEW_ROOT_MP=$(echo $NEW_ROOT_PART_MSG | awk '{print $5}')

# losetup
losetup -f -P $IMG_NAME
if [ $? -eq 0 ];then
	LOOP_DEV=$(losetup | grep "$IMG_NAME" | awk '{print $1}')
	if [ "$LOOP_DEV" == "" ];then
		echo "loop device not found!"
		exit 1
	fi
else
	echo "losetup $IMG_FILE failed!"
	exit 1
fi
WAIT=3
echo -n "The loopdev is $LOOP_DEV, wait ${WAIT} seconds "
while [ $WAIT -ge 1 ];do
	echo -n "."
	sleep 1
	WAIT=$(( WAIT - 1 ))
done
echo

# umount loop devices (openwrt will auto mount some partition)
MOUNTED_DEVS=$(lsblk -l -o NAME,PATH,MOUNTPOINT | grep "$LOOP_DEV" | awk '$3 !~ /^$/ {print $2}')
for dev in $MOUNTED_DEVS;do
	while : ;do
		echo -n "umount $dev ... "
		umount -f $dev
		sleep 1
		mnt=$(lsblk -l -o NAME,PATH,MOUNTPOINT | grep "$dev" | awk '$3 !~ /^$/ {print $2}')
		if [ "$mnt" == "" ];then
			echo "ok"
			break
		else 
			echo "try again ..."
		fi
	done
done

# mount src part
WORK_DIR=$PWD
P1=${WORK_DIR}/boot
P2=${WORK_DIR}/root
mkdir -p $P1 $P2
echo -n "mount ${LOOP_DEV}p1 -> ${P1} ... "
mount -t ext4 -o ro ${LOOP_DEV}p1 ${P1}
if [ $? -ne 0 ];then
	echo "mount failed"
	losetup -D
	exit 1
else 
	echo "ok"
fi	

echo -n "mount ${LOOP_DEV}p2 -> ${P2} ... "
mount -t btrfs -o ro,compress=zstd ${LOOP_DEV}p2 ${P2}
if [ $? -ne 0 ];then
	echo "mount failed"
	umount -f ${P1}
	losetup -D
	exit 1
else
	echo "ok"
fi	

#format NEW_ROOT
echo "umount ${NEW_ROOT_MP}"
umount -f "${NEW_ROOT_MP}"
if [ $? -ne 0 ];then
	echo "umount failed, please reboot and try again!"
	umount -f ${P1}
	umount -f ${P2}
	losetup -D
	exit 1
fi

echo "format ${NEW_ROOT_PATH}"
NEW_ROOT_UUID=$(uuidgen)
mkfs.btrfs -f -U ${NEW_ROOT_UUID} -L ${NEW_ROOT_LABEL} -m single ${NEW_ROOT_PATH}
if [ $? -ne 0 ];then
	echo "format ${NEW_ROOT_PATH} failed!"
	umount -f ${P1}
	umount -f ${P2}
	losetup -D
	exit 1
fi

echo "mount ${NEW_ROOT_PATH} to ${NEW_ROOT_MP}"
mount -t btrfs -o compress=zstd ${NEW_ROOT_PATH} ${NEW_ROOT_MP}
if [ $? -ne 0 ];then
	echo "mount ${NEW_ROOT_PATH} to ${NEW_ROOT_MP} failed!"
	umount -f ${P1}
	umount -f ${P2}
	losetup -D
	exit 1
fi

# begin copy rootfs
cd ${NEW_ROOT_MP}
echo "Now start copy data from ${P2} to ${NEW_ROOT_MP} ..."
ENTRYS=$(ls)
for entry in $ENTRYS;do
	if [ "$entry" == "lost+found" ];then
		continue
	fi
	echo -n "remove old $entry ... "
	rm -rf $entry 
	if [ $? -eq 0 ];then
		echo "ok"
	else
		echo "failed"
		exit 1
	fi
done
echo

echo -n "make dirs ... "
mkdir -p .reserved bin boot dev etc lib opt mnt overlay proc rom root run sbin sys tmp usr www
ln -sf lib/ lib64
ln -sf tmp/ var
echo "done"
echo

COPY_SRC="root etc bin sbin lib opt usr www"
echo "copy data ... "
for src in $COPY_SRC;do
	echo -n "copy $src ... "
        (cd ${P2} && tar cf - $src) | tar mxf -
        sync
        echo "done"
done
[ -d /mnt/mmcblk0p4/docker ] || mkdir -p /mnt/mmcblk0p4/docker
rm -rf opt/docker && ln -sf /mnt/mmcblk0p4/docker/ opt/docker

if [ -f /mnt/${NEW_ROOT_NAME}/etc/config/AdGuardHome ];then
	[ -d /mnt/mmcblk0p4/AdGuardHome/data ] || mkdir -p /mnt/mmcblk0p4/AdGuardHome/data
      	if [ ! -L /usr/bin/AdGuardHome ];then
		[ -d /usr/bin/AdGuardHome ] && \
		cp -a /usr/bin/AdGuardHome/* /mnt/mmcblk0p4/AdGuardHome/

	fi
	ln -sf /mnt/mmcblk0p4/AdGuardHome /mnt/${NEW_ROOT_NAME}/usr/bin/AdGuardHome
fi

sync
echo "copy done"
echo

BACKUP_LIST=$(${P2}/usr/sbin/flippy -p)
if [ $BR_FLAG -eq 1 ];then
    # restore old config files
    OLD_RELEASE=$(grep "DISTRIB_REVISION=" /etc/openwrt_release | awk -F "'" '{print $2}'|awk -F 'R' '{print $2}' | awk -F '.' '{printf("%02d%02d%02d\n", $1,$2,$3)}')
    NEW_RELEASE=$(grep "DISTRIB_REVISION=" ./etc/uci-defaults/99-default-settings | awk -F "'" '{print $2}'|awk -F 'R' '{print $2}' | awk -F '.' '{printf("%02d%02d%02d\n", $1,$2,$3)}')
    if [ ${OLD_RELEASE} -le 200311 ] && [ ${NEW_RELEASE} -ge 200319 ];then
	    mv ./etc/config/shadowsocksr ./etc/config/shadowsocksr.${NEW_RELEASE}
    fi
    mv ./etc/config/qbittorrent ./etc/config/qbittorrent.orig

    echo -n "Now restore your old config files ... "
    (
      cd /
      eval tar czf ${NEW_ROOT_MP}/.reserved/openwrt_config.tar.gz "${BACKUP_LIST}" 2>/dev/null
    )
    tar xzf ${NEW_ROOT_MP}/.reserved/openwrt_config.tar.gz
    if [ ${OLD_RELEASE} -le 200311 ] && [ ${NEW_RELEASE} -ge 200319 ];then
	    mv ./etc/config/shadowsocksr ./etc/config/shadowsocksr.${OLD_RELEASE}
	    mv ./etc/config/shadowsocksr.${NEW_RELEASE} ./etc/config/shadowsocksr
    fi
    if grep 'config qbittorrent' ./etc/config/qbittorrent; then
	rm -f ./etc/config/qbittorrent.orig
    else
	mv ./etc/config/qbittorrent.orig ./etc/config/qbittorrent
    fi
    sed -e "s/option wan_mode 'false'/option wan_mode 'true'/" -i ./etc/config/dockerman 2>/dev/null
    sed -e 's/config setting/config verysync/' -i ./etc/config/verysync
    sync
    echo "done"
    echo
fi

echo "Now modify config files ... "
if [ -x ./usr/sbin/balethirq.pl ];then
    if grep "balethirq.pl" "./etc/rc.local";then
	echo "balance irq is enabled"
    else
	echo "enable balance irq"
        sed -e "/exit/i\/usr/sbin/balethirq.pl" -i ./etc/rc.local
    fi
fi
rm -f "./etc/rc.local.orig" "./usr/bin/mk_newpart.sh" "./etc/part_size"
rm -rf "./opt/docker" && ln -sf "/mnt/mmcblk0p4/docker" "./opt/docker"
cat > ./etc/fstab <<EOF
UUID=${NEW_ROOT_UUID} / btrfs compress=zstd 0 1
UUID=${BOOT_UUID} /boot ext4 defaults 0 2
#tmpfs /tmp tmpfs defaults,nosuid 0 0
EOF

cat > ./etc/config/fstab <<EOF
config global
        option anon_swap '0'
        option anon_mount '1'
        option auto_swap '0'
        option auto_mount '1'
        option delay_root '5'
        option check_fs '0'

config mount
        option target '/overlay'
        option uuid '${NEW_ROOT_UUID}'
        option enabled '1'
        option enabled_fsck '1'
        option fstype 'btrfs'
        option options 'compress=zstd'

config mount
        option target '/boot'
        option uuid '${BOOT_UUID}'
        option enabled '1'
        option enabled_fsck '0'
        option fstype 'ext4'
                
EOF

# 2021.04.01添加
# 强制锁定fstab,防止用户擅自修改挂载点
chattr +ia ./etc/config/fstab

rm -f ./etc/bench.log
cat >> ./etc/crontabs/root << EOF
17 3 * * * /etc/coremark.sh
EOF

sed -e 's/ttyAMA0/ttyS2/' -i ./etc/inittab
sed -e 's/ttyS0/tty1/' -i ./etc/inittab
sss=$(date +%s)
ddd=$((sss/86400))
sed -e "s/:0:0:99999:7:::/:${ddd}:0:99999:7:::/" -i ./etc/shadow
if [ `grep "sshd:x:22:22" ./etc/passwd | wc -l` -eq 0 ];then
    echo "sshd:x:22:22:sshd:/var/run/sshd:/bin/false" >> ./etc/passwd
    echo "sshd:x:22:sshd" >> ./etc/group
    echo "sshd:x:${ddd}:0:99999:7:::" >> ./etc/shadow
fi

if [ $BR_FLAG -eq 1 ];then
    #cp ${P2}/etc/config/passwall_rule/chnroute ./etc/config/passwall_rule/ 2>/dev/null
    #cp ${P2}/etc/config/passwall_rule/gfwlist.conf ./etc/config/passwall_rule/ 2>/dev/null
    sync
    echo "done"
    echo
fi
eval tar czf .reserved/openwrt_config.tar.gz "${BACKUP_LIST}" 2>/dev/null

cd ${WORK_DIR}
 
echo "Now start copy data from ${P2} to /boot ..."
cd /boot
echo -n "remove old boot files ..."
rm -rf *
echo "done"
echo -n "copy new boot files ... " 
(cd ${P1} && tar cf - . ) | tar mxf -
sync
echo "done"
echo

echo -n "Now update boot args ... "
cat > armbianEnv.txt <<EOF
verbosity=7
overlay_prefix=rockchip
rootdev=${NEW_ROOT_PATH}
rootfstype=btrfs
rootflags=compress=zstd
extraargs=usbcore.autosuspend=-1
extraboardargs=
fdtfile=/dtb/rockchip/rk3328-beikeyun-1296mhz.dtb
EOF
sync
echo "done"
echo

cd $WORK_DIR
umount -f ${P1} ${P2}
losetup -D
rmdir ${P1} ${P2}
echo "Update done, please reboot!"
echo
