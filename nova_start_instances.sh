#!/bin/bash
source /root/keystonerc_nohara
while :
do
   uuid=`nova list | grep "SHUTOFF" | cut -b 2-38 | sed -n -e 1p`
   if [ "$uuid" != "" ]; then
      echo $uuid' is detected as SHUTOFF'
      nova start $uuid
      sleep 3
      echo $uuid' is started'
   else
      echo 'Completed (no more instances to start)'
      exit
   fi
done