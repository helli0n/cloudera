#!/bin/sh


url="http://hbase_url:60010/jmx"
curl1="curl -s $url"
case $1 in
    ritOldestAge)
    ress=`$curl1 | grep ritOldestAge | awk '{print substr($3, 0, length($3)-1)}'`
    ;;
    ritCount)
    ress=`$curl1 | grep '\"ritCount\"' | awk '{print substr($3, 0, length($3)-1)}'`
    ;;
    ritCountOverThreshold)
    ress=`$curl1 | grep ritCountOverThreshold | awk '{print substr($3, 0, length($3)-1)}'`
    ;;
    *)
    echo "Don't have parameters"
    ;;
    esac
    echo $ress
    