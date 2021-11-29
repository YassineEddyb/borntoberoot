#!/bin/bash
wall `printf "#Archeticture: %s" "$(uname -a)"` \
$'\n#CPU pysical:' `lscpu | grep -m1 "CPU(s)" | tr -s ' ' | cut -d ' ' -f2` \
$'\n#vCPU : ' `nproc --all`  \
$'\n#Memory Usage :' `free | grep Mem | awk '{printf("%d/%dMB (%.2f%%)\n", $3/1000, $2/1000,$3/$2 * 100)}'` \
$'\n#Disk usage : ' `df -h --total | grep total | awk '{printf("%d/%dGb (%d%%)", $2,$4,$5)}'` \
$'\n'`printf "#Cpu load : %.1f%%" "$(top -bn1 | grep "Cpu(s)" | tr -d ',ni' | awk '{printf("%.1f%%", 100 - $7)}')"` \
$'\n#Last boot : ' `who -b | tr -s ' ' | cut -d ' ' -f4,5` \
$'\n#LVM use : ' `lsblk | grep lvm | awk '{if ($6) {print "yes";exit;} else {print "no" ;exit;}}'` \
$'\n'`printf "#Connections TCP : %d ESTABLISHED" "$(cat /proc/net/tcp | grep : | wc -l)"` \
$'\n#User log: ' `who | cut -d ' ' -f1 | sort -u | wc -l` \
$'\n'`printf "#Network: IP %s (%s)\n" "$(ip route list | grep link | awk '{print $NF}')" "$(ip link | grep "link/ether" | tr -s ' ' | cut -d ' ' -f3)"` \
$'\n'`printf "#Sudo : %d cmd" "$(sudo cat /var/log/sudo/sudo.log| grep TSID | wc -l)"`
