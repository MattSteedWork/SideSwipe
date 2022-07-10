#!/bin/bash

echo -e "\e[32;1m#############################"
echo -e "\e[30;1m#=====  S  ++  S  ==========#"
echo -e "\e[31;1m#======  I  ++  W  =========#"
echo -e "\e[32;1m#=======  D  ++  I  ========#"
echo -e "\e[30;1m#========  E  ++  P  =======#"
echo -e "\e[31;1m#================  E  ======#"
echo -e "\e[32;1m#############################"
echo -e "\e[32;1m[+]\e[30;1mEnter Project Name..."
echo -n "[-]" 
read ProjectName
echo -e "\e[32;1m[+]\e[30;1mEnter IP Address..."
echo -n "[-]"
read IP
echo -e "\e[32;1m[+]\e[30;1mCreating Directories..."

mkdir $ProjectName
mkdir $ProjectName/Nmap-$IP
mkdir $ProjectName/Feroxbuster

echo -e "\e[32;1m[+]\e[30;1mRunning Quick Nmap Scan..."
nmap $IP -p- -Pn -o Quick.txt >/dev/null
sleep 1
echo -e "\e[32;1m[+]\e[30;1mChecking Output..."
if grep -Fq '445/tcp' Quick.txt; then
  echo -e "\n\e[32;1m[+]\e[30;1mGrabbing SMB Shares...\n";
  smbclient -L $IP
elif grep -Fq '80/tcp' Quick.txt; then
  echo -e "\e[32;1m[+] \e[31;1mPort 80 Open...\n";
  echo -e "\e[32;1m[+]\e[30;1mRunning FeroxBuster...\n"
  konsole --noclose -e feroxbuster --url http://$IP:80 -o $ProjectName/Feroxbuster/$ProjectName-Ferox-80.txt >/dev/null & 
  echo -e "\e[32;1m[+]\e[31;1mOutput Written to $ProjectName/Feroxbuster/$ProjectName-Ferox-80.txt\n";
fi
if grep -Fq '8080/tcp' Quick.txt; then
  echo -e "\e[32;1m[+] \e[31;1mPort 8080 Open...\n";
  echo -e "\e[32;1m[+]\e[30;1mRunning FeroxBuster...\n"
  konsole --noclose -e feroxbuster --url http://$IP:8080 -o $ProjectName/Feroxbuster/$ProjectName-Ferox-8080.txt >/dev/null & 
  echo -e "\e[32;1m[+]\e[31;1mOutput Written to $ProjectName/Feroxbuster/$ProjectName-Ferox-8080.txt\n";
else
  echo -e "\e[32;1m[+]\e[31;1mNo SMB/HTTP/HTTPS Here :("
fi
rm Quick.txt
echo -e "\e[32;1m[+]\e[30;1mRunning Full Namp Scan..."
echo -e "\e[32;1m[+]\e[30;1mOutput Written To \e[31;1m$ProjectName/Nmap-$IP/$IP-$ProjectName.txt"
nmap -T5 -sC -sV $IP -p- -Pn -oA $ProjectName/Nmap-$IP/$IP-$ProjectName.txt >/dev/null
echo -e "\e[32;1m[+]Finished..."
