#!/bin/bash

# TO BE RUNNED ONLY ON MASTER NODE

sudo kubeadm init --pod-network-cidr 10.244.0.0/16 --apiserver-advertise-address=192.168.56.2

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"



vagrant ssh kubenode01 -c "sudo kubeadm join 192.168.56.2:6443 --token 5fhoc9.2xq6vaxdz5v3s9b1 --discovery-token-ca-cert-hash sha256:bbadc9ba48a61e793bb00ae8b1f55b347a92b8fe58dbbde84f1406b39d4b9555"
vagrant ssh kubenode02 -c "sudo kubeadm join 192.168.56.2:6443 --token 5fhoc9.2xq6vaxdz5v3s9b1 --discovery-token-ca-cert-hash sha256:bbadc9ba48a61e793bb00ae8b1f55b347a92b8fe58dbbde84f1406b39d4b9555"