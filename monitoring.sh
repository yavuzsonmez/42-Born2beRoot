#!/bin/bash

# Architecture of operating system and kernel version

echo "_________________________________________________________________________"

echo "# Architecture		:	$(uname -a)"

echo "_________________________________________________________________________"

# Number of physical CPU

echo "# CPU physical		:	$(nproc)"

echo "_________________________________________________________________________"

# Number of virtual CPU:

echo "# vCPU			:	$(cat /proc/cpuinfo | grep processor | wc -l)"

echo "_________________________________________________________________________"

# Available RAM and use rate as %

echo "# RAM usage		:	$(free -m | sed -n 2p | awk '{print $3 }')/$(free -m | sed -n 2p | awk '{print $2 }')MB ($(free -m | awk 'NR == 2 {printf $3/$2*100}')%)"

echo "_________________________________________________________________________"

# Available memory and use rate as %

echo "# Disk usage		:	$(df -h --total | sed -n 15p | awk '{print $3}')/$(df -h --total | sed -n 15p | awk '{print $2}')b ($(df -h --total | sed -n 15p | awk '{print $5}'))"

echo "_________________________________________________________________________"
# Use rate of CPU as %

echo "# CPU load		:	$(grep 'cpu' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')"

echo "_________________________________________________________________________"

# Date and time of last reboot

echo "# Last boot		:	$(who -b | awk '{print $3}') $(who -b | awk '{print $4}')"

echo "_________________________________________________________________________"
# Whether LVM is active or not

if [ $(lsblk | grep LVM | wc -l) -gt 0 ]
then
	echo "# LVM use		:	yes"
else
	echo "# LVM use		:	no"
fi

echo "_________________________________________________________________________"

# Number of acive connections

echo "# Connexions TCP	:	$(cat /proc/net/sockstat | grep TCP | awk '{print $3}') ESTABLISHED"

echo "_________________________________________________________________________"

# Number of users using the server

echo "# User log		:	$(who | wc -l)"

echo "_________________________________________________________________________"

# IPv4 address of the server and its MAC address

echo "# Network IP		:	$(hostname -I) ($(ifconfig -a | grep ether | awk '{print $2}'))"

echo "_________________________________________________________________________"

# Number of command executed with "sudo"

echo "# Sudo			:	$(sudo grep sudo /var/log/auth.log | grep COMMAND= | wc -l) cmd executed"

echo "_________________________________________________________________________"
