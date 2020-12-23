# Local Kubernetes cluster installation scripts

This is based on: https://github.com/kodekloudhub/certified-kubernetes-administrator-course

## Prerequisits: 
  - Vagrant installed
  - Virtualbox installed
  - Asume host is an ubuntu 20+


### Quick Start

From the host box, and located on the root forlder of this repository, where 'Vagrantfile' should be present. 

Execute the following:

```
$vagrant up
```

This will create 3 servers and may take about 10-15min: 
  - kubemaster
  - kubenode01
  - kubenode02

### Finally on kubemaster node
Once finished we need to execute the following commands to create the cluster:

On the kubmaster node:
```
# login to kubemaster
$ vagrant ssh kubemaster

# We are now in kubmaster node shell
$ sudo kubeadm init --pod-network-cidr 10.244.0.0/16 --apiserver-advertise-address=192.168.56.2

## IMPORTANT 
# Take note of the command needed to join nodes to the cluster, must be runned as root.
#
# It will look like:
# 
#    kubeadm join 192.168.56.2:6443 --token 5fhoc9.2xq6vaxdz5v3s9b1 \
#        --discovery-token-ca-cert-hash sha256:bbadc9ba48a61e793bb00ae8b1f55b347a92b8fe58dbbde84f1406b39d4b9555
 
# This is to set the default kubectl credentials 
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Install Weave Net onto our CNI-enabled Kubernetes cluster with this command:
$ kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"

```

### Finally on kubenode*
Now on each node we would like to join the cluster we should run the command we captured in the previouse step.

```
# From our host box
$ vagrant ssh kubenode01 -c " ... here we should add the join command ... "
$ vagrant ssh kubenode02 -c " ... here we should add the join command ... "
...
```

# The End