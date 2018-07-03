#!/bin/bash
$birthday='birthMonth=10&birthDay=21&birthYear=1900'
$ldnumber='Y5000000'
for office_id in `cat ca-offices`
  do curl -i -s -k  -X $'POST' \
    -H $'Host: www.dmv.ca.gov' -H $'Connection: close' -H $'Origin: https://www.dmv.ca.gov' -H $'Content-Type: application/x-www-form-urlencoded' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36' -H $'Content-Length: 209' \
    --data-binary $'numberItems=1&mode=DriveTest&officeId='$office_id'&requestedTask=DT&firstName=AAAA&lastName=AAAA&dlNumber='$ldnumber'&'$birthday'&telArea=111&telPrefix=111&telSuffix=1111&resetCheckFields=true' \
    $'https://www.dmv.ca.gov/wasapp/foa/findDriveTest.do' | grep -A 20 '<td data-title="Office">' | sed -n -e 5p -e 7p -e 17p | awk '{$1=$1};1' #| sed 's/<([a-z\/]+)>//'
  echo
done
