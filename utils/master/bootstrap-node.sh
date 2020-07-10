#!/bin/bash
# Author: arthurchiao

if [ $# -ne 2 ]; then
    echo "Add label/taint/annotations to a new Cilium node"
    echo "Usage: $0 <host cicode> <PodCIDR>"
    exit 1
fi

NODE=$1
POD_CIDR=$2

echo "annotating PodCIDR $2 ..."
kubectl annotate node $NODE io.cilium.network.ipv4-pod-cidr=$POD_CIDR --overwrite

echo "add labels ..."
kubectl label node $NODE cloud.ctrip.com/cilium-agent-deployer=docker-compose --overwrite
kubectl label node $NODE cloud.ctrip.com/bgp-agent=bird --overwrite
kubectl label node $NODE cloud.ctrip.com/cni=cilium --overwrite

echo "add taint ..."
kubectl taint node $NODE cloud.ctrip.com/cni=cilium:NoSchedule

echo "done"
