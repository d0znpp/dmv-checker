#!/bin/bash
for office_id in `cat ca-offices`
  do curl -i -s -k  -X $'POST' \
    -H $'Host: www.dmv.ca.gov' -H $'Connection: close' -H $'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36' -H $'Origin: https://www.dmv.ca.gov' -H $'Content-Type: application/x-www-form-urlencoded' -H $'Content-Length: 163' \
    --data-binary $'mode=OfficeVisit&officeId='$office_id'&numberItems=1&taskRID=true&taskCID=true&firstName=AAAAA&lastName=BBBBB&telArea=323&telPrefix=111&telSuffix=4242&resetCheckFields=true' \
    $'https://www.dmv.ca.gov/wasapp/foa/findOfficeVisit.do' | grep -A 20 '<td data-title="Office">' | sed -n -e 5p -e 7p -e 16p | awk '{$1=$1};1' | sed 's/<.*>//'
  echo
done
