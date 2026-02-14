#!/bin/bash
clear
echo
    bottoken=$(sed -n '1p' /root/.bckupbot | awk '{print $1}')
    read -p "File ID   : " fileId
    read -p "File PATH : " filePath
    curl -Ss --request GET \
        --url "https://api.telegram.org/file/bot${bottoken}/${filePath}?file_id=${fileId}" >backup.zip

    echo -e "[ ${green}INFO${NC} ] • Restore Data..."
	read -rp "Password File: "  InputPass
	echo -e "[ ${green}INFO${NC} ] • Getting your data..."
	unzip -P $InputPass /root/backup.zip &> /dev/null
    echo -e "[ ${green}INFO${NC} ] • Starting to restore data..."
    rm -f /root/backup.zip &> /dev/null
	sleep 1
    cd /root/backup
	echo -e "[ ${green}INFO${NC} ] • Please Wait , Restoring In Process Now... "
	sleep 1
	cp passwd /etc/ &>/dev/null
	echo -e "[ ${green}INFO${NC} ] • Restoring passwd data..."
	sleep 1
	cp group /etc/ &>/dev/null
	echo -e "[ ${green}INFO${NC} ] • Restoring group data..."
	sleep 1
	cp shadow /etc/ &>/dev/null
	echo -e "[ ${green}INFO${NC} ] • Restoring shadow data..."
	sleep 1
	cp gshadow /etc/ &>/dev/null
	echo -e "[ ${green}INFO${NC} ] • Restoring gshadow data..."
	sleep 1
    cp -r LT /var/lib/ &>/dev/null
    cp -r xray /etc/ &>/dev/null
    cp -r html /var/www/ &>/dev/null
    rm -rf /root/backup
    rm -f backup.zip
    echo -e "[ ${green}INFO${NC} ] • Done Restore... "
    read -n 1 -s -r -p "Press any key to back on menu"
    menu
