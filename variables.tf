variable "aws_region" {
  default = "ap-east-1"
}

variable "vpcs" {
  type    = map(any)
  default = {}
}

variable "subnets" {
  type    = map(any)
  default = {}
}

variable "route_tables" {
  type    = map(any)
  default = {}
}

variable "route53_zones" {
  type    = map(any)
  default = {}
}

variable "random_passwords" {
  type    = map(any)
  default = {}
}

variable "tls_private_keys" {
  type    = map(any)
  default = {}
}

variable "key_pairs" {
  type    = map(any)
  default = {}
}

variable "template_files" {
  type    = map(any)
  default = {}
}

variable "iam_polices" {
  type    = map(any)
  default = {}
}

variable "iam_users" {
  type    = map(any)
  default = {}
}

variable "iam_roles" {
  type    = map(any)
  default = {}
}

variable "iam_policy_attachments" {
  type    = map(any)
  default = {}
}

variable "iam_instance_profiles" {
  type    = map(any)
  default = {}
}

variable "kms_keys" {
  type    = map(any)
  default = {}
}

variable "data_eips" {
  type    = map(any)
  default = {}
}

variable "eips" {
  type    = map(any)
  default = {}
}

variable "network_interfaces" {
  type    = map(any)
  default = {}
}

variable "common_security_groups" {
  type    = map(any)
  default = {}
}

variable "security_groups" {
  type    = map(any)
  default = {}
}

variable "ec2_instances" {
  type    = map(any)
  default = {}
}

variable "route53_records" {
  type    = map(any)
  default = {}
}

variable "routes" {
  type    = map(any)
  default = {}
}

variable "launch_templates" {
  type    = map(any)
  default = {}
}

variable "eks_clusters" {
  type    = map(any)
  default = {}
}

variable "eks_node_groups" {
  type    = map(any)
  default = {}
}

variable "ecr_repositories" {
  type    = map(any)
  default = {}
}

variable "ecr_repository_policies" {
  type    = map(any)
  default = {}
}

variable "s3_buckets" {
  type    = map(any)
  default = {}
}

variable "db_instances" {
  type    = map(any)
  default = {}
}
