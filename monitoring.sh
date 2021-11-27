#!/bin/bash
wall `printf "#Archeticture: %s %s  %s" "$(uname -s)" "$(hostname)" "$(uname -rvmo)"` \
$'\n#CPU pysical:' `lscpu | grep -m1 "CPU(s)" | tr -s ' ' | cut -d ' ' -f2` \
$'\n#vCPU : ' `nproc --all`  \
$'\n#Memory Usage :' `free | grep Mem | awk '{printf("%d/%dMB (%.2f%%)\n", $3/1000, $2/1000,$3/$2 * 100)}'` \
$'\n#Disk usage : ' `df -h | awk '$NF=="/"{printf("%d/%dGB (%d%%)",$2,$3,$5)}'` \
$'\n#Last boot : ' `who -b | tr -s ' ' | cut -d ' ' -f4,5` \
$'\n#LVM use : ' `lsblk | grep lvm | awk '{if ($6) {print "yes";exit;} else {print "no";exit;}}'` \
$'\n'`printf "#Connections TCP : %d ESTABLISHED" "$(sudo ufw status | grep -vw '(v6)' | grep ALLOW | wc -l)"` \
$'\n#User log: ' `who | cut -d ' ' -f1 | sort -u | wc -l` \
$'\n'`printf "#Network: IP %s (%s)\n" "$(ip route list | grep link | awk '{print $NF}')" "$(ip link | grep "link/ether" | tr -s ' ' | cut -d ' ' -f3)"` \
$'\n'`printf "#Sudo : %d cmd" "$(grep 'sudo ' /var/log/auth.log | wc -l)"`
