#!/bin/bash -x

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
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"6"}}' | jq . > /etc/docker/daemon.json
systemctl restart docker && systemctl enable docker

TOKEN=$(curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: ${TOKEN}" -s http://169.254.169.254/latest/meta-data/local-ipv4)
PUBLIC_IP=$(curl -H "X-aws-ec2-metadata-token: ${TOKEN}" -s http://169.254.169.254/latest/meta-data/public-ipv4)
DEFAULT_ROLES="--etcd --controlplane"
K8S_ROLES=${RANCHER_ROLES:-$DEFAULT_ROLES}

sudo docker run -d --privileged --restart=unless-stopped --net=host -v /etc/kubernetes:/etc/kubernetes \
    -v /var/run:/var/run rancher/rancher-agent:${RANCHER_VERSION:-v2.6.0} \
    --server https://${RANCHER_URL} \
    --token ${RANCHER_TOKEN} \
    --address ${PUBLIC_IP} \
    --internal-address ${PRIVATE_IP} \
    ${K8S_ROLES}