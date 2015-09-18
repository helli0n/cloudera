#!/bin/sh


user="admin"
password="admin"
url="http://cloudera_url:7180/api/v10"
curl1="curl -s --user $user:$password $url"

if [ "$1" == "discovery" ]; then
check=(`$curl1/clusters/cluster/services/zookeeper/roles | jq ".items[].name"`)
for hid in "${check[@]}"
do
hname=`$curl1/timeseries?query=SELECT%20average_request_latency%20WHERE%20entityName%20=$hid%20AND%20category%20=%20ROLE | jq ".items[].timeSeries[].metadata.attributes.hostname" | sed 's/^/"{#HOSTNAME}":/g'|awk '{print $0 "},"}'| tr '\n' ',' | sed 's/.$//'`
all2=`echo $hid | sed 's/^/{"{#IDHOST}":/g'|awk '{print $0 ","}'| tr '\n' ',' | sed 's/.$//'`
all=($all2$hname)
check2=(${all[@]}${check2[@]})
done
arr=`echo -n "{\"data\":[${check2[@]}" | head -c -1`
echo $arr]}
else
if [ "$1" == "latency" ]; then
hname=`$curl1/timeseries?query=SELECT%20average_request_latency%20WHERE%20entityName%20=$2%20AND%20category%20=%20ROLE | jq ".items[].timeSeries[].data[].value" | tail -1 | awk -F"." '{print $1}'`
echo "$hname"
fi
fi