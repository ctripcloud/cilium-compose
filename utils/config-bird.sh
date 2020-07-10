#!/bin/bash

if [ $# -ne 4 ]; then
    echo "Usage: $0 <hostip> <neighbor 1 ip> <neighbor 2 ip>"
    exit 1
fi

HOST_IP=$1
NEIGHBOR1_IP=$2
NEIGHBOR2_IP=$3
POD_CIDR=$4

sed -i "s/CHANGE_ME_HOST_IP/$HOST_IP/g" bird.conf
sed -i "s/CHANGE_ME_NEIGHBOR1_IP/$NEIGHBOR1_IP/g" bird.conf
sed -i "s/CHANGE_ME_NEIGHBOR2_IP/$NEIGHBOR2_IP/g" bird.conf
sed -i "s/CHANGE_ME_POD_CIDR/$POD_CIDR/g" bird.conf
