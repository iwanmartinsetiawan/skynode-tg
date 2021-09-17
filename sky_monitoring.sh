#!/bin/bash
HOME_DIR="$PWD"
MSG_FILE="$HOME_DIR/monitoring_sky.msg"
SYSLOG_FILE="$HOME_DIR/sky.log"
DATE=$(date +"%d-%m-%Y")
echo -e "Monitoring SKY Node" > $MSG_FILE
echo -e "Date : " $DATE"\n" >> $MSG_FILE
PUB_KEY=("key_1" "key_2" "key_3" "key_4" "key_5" "key_6" "key_7" "key_8")
for list in "${PUB_KEY[@]}"
do
echo -e "pub_key: "$list >> $MSG_FILE

UPTIME=`curl -s 'http://ut.skywire.skycoin.com/uptimes' | jq -r ".[] | select(.key==\"$list\") | .percentage"`

echo -e "Uptime : "$UPTIME"\n" >> $MSG_FILE
done

# Send Notif Telegram
TOKEN=TOKEN_BOT
CHAT_ID=(ID_TELEGRAM) #ID_TELEGRAM diisi dengan id yang akan menerima notifnya.
MESSAGE=`cat $MSG_FILE`
URL="https://api.telegram.org/bot$TOKEN/sendMessage"

for ID in "${CHAT_ID[@]}"
do

        curl -s -X POST $URL -d chat_id=$ID -d text="$MESSAGE";

done
