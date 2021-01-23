#!/bin/bash
echo "    _________   ____________  ____________________  __";
echo "   / ____/   | / ____/  _/ / /_  __/ ____/ ____/ / / /";
echo "  / /_  / /| |/ /    / // /   / / / __/ / /   / /_/ / ";
echo " / __/ / ___ / /____/ // /___/ / / /___/ /___/ __  /  ";
echo "/_/   /_/  |_\____/___/_____/_/ /_____/\____/_/ /_/   ";
echo " ";
echo "Autor: Eduardo Amaral - eduardo4maral@protonmail.com"
echo "You Tube : https://www.youtube.com/faciltech"
echo "github   : https://github.com/Amaroca"
echo "Facebook : https://www.facebook.com/faciltech123"
if [ -z "$1" ]
then
        echo "Modo de Uso: ./searchinfo.sh <IP> ou <dominio.com"
        echo "OBS: Necessita de Nmap - Gobuster - WhatWeb"
        exit 1
fi
mkdir $1
cd $1
printf "\n----- NMAP -----\n\n" > resultados

echo "Rodando Nmap..."
nmap -sS $1 | tail -n +5 | head -n -3 >> resultados

while read line
do
        if [[ $line == *open* ]] && [[ $line == *http* ]]
        then
                echo "Rodando Gobuster..."
                gobuster dir -e -u $1 -w /usr/share/wordlists/dirb/common.txt -qz > temp1

        echo "Rodando WhatWeb..."
        whatweb $1 -v > temp2
        fi
done < resultados

if [ -e temp1 ]
then
        printf "\n----- DIRS -----\n\n" >> resultados
        cat temp1 >> resultados
        rm temp1
fi

if [ -e temp2 ]
then
    printf "\n----- WEB -----\n\n" >> resultados
        cat temp2 >> resultados
        rm temp2
fi

cat resultados
