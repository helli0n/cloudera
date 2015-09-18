#!/bin/sh


user="admin"
password="admin"
xml="/usr/local/bin/xml2"
url="http://rundeck:4440/api/13/execution/$1"
curl1="curl -s --header "X-Rundeck-Auth-Token:czIfT77GonQRM5tdtC4OmhkVTP8bEtCo" -H "Content-Type=application/json" $url"

check2=`$curl1$status$rdate | /usr/local/bin/xml2 | awk -F"=" '{print $2}'`
sudo echo $check2 > 111111

    case $2 in
	name)
        jname=`cat 111111 | awk '{print $14}'`
        echo $jname
        ;;
        id)
        ID=`cat 111111 | awk '{print $2}'`
        echo $ID
        ;;
     *)
     #        echo "Don't have parameters"
     ;;
   esac

