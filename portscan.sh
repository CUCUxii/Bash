#!/bin/bash

function ctrl_c(){
	tput cnorm; exit 1
}

tput civis
ip=$1
trap ctrl_c INT

echo -e "\n [*] Realizando el escaneo de puertos: \n"
for port in $(seq 1 10000); do
	timeout 1 bash -c "(echo "" > /dev/tcp/$ip/$port) 2>/dev/null" && echo "Port $port: OPEN" &
done; waiti

tput cnorm
