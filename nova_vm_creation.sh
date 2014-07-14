#!/bin/bash

# nova
export NOVA_USERNAME=admin   #ログイン時のID
export NOVA_PROJECT_ID=scale  #テナント名
export NOVA_PASSWORD=nova   #ログイン時のパスワード
export NOVA_HOST=controller01   #OpenStackコントローラーの名前/IP

# required params

network_name="1_scale"  #接続するネットワーク名
flavor_name="m1.tiny"   #利用するフレーバー名
image_name="Ubuntu12.04LTS"  #利用するイメージ名
creation_num=50   #作成する数
vm_name_prefix="Test_VM_"  #作成する仮想マシンの名前のプレフィックス値(この値の後ろに数字がつきます)

#--------------------------------------------------------
#------------------以下、変更不要------------------------
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