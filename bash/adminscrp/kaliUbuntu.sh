#!/usr/bin/bash

echo "[+] This script adds the kali rolling repository to your Deb system."
echo "[!] Note this script must be run with sudo privileges!"

kaliPack=$(apt list --installed 2> /dev/null | grep -Eo 'kali-tools' || apt list --installed 2> /dev/null | grep -Eo 'kali-linux-headless')
if [[ $(id -u) -ne 0 ]]; then
    echo "[!] You must be root or have root permissions to run this script."
    exit 1
#checks if script is run as root
elif [[ $(cat /etc/*-release | grep ID=kali | grep -o kali) == 'kali' && -z $kaliPack ]]; then
    echo "[?] Would you like to install several default Kali tools on your minimal installation?"
    select yn in "Yes" "No"; do
        case $yn in
            "Yes" ) 
                echo "[+] Installing......"
                apt install kali-linux-headless -y
                apt update -y
                apt install -f
                break
                ;;
            "No" )
                echo '[+] Okay! you can use this next time to add the kali tools to your minimal installation.'
                break
                ;;
        esac
    done
#The above if statement checks if the device is running kali and checks if the user has kali is installed 
#and checks if the user has any of the kali tools installed or the headless metapackage by seeing if the var is empty.
#If both are true the script assumes this is a kali minimal system. 
else
    echo "[?] Do you wish to install the kali repository onto this debian system?"
    select yn in "Yes" "No"; do
        case $yn in
            "Yes" )
                echo '[+] Adding Kali repository...'  
                echo 'deb https://http.kali.org/kali kali-rolling main non-free contrib' > /etc/apt/sources.list.d/kali.list 
                wget 'https://archive.kali.org/archive-key.asc'
                if apt-key add archive-key.asc; then
                    echo 'Package: *'>/etc/apt/preferences.d/kali.pref
                    echo 'Pin: release a=kali-rolling'>>/etc/apt/preferences.d/kali.pref
                    echo 'Pin-Priority: 50'>>/etc/apt/preferences.d/kali.pref
                    apt update -y
                    apt install -f
                    echo '[+] The repo was added successfully!'
                    echo '[+] you should run sudo apt update && sudo apt upgrade to ensure the package lists are properly updated'
                else 
                    echo '[-] Error: Failed to add the Kali repository key.'
                fi 
                break
                ;;
            "No" ) 
                echo '[+] Okay! you can use this next time to add the kali apt repository.'
                break
                ;;
        esac
    done
fi