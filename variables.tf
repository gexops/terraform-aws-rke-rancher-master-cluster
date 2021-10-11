variable "namespace" {
  type        = string
  description = "Namespace, which could be your organization name or abbreviation"
}

variable "stage" {
  type        = string
  description = "Stage, e.g. 'prod', 'staging', 'dev'"
}

variable "name" {
  type        = string
  description = "Solution name"
}

variable "repo" {
  type        = string
  description = "Repo URL that is responsible for this resource"
}

variable "owner" {
  type        = string
  description = "Email address of owner"
}

variable "description" {
  type        = string
  description = "Short description of what/why this product exists"
}

variable "additional_tag_map" {
  type        = map(string)
  description = "Map of additional tags to apply to every taggable resource. If you don't want any use an empty map - '{}'"
}

variable "instance_type_a" {
  type        = string
  description = "Instance type to use for the cluster nodes in Node Group 1,3"
  default     = "t3a.large"
}

variable "instance_count_a" {
  type        = number
  description = "Number of cluster nodes in Node Group 1,3"
  default     = 1
}

variable "instance_type_b" {
  type        = string
  description = "Instance type to use for the cluster nodes in Node Group 2,4"
  default     = "t3a.medium"
}

variable "instance_count_b" {
  type        = number
  description = "Number of cluster nodes in Node Group 2,4"
  default     = 1
}


variable "vpc_id" {
  type        = string
  description = "ID of the VPC to deploy to"
}

variable "node_group_1_subnet_id" {
  type        = string
  description = "Subnet to deploy node group 1 to"
}

variable "node_group_2_subnet_id" {
  type        = string
  description = "Subnet to deploy node group 2 to"
}

variable "node_group_3_subnet_id" {
  type        = string
  description = "Subnet to deploy node group 3 to"
}

variable "node_group_4_subnet_id" {
  type        = string
  description = "Subnet to deploy node group 4 to"
}


variable "node_volume_size" {
  type        = string
  description = "Volume size of worker node disk in GB"
}

variable "node_volume_type" {
  type        = string
  description = "Volume Type"
  default     = "gp3" 
}

variable "ami_name" {
  type        = string
  description = "AMI to Use in Nodes"
  default     = "ubuntu/images/hvm-ssd/ubuntu-bionic-20.04-amd64-server-*"
}

variable "ami_owner" { 
  type        = string
  description = "AMI Owner. Default = Canonical"
  default     = "099720109477"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version to use. Must be supported by the version of the RKE provider you are using. See [https://github.com/rancher/terraform-provider-rke/releases](https://github.com/rancher/terraform-provider-rke/releases)"
}

variable "hosted_zone_id" {
  type        = string
  description = "ID of Route53 hosted zone to create records in"
}

variable "hosted_zone_domain_name" {
  type        = string
  description = "Domain name of the hosted zone to create records in"
}

variable "rancher_domain_endpoint" {
  type        = string
  description = "The FQDN that Rancher will be live at. https://'{rancher_domain_endpoint}"
}

variable "subdomain_rancher" {
  type        = string
  description = "[Deprecated] Rancher's endpoint will be '{subdomain_rancher}.{hosted_zone_domain_name}'. {subdomain_rancher} can be multi-layered e.g. 'rancher.foo.bar'"
  default     = null
}

variable "rancher_letsencrypt_email" {
  type        = string
  description = "Email address to use for Rancher's LetsEncrypt certificate"
}

variable "rancher_letsencrypt_environment" {
  type        = string
  description = "LetsEncrypt environment to use - Valid options: 'staging', 'production'"
}
