#!/bin/bash

greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctlc(){
    echo -e "\n\n${redColour}[*] Exiting...\n${endColour}"
    tput cnorm
    exit 1
}

trap ctlc SIGINT
tput civis
declare -a ports=( $(seq 1 65535) )

function scan(){

    (timeout 1 bash -c "cat < /dev/null > /dev/tcp/$1/$2") 2>/dev/null

    if [ $? -eq 0 ]; then
        echo -e "\n${greenColour}[+] Puerto $2 abierto!${endColour}"
    fi

}

if [ $1 ]; then

    echo -e "\n${blueColour}Iniciando escaneo...${endColour}"
    for port in ${ports[@]}; do
        scan $1 $port &
    done
else
    echo -e "\n${yellowColour}[!] Usage: $0 <IP adress>${endColour}"
fi

wait
tput cnorm
