#!/bin/bash

# IP='127.0.0.1'
REFLECTOR='/usr/bin/reflector --protocol https --latest 12 --sort rate --save /etc/pacman.d/mirrorlist --country'
COUNTRY=' Russian'

IP=$(curl ipinfo.io/ip)

GEOIP=$(geoiplookup $IP)

IFS=',' read -a SPLITTER <<< "$GEOIP"

if [ ${#SPLITTER[@]} -eq 1 ]; then
   eval "${REFLECTOR}${COUNTRY}"
else
   eval "${REFLECTOR}${SPLITTER[1]}" 
fi