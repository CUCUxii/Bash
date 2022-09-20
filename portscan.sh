#!/bin/bash

function ctrl_c(){
	tput cnorm; exit 1
}

tput civis
ip=$1
trap ctrl_c INT


tempfile=$(pwd)/scan_tmp
touch $tempfile

echo -e "\n [*] Realizando el escaneo de puertos: \n"
for port in $(seq 1 10000); do
	timeout 1 bash -c "(echo "" > /dev/tcp/$ip/$port) 2>/dev/null" && echo "Port $port" | tee -a $tempfile & 
done; wait

tput cnorm

echo -e "\n [*] Lista final de puertos: \n"
cat $tempfile | awk '{print $2}' | sponge $tempfile
cat $tempfile | xargs | sed 's/ /,/g'

rm -rf $tempfile
