#!/bin/sh


user="admin"
password="admin"
url="http://cloudera_url:7180/api/v10"
curl1="curl -s --user $user:$password $url"
case $1 in 
    out)
    traff="bytes_transmit_rate_across_network_interfaces"
    type="1"
    ;;
    in)
    traff="bytes_receive_rate_across_network_interfaces"
    type="1"
    ;;
    read)
    traff="read_bytes_rate_across_disks"
    type="1"
    ;;
    write)
    traff="write_bytes_rate_across_disks"
    type="1"
    ;;
    hdfs_read)
    type="2"
    traff="bytes_read_rate_across_datanodes"
    ;;
    hdfs_write)
    type="2"
    traff="bytes_written_rate_across_datanodes"
    ;;
    cpu)
    type="3"
    
    ;;
    *)
    echo "Don't have parameters"
    type="0"
    ;;
    esac
#curl -s --user admin:admin http://cloudera.hdp:7180/api/v10/timeseries?query=select%20stats(bytes_transmit_rate_across_network_interfaces,total)%20where%20category%20=%20CLUSTER
    if [ "$type" == "1" ]; then
    health=`$curl1/timeseries?query=select%20stats\($traff,total\)%20where%20category%20=%20CLUSTER | jq ".items[].timeSeries[].data[].value" | tail -1 | awk -F"." '{print $1}'`
    echo $health
    else
    if [ "$type" == "2" ]; then
    health=`$curl1/timeseries?query=select%20stats\($traff,total\)WHERE%20entityName=\"hdfs\"%20AND%20category%20=%20SERVICE | jq ".items[].timeSeries[].data[].value" | tail -1 | awk -F"." '{print $1}'`
    echo $health
    else
    if [ "$type" == "3" ]; then
    health=`$curl1/timeseries?query=SELECT%20cpu_percent_across_hosts%20WHERE%20entityName%20=\"3\"%20AND%20category=CLUSTER | jq ".items[].timeSeries[].data[].value" | tail -1 | awk '{print substr($0,0,4)}'`
    echo $health
    else
    health=`$curl1/cm/version`
    echo $health
    fi
    fi
    fi
#$traff