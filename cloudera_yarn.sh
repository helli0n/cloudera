#!/bin/sh


user="admin"
password="admin"
url="http://cloudera_url:7180/api/v10"
curl1="curl -s --user $user:$password $url"
    case $1 in
	cpu)
    	    traff="available_vcores"
            check=`$curl1/timeseries?query=SELECT%20steady_fair_share_vcores%20WHERE%20entityName%20=%20"yarn:root.default"%20AND%20category%20=%20YARN_POOL | jq ".items[].timeSeries[].data[].value" | tail -1`
        ;;
        cpu_used)
            traff="allocated_vcores_cumulative"
            type="1"
            check=`$curl1/timeseries?query=SELECT%20$traff%20where%20category=YARN_POOL%20and%20serviceName="yarn"%20and%20queueName=root | jq ".items[].timeSeries[].data[].value" | tail -1`
        ;;
        memory)
    	    check=`$curl1/timeseries?query=SELECT%20steady_fair_share_mb%20WHERE%20entityName%20=%20"yarn:root.default"%20AND%20category%20=%20YARN_POOL | jq ".items[].timeSeries[].data[].value" | tail -1`
        ;;
        memory_used)
             traff="allocated_memory_mb_cumulative"
             check=`$curl1/timeseries?query=SELECT%20$traff%20where%20category=YARN_POOL%20and%20serviceName="yarn"%20and%20queueName=root | jq ".items[].timeSeries[].data[].value" | tail -1`
        ;;
        *)
        echo "Don't have parameters"
        ;;
	esac
echo $check
