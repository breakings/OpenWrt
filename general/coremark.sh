#!/bin/sh

GOV="/sys/devices/system/cpu/cpufreq/policy0/scaling_governor"
if [ -f "$GOV" ];then
    CURRENT_GOVERNOR=$(cat $GOV)
    GOV_FLAG=1
else
    GOV_FLAG=0
fi

LOG=/etc/bench.log
echo "<div><table>" > $LOG
trap "echo killed;test $GOV_FLAG -eq 1 && echo ${CURRENT_GOVERNOR} > ${GOV} 2>/dev/null;echo '</table></div>' >> $LOG;rm -f /tmp/*.score;exit" 1 2 3 9 15

test $GOV_FLAG -eq 1 && echo "performance" > ${GOV} 2>/dev/null

echo "testing coremark ... "
COREMARK=$(/bin/coremark | tail -n 1 | awk '{print $4}')
echo "CPU CoreMark : $COREMARK"
echo "<tr><td>CPU CoreMark</td><td>$COREMARK</td></tr>" >> $LOG

if [ -x /usr/bin/openssl ];then
    CORES=$(grep processor /proc/cpuinfo | wc -l)

    PROJS="aes-128-gcm aes-256-gcm chacha20-poly1305"
    for P in $PROJS;do
        echo "testing $P ..."
        /usr/bin/openssl speed -multi $CORES -evp $P 1>/tmp/${P}.score 2>/dev/null || echo "NA" >/tmp/${P}.score
        S=$(tail -n 1 /tmp/${P}.score | awk '{print $5}')
	echo "${P}(1K) : ${S}"
	echo "<tr><td>${P}(1K)</td><td>$S</td></tr>" >> $LOG
	rm -f /tmp/${P}.score
    done

fi

echo "</table></div>" >> $LOG

test $GOV_FLAG -eq 1 && echo "${CURRENT_GOVERNOR}" >${GOV} 2>/dev/null

if [ -f "$LOG" ]; then
        sed -i '/coremark/d' /etc/crontabs/root
        crontab /etc/crontabs/root
fi
