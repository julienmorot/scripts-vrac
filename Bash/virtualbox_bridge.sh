#!/bin/bash
PATH="/usr/sbin:/sbin:/usr/bin:/bin:/usr/bin"
USER="julien"
BRIDGE="br0"
IFACE="eth0"
TAP0="tap0"
TAP1="tap1"
TAP2="tap2"
TAP3="tap3"
 
ifconfig $IFACE 0.0.0.0
brctl addbr $BRIDGE
brctl addif $BRIDGE $IFACE
dhclient $BRIDGE
modprobe tun
chmod 0666 /dev/net/tun

tunctl -t $TAP0 -u julien
ifconfig $TAP0 up
brctl addif $BRIDGE $TAP0

tunctl -t $TAP1 -u julien
ifconfig $TAP1 up
brctl addif $BRIDGE $TAP1

tunctl -t $TAP2 -u julien
ifconfig $TAP2 up
brctl addif $BRIDGE $TAP2

tunctl -t $TAP3 -u julien
ifconfig $TAP3 up
brctl addif $BRIDGE $TAP3

chmod 0666 /dev/net/tun

