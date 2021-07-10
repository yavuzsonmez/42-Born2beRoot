# Born2beRoot
___

## Table of contents :
- [Born2beRoot](#born2beroot)
	- [Table of contents :](#table-of-contents-)
	- [About :](#about-)
	- [VM Settings :](#vm-settings-)
	- [Installation and Partitioning :](#installation-and-partitioning-)
	- [UFW :](#ufw-)
	- [SUDO :](#sudo-)
	- [PASSWORD POLICY :](#password-policy-)
	- [MONITORING SCRIPT :](#monitoring-script-)
		- [How to connect to guest machine with SSH](#how-to-connect-to-guest-machine-with-ssh)
			- [First Method : Port Forwarding (NAT mode)](#first-method--port-forwarding-nat-mode)
			- [Second Method : Swap NAT to Bridged Adapter](#second-method--swap-nat-to-bridged-adapter)



## About :
Born2beRoot is an introduction to virtualization and system administration. The purpose here is to create a virtual machine which is a server, with the LST version of Debian, implementing strict rules, and minimum required services.

```
Hypervisor : Virtual Box
```
```
OS : Debian 10.XX
```


## VM Settings :
```
Linux
Debian 64-bit
1 Gb
Create VDF
VDI
Dynamically allocated
8 Gb
Debian-10-x-x-amd64-netinst.iso
```

## Installation and Partitioning :
```
Install (Without Graphic user interface)

Choose language

Territory or area: Europe

Hostname: yourintralogin42

Domain name:

Setup root passwd user's login and passwd

Time zone
```
```
Partition method :
Manual, SCSIX (0,0,0((sda)), 8.6 GB, Yes, Pri/log 8.6 GB FREE SPACE, Create a new partition (CRANP next), 500 M, Primary, Beginning,
Mount point, Boot, Done setting up the partition, pri/log, CRANP, 8.1GB, Logical, mount point, do not mount it, Done setting up the partition,
Configure encrypted volumes, Yes, Create encrypted volumes, /dev/sda5, Done setting up the partition, Finish, yes
```

```
Enter encryption passphrase twice,
Configure the Logical Volume Manager,
yes,
Create volume groupe,
LVMGroup,
press pace on /dev/mapper/sda5_crypt,
continue,
Create logical volume(CLV next),
LVMGroup (LVMG next),
root,
2G,
CLV >> LVMG >> swap >> 1G
CLV >> LVMG >> home >> 1G
CLV >> LVMG >> var >> 1G
CLV >> LVMG >> srv >> 1G
CLV >> LVMG >> tmp >> 1G
CLV >> LVMG >> var-log >> all disk space that left
Finish
```

```
#1 998.2 MB
Use as (UA next): >> EXT4 JFL
Mount point: (MP next) >> /home
Done setting up the partition
root #1 >> UA >> ext4 >> MU >> / - the root fs >> Done setting up the partition
srv #1 >> UA >> ext4 >> MU >> /srv >> Done setting up the partition
swap #1 >> UA >> swap area >> Done setting up the partition
tmp #1 >> UA >> ext4 >> MU >> /tmp >> Done setting up the partition
var #1 >> UA >> ext4 >> MU >> /var >> Done setting up the partition
var-log #1 >> UA >> ext4 >> MU >> Enter manually >> /var/log >> Done setting up the partition
Scroll below >> Finish partitioning and write changes to disk >> yes
```

```
Scan another.. ? >> no
Debian archive mirror country >> Your country
deb.debian.org
leave empty proxy field
Software seclection: remove all
GRUB - yes >> /dev/sda
continue
```

## UFW :

> UFW is a simple command line based firewall.
By default, all upcoming connections are blocked by ufw so, you have to allow ports on which you want to run service, 4242 here for SSH

Install UFW
```
sudo apt install ufw
```
Enable UFW
```
sudo ufw enable
```
Some useful command
```
ufw allow PORT
ufw deny PORT
ufw delete allow PORT
(exemple : "ufw allow 4242")
```
See if ufw is active and which port are allowed
```
sudo ufw status
```

## SUDO :

## PASSWORD POLICY :

## MONITORING SCRIPT :

Check monitoring.sh

crontab file who contains rules for cron daemon. This is a task scheduler ("run this command at this time on this date"). This way we can run automatically our monitoring script.

Install cron :
```
apt-get cron
```
Edit cron in order to run script as root
```
sudo crontab -e
```
To write in the crontab file, schedule the script for every 10 minutes
```
*/10 * * * * /home/my_path/monitoring.sh
```

### How to connect to guest machine with SSH

#### First Method : Port Forwarding (NAT mode)
```
Network settings, Advanced, Port Forwarding, Add rule to forward 4242 port from guest machine to host machine.
```
```
Connect from terminal (SSH -p4242 login@10.0.2.15)
```

#### Second Method : Swap NAT to Bridged Adapter

```
Swap NAT to Bridged Adapter in Network settings
```
```
Get ip addr with "hostname -I"
```
```
Connect from terminal (SSH -p4242 login@ip_addr)
```
