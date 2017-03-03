#!/bin/bash

#cronjob creation
mkdir -p /etc/periodic/${LOOK_TIME}min
sed -e "s/#lang#/${LOOK_TIME}/g"  /cron_subliminal_user

#for each user
while IFS='' read -r line || [[ -n "$line" ]]; do
    #echo "Text read from file: $line"
    IFS=':' read -r userName string <<< "$line"
    
	sed -e "s/#user#/$userName/g"  /cron_subliminal_user > /etc/periodic/${LOOK_TIME}min/cron_subliminal_$userName
    
done < "$1"

chmod -R +x /etc/periodic/
crontab -l | { cat; echo "*/${LOOK_TIME}     *       *       *       *       run-parts /etc/periodic/${LOOK_TIME}min"; } | crontab -

echo "done"

crond -f -d 8