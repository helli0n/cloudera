#!/bin/sh


user="admin"
password="admin"
url="http://rundeck:4440/api/13/history?project=cluster-jobs&statFilter="
rdate=""
curl1="curl -s --header "X-Rundeck-Auth-Token:czIfT77GonQRM5tdtC4OmhkVTP8bEtCo" -H "Content-Type=application/json" $url"
    case $1 in
	cancel)
    	    status="cancel"
            rdate="&recentFilter=m"
        ;;
        fail)
            status="fail"
            rdate="&recentFilter=d"
        ;;
        fail)
            status="fail"
        ;;
        fail_d)
            status="fail"
            rdate="&recentFilter=1d"
        ;;
        fail_m)
            status="fail"
            rdate="&recentFilter=1m"
        ;;
        succeed)
    	    status="succeed"
        ;;
        fail_list)
            status="fail"
            rdate="&recentFilter=1m"
        ;;
        all)
             status=""
        ;;
        *)
#        echo "Don't have parameters"
        ;;
	esac

	
check=`$curl1$status$rdate | grep events | awk '{print $3}' | grep -Eo '[0-9]{1,4}'`
echo $check
