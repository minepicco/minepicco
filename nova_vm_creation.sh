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

flv=`nova flavor-list | grep $flavor_name | cut -b 3-38`
img=`nova image-list | grep $image_name | cut -b 3-38`
nwk=`nova network-list | grep $network_name | cut -b 3-38`
i=0

while [ $i -ne $creation_num ]
do
    i=`expr $i + 1`
    nova boot --flavor $flv --image $img --nic net-id=$nwk $vm_name_prefix$i
    sleep 1
done
