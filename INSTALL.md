Deploy cilium with docker-compose
==================================

# Preparations

1. etcd cluster, used as cilium network policy repository
    * etcd instance IP addresses
    * etcd secrets
1. a running k8s cluster
    * master nodes
    * worker nodes nodes

# Install

## 1. Master node

1. Clone repo

    ```shell
    $ git clone https://github.com/ctripcorp/cilium-compose.git
    $ cd cilium-compose
    ```

1. Create configmap and secrets for cilium-operator

    ```shell
    $ kubectl create -f configmap.yaml

    $ kubectl create secret generic -n kube-system cilium-etcd-secrets \
        --from-file=etcd-client-ca.crt=etcd-client-ca.crt \
        --from-file=etcd-client.key=etcd-client.key \
        --from-file=etcd-client.crt=etcd-client.crt
    ```

1. Create cilium-operator

    ```shell
    $ kubectl create -f cilium-operator.yaml
    ```

## 2. Worker node

1. Clone Repo

    ```shell
    $ git clone https://github.com/ctripcloud/cilium-compose.git
    $ cd cilium-compose
    ```

1. Annotate and label the node on K8S master

    Note that cicode should be in lower case:
    
    ```shell
    $ ./utils/master/bootstrap-node.sh <node_cicode> <PodCIDR>
    ```

1. Change Configurations

    ```shell
    # 1. Copy etcd (cilium kvstore) secret keys
    $ scp somehost:/somewhere/etcd-client-ca.crt ./mount/var/lib/etcd-secrets
    $ scp somehost:/somewhere/etcd-client.crt    ./mount/var/lib/etcd-secrets
    $ scp somehost:/somewhere/etcd-client.key    ./mount/var/lib/etcd-secrets
    
    # 2. Change etcd IP in etcd.config if needed
    $ vim ./mount/var/lib/etcd-secrets
    
    # 3. Change other settings
    $ ./utils/config-compose.sh <node_cicode> <NodeIP>
    ```

1. Install

    ```shell
    $ docker-compose up -d
    $ docker ps
    
    # check CNI plugin is correctly installed
    $ /opt/cni/bin/cilium-cni
    Cilium CNI plugin 1.6.0 5a7a1440d 2019-08-21T17:26:48+08:00 go version go1.12.8 linux/amd64
    ```

1. Check status

    ```shell
    # copy util scripts
    $ mv utils/cilium /usr/local/bin/
    $ mv utils/cilium-health /usr/local/bin/

    $ cilium status
    KVStore:                Ok   etcd: 3/3 connected, lease-ID=61d47207fb630f09, ... has-quorum=true: https://192.168.2.150:2379 - 3.2.24 (Leader); ...
    Kubernetes:             Ok   1.17+ (v1.17.6-2) [linux/amd64]
    Kubernetes APIs:        ["CustomResourceDefinition", "cilium/v2::CiliumClusterwideNetworkPolicy", ... "networking.k8s.io/v1::NetworkPolicy"]
    KubeProxyReplacement:   Partial   []
    Cilium:                 Ok        OK
    ...
    ```

## Un-install

```shell
$ docker-compose down
```
