#!/bin/sh


user="admin"
password="admin"
url="http://cloudera_url:7180/api/v10"
curl1="curl -s --user $user:$password $url"

if [ "$1" == "discovery" ]; then
check=`$curl1/clusters/cluster/services | jq ".items[].name" | sed 's/^/{"{#SERVICENAME}":/g'|awk '{print $0 "}"}'| tr '\n' ',' | sed 's/.$//'`
echo "{\"data\":[$check]}"

else 
health=`$curl1/clusters/cluster/services/$1 | python -c 'import sys, json; print json.load(sys.stdin)["healthSummary"]'`

    if [ "$health" == "GOOD" ]; then
    echo "1"
    else 
	if [ "$health" == "CONCERNING" ]; then
	echo "2"
	else
	if [ "$health" == "DISABLED" ]; then
	echo "3"
	else
	echo "0"
	fi
	fi
	
    fi
fi