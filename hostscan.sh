#!/bin/bash

function ctrl_c(){ 
	exit 1 
}

trap ctrl_c INT

for ip in $(seq 1 256); do
	timeout 1 bash -c "ping -c 1 192.168.1.$ip 2>/dev/null 1>&2" && echo "[!] Host 192.168.1.$ip: ACTIVO" &
done; wait
