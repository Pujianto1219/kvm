#!/bin/bash
-----BEGIN PGP MESSAGE-----
 Version: AutoDecrypt v1.0
 Creator: MhmmdRzkii/Lynzvpn
 Encrypted By: @botzlynz_BOT
 Email: ikkynotmee@gmail.com
 Comment: bot Support Decrypt bzip2 gzip lzma zstd shc bash gnupg dan openssl
-----END PGP MESSAGE-----

BlueCyan='\e[5;36m'
Xark='\e[0m'
ungu='\033[0;35m'
yellow='\e[33m'
WhiteBe='\e[5;37m'
GreenBe='\e[5;32m'
BlueCyan='\e[5;36m'
Xark='\e[0m'
clear
function baris_panjang() {
  echo -e "${BlueCyan} ——————————————————————————— ${Xark} "
}


function osx_ubuntu() {
  baris_panjang
  echo -e "${ungu}           Pilih Os Ubuntu      ${Xark} "
  baris_panjang
  echo -e "${ungu}"
  echo " 1. Ubuntu Versi 20.04 "
  echo " 2. Ubuntu Versi 22.04 "
  echo " 2. Ubuntu Versi 24.04 "
  echo " 2. Ubuntu Versi 24.10 "
  echo -e "${Xark}"
  echo -e "${yellow} x. Exit ${Xark}"
  baris_panjang
  read -p "Select [1/4 or x] :  " Xw
case $Xw in
1) clear ; ub20.04 ;;
2) clear ; ub22.04 ;;
3) clear ; ub24.04 ;;
4) clear ; ub24.10 ;;
*) exit ;;
esac

}

#PILIHAN OS UBUNTU
function ub20.04() {
  curl -O https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh && bash reinstall.sh Ubuntu 20.04 && reboot
}

function ub22.04() {
  curl -O https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh && bash reinstall.sh Ubuntu 22.04 && reboot
}

function ub24.04() {
  curl -O https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh && bash reinstall.sh Ubuntu 24.04 && reboot
}

function ub24.10() {
  curl -O https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh && bash reinstall.sh Ubuntu 24.10 && reboot
}

function osx_debian() {
  baris_panjang
  echo -e "${ungu}           Pilih Os Debian      ${Xark} "
  baris_panjang
  echo -e "${ungu}"
  echo " 1. Debian Versi 11 "
  echo " 2. Debian Versi 12 "
  echo -e "${Xark}"
  echo -e "${yellow} x. Exit ${Xark}"
  baris_panjang
  read -p "Select [1/2 or x] :  " Xw
case $Xw in
1) clear ; deb11 ;;
2) clear ; deb12 ;;
*) exit ;;
esac

}
#PILIHAN OS DEBIAN
function deb11() {
  curl -O https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh && bash reinstall.sh Debian 11 && reboot
}

function deb12() {
  curl -O https://raw.githubusercontent.com/bin456789/reinstall/main/reinstall.sh && bash reinstall.sh Debian 12 && reboot
}

function Banner() {
  baris_panjang
  echo -e "${ungu}           Rebuild VPS      ${Xark} "
  baris_panjang
}


function Menu_Features() {
  baris_panjang
  echo -e "${ungu}"
  echo " 1. Rebuild Vps Ubuntu  "
  echo " 2. Rebuild Vps Debian "
  echo -e "${Xark}"
  echo -e "${yellow} x. Exit ${Xark}"
  baris_panjang
}

Banner
Menu_Features
read -p "Select [1/4 or x] :  " Ltt
case $Ltt in
1) clear ; osx_ubuntu ;;
2) clear ; osx_debian ;;
*) exit ;;
esac
