#!/bin/bash

# Usage: nova_vm_stop_delete.sh <delete|stop>

act=$1
echo $act

if  [ "$act" = "delete" ]; then
   echo "Deleting VMs...."
else
   if [ "$act" = "stop" ]; then
      echo "Stoppiong VMs"
   else
      echo "No parameter is specified."
      echo "Please specify [stop] or [delete]"
      echo "e.g. bash nova_vm_stop_delete.sh stop"
      exit
   fi
fi


#!/bin/bash

# nova
export NOVA_USERNAME=admin  # Login User name
export NOVA_PROJECT_ID=scale  # Tenant name (Project name)
export NOVA_PASSWORD=nova   # Login password
export NOVA_HOST=controller01   #OpenStack Controller name or IP

# required params

network_name="1_scale"  # Specify the network name
flavor_name="m1.tiny"   # Specify Flavor name
image_name="Ubuntu12.04LTS"  # Specify Glance image name
creation_num=50   #number of VMs to be created
vm_name_prefix="Test_VM_"  # Pre-fix VM name for the auto-creation (sequential number is added after this value for each VM creation)

#--------------------------------------------------------
#--------------No need to alter below here --------------
#--------------------------------------------------------
# nova
export NOVA_API_KEY=$NOVA_PASSWORD
export NOVA_URL=http://$NOVA_HOST:5000/v2.0/
export NOVA_VERSION=1.1
export NOVA_REGION_NAME=RegionOne

# glance
export OS_AUTH_USER=${NOVA_USERNAME}
export OS_AUTH_KEY=${NOVA_PASSWORD}
export OS_AUTH_TENANT=${NOVA_PROJECT_ID}
export OS_AUTH_URL=${NOVA_URL}
export OS_AUTH_STRATEGY=keystone

i=1

while [ $i -le $creation_num ]
do
   task=`nova list | grep '| '$vm_name_prefix$i' ' | cut -d "|" -f 5 | cut -b 2-5`
   echo "Current task:"$task
   if [ "$task" = "None" ]; then
      uuid=`nova list | grep '| '$vm_name_prefix$i' ' | cut -b 3-38`
      nova $act $uuid
      echo "Executed. VM name: "$vm_name_prefix$i
      i=`expr $i + 1`
   else
      echo "waiting for existing tasks to be completed ..."
      if [ "$task" = "" ]; then
         echo "No VM named "$vm_name_prefix$i"was found. Skipping ..."
         i=`expr $i + 1`
      fi
      sleep 1
   fi
done

