#!/bin/bash

### Letting iptables see bridged traffic
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system


# Disable swap 
# for current session
sudo swapoff -a
# Persistent after reboots
sudo sed -i.bak '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

