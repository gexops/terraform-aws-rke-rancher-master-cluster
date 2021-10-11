locals {
  # rancher_fqdn = "${var.subdomain_rancher}.${var.hosted_zone_domain_name}"
  # Made this edit so that if the zone record is already the root - rancher.domain.com that is hosted, it will propogate properly.
  rancher_fqdn = var.rancher_domain_endpoint

  //  Most of these should eventually get moved to variables, but they are staying hard coded for now for simplicity.
  ssh_user           = "ubuntu"
  // node_group_1_count = 1
  // node_group_2_count = 1
  // node_group_3_count = 1
  // node_group_4_count = 1
  // node_group_1_ami   = "ami-05801d0a3c8e4c443" // Ubuntu Bionic 18.04
  // node_group_2_ami   = "ami-05801d0a3c8e4c443" // Ubuntu Bionic 18.04
  // node_group_3_ami   = "ami-05801d0a3c8e4c443" // Ubuntu Bionic 18.04
  instance_user_data = <<EOF
#cloud-config
runcmd:
  - apt-get update
  - apt-get install -y apt-transport-https jq software-properties-common curl
  - curl -sL https://raw.githubusercontent.com/gexops/terraform-aws-rke-rancher-master-cluster/main/scripts/bootstrap_local.sh | sh
  - usermod -G docker -a ubuntu
  - echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"6"}}' | jq . > /etc/docker/daemon.json
  - systemctl restart docker && systemctl enable docker
EOF
}

module "label" {
  source             = "git::https://github.com/cloudposse/terraform-null-label.git?ref=tags/0.17.0"
  namespace          = var.namespace
  stage              = var.stage
  name               = var.name
  additional_tag_map = var.additional_tag_map

  tags = {
    "Repo"        = "${var.repo}",
    "Owner"       = "${var.owner}",
    "Description" = "${var.description}"
  }
}
