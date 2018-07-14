#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]
  then
    echo "Usage ./check-drivertest.sh 01 22 1980 Y5357456"
    exit 
fi
birthday="birthMonth=$1&birthDay=$2&birthYear=$3"
ldnumber=$4
for office_id in `cat ca-offices`
  do
    #--socks5 '127.0.0.1:9050' \
    curl -i -s -k  -X $'POST' \
    -H $'Host: www.dmv.ca.gov' -H $'Connection: close' -H $'Origin: https://www.dmv.ca.gov' -H $'Content-Type: application/x-www-form-urlencoded' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36' \
    --data-binary $'numberItems=1&mode=DriveTest&officeId='$office_id'&requestedTask=DT&firstName=AAAA&lastName=AAAA&dlNumber='$ldnumber'&'$birthday'&telArea=111&telPrefix=111&telSuffix=1111&resetCheckFields=true' \
    $'https://www.dmv.ca.gov/wasapp/foa/findDriveTest.do' | grep -A 20 '<td data-title="Office">' | sed -n -e 5p -e 7p -e 17p | awk '{$1=$1};1' | sed 's/<\/\?strong>//g'
  echo
  sleep $(($RANDOM % 10 + 1))
done
