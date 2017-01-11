#!/bin/bash

WLAN=wlan1
CHANNEL5G="149"

echo "Setting $WLAN to channel $CHANNEL5G"
ifconfig $WLAN down
iw dev $WLAN set monitor otherbss fcsfail
iw reg set BO
ifconfig $WLAN up
iwconfig $WLAN channel $CHANNEL5G

./rx -b 8 -r 4 -f 1024 $WLAN | gst-launch-1.0 fdsrc ! h264parse !  rtph264pay ! udpsink host=127.0.0.1 port=5600
