Cilium-Compose
==================================

Deploy cilium with docker-compose.

> **WARNING**: This is NOT an out-of-the-box repositoty for deploying cilium
> with docker-compose.

We (Trip.com) internally use `docker-compose` and `salt` to deploy and maintain
our cilium stuffs in k8s clusters (both for on-premises baremetal k8s clusters
and self-maintained k8s clusters on public clouds).

This repo is a simplified version of our internal one, currently **only served
as a reference** to those who also would like to try this fashion.

# Documents

1. [Install](INSTALL.md)
