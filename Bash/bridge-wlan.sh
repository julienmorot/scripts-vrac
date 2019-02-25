#!/bin/bash
PATH="/usr/sbin:/sbin:/usr/bin:/bin:/usr/bin"
USER="julien"
BRIDGE="br0"
IFACE="wlan0"
TAPLIST="tap0 tap1"
 
ifconfig $IFACE 0.0.0.0
brctl addbr $BRIDGE
brctl addif $BRIDGE $IFACE
dhcpcd $BRIDGE
modprobe tun
chmod 0666 /dev/net/tun

for i in $TAPLIST
do
    tunctl -t $i -u julien
    ifconfig $i up
    brctl addif $BRIDGE $i
done

chmod 0666 /dev/net/tun

