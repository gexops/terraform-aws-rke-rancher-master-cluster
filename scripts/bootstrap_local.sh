#!/bin/bash -x

RANCHER_VERSION=$1
RANCHER_URL=$2
RANCHER_TOKEN=$3
RANCHER_CA_CHECKSUM=$4

cat <<EOF > /etc/sysctl.d/90-kubelet.conf
vm.overcommit_memory = 1
vm.panic_on_oom = 0
kernel.panic = 10
kernel.panic_on_oops = 1
kernel.keys.root_maxkeys = 1000000
kernel.keys.root_maxbytes = 25000000
EOF

sysctl -p /etc/sysctl.d/90-kubelet.conf

curl -sL https://releases.rancher.com/install-docker/20.10.sh | sh
sudo usermod -aG docker ubuntu
