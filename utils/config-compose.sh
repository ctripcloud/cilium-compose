#!/bin/bash
# Author: arthurchiao

if [ $# -ne 2 ]; then
    echo "Usage: $0 <hostname> <hostip>"
    exit 1
fi

K8S_NODE_NAME=$1
NODE_IP=$2

sed -i "s/CHANGE_ME_K8S_NODE_NAME/$K8S_NODE_NAME/g" docker-compose.yaml

sed -i "s/CHANGE_ME_NODE_IP/$NODE_IP/g" mount/config-map/prometheus-serve-addr
