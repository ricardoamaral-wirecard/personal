#!/bin/bash
# Clean Order-API Cache 
# Moip by PagSeguro Insfrastructure Team

CMD=$(curl -s -I -o /dev/null -w "%{http_code}\n" https://rlamaral.com.brr)
URL="https://hooks.slack.com/services/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"
HOST=$(hostname -s)
CHANNEL="#global"
EMOJI=":information_source:"
OK=":white_check_mark:"
NOK=":x:"
USER="SHELLBOT"
HTTPCODE="200"

slack_message(){
    MSG=$1
    COLOR=$2
    curl -X POST --data-urlencode "payload={\"channel\": \"$CHANNEL\", \"username\": \"$USER\", \"icon_emoji\": \"$EMOJI\", \"attachments\":[{\"color\":\"$COLOR\", \"text\": \"$MSG\"}]}" $URL
}

slack_message_ok(){
    slack_message "$OK O Servidor $HOST Respondeu $CMD" "good"
}

slack_message_not_ok(){
    slack_message "$NOK Opps! O Servidor $HOST Respondeu $CMD e o esperado é $HTTPCODE" "danger"
}

if [ "$CMD" == "$HTTPCODE" ];
    then
        slack_message_ok
    else
        slack_message_not_ok
fi

# End Of Script