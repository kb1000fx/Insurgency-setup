#!/bin/bash

if [ `id -u` -eq 0 ];then
    echo -e "\033[33m WARNING: Please don't run this script while operating as the root user for the security risk! \033[0m"
    echo -e "\033[33m Press Ctrl+C to exit and change to a common user. Or press any key to continue.  \033[0m"
fi
echo "Updating package list..."
apt-get -y update
apt-get -y upgrade
if command -v steamcmd > /dev/null 2>&1;then
    echo "You have not installed SteamCMD"
    funInstallSteamCMD()
fi  
echo "Now you have installed SteamCMD, start to install Insurgency."
mkdir ~/SteamServer && cd ~/SteamServer
steamcmd +login anonymous +force_install_dir ./Insurgency2 +app_update 222880 +quit

function funInstallSteamCMD()
{
    echo "Installing SteamCMD manually..."
    echo "Installing required packages from repositories..."
    apt-get install lib32gcc1
    if [ "$?" -ne "0" ]; then
        echo -e "\033[31m ERROR: Cannot install required packages! \033[0m" 
        exit 1
    fi
    wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz --no-check-certificate
    tar zxvf steamcmd_linux.tar.gz
    chmod +x ./steamcmd.sh
    return 0
}


