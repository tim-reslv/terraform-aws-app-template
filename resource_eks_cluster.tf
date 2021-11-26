resource "aws_eks_cluster" "eks_clusters" {
  for_each = var.eks_clusters

  name     = each.value.name
  role_arn = aws_iam_role.iam_roles[each.value.role_arn_key].arn
  vpc_config {
    endpoint_private_access = each.value.vpc_config.endpoint_private_access
    endpoint_public_access  = each.value.vpc_config.endpoint_public_access
    public_access_cidrs     = each.value.vpc_config.public_access_cidrs
    security_group_ids      = matchkeys(local.security_group_ids, local.security_group_keys, each.value.vpc_config.security_groups_ids_keys)
    subnet_ids              = matchkeys(local.subnet_ids, local.subnet_keys, each.value.vpc_config.subnet_ids_keys)
  }
  enabled_cluster_log_types = each.value.enabled_cluster_log_types
  dynamic "encryption_config" {
    for_each = each.value.encryption_config.provider.key_arn_key != null ? { "encryption_config" = each.value } : {}

    content {
      provider {
        key_arn = aws_kms_key.kms_keys[each.value.encryption_config.provider.key_arn_key].arn
      }
      resources = each.value.encryption_config.resource
    }
  }
  dynamic "kubernetes_network_config" {
    for_each = each.value.kubernetes_network_config.service_ipv4_cidr != null ? { "kubernetes_network_config" = each.value } : {}

    content {
      service_ipv4_cidr = each.value.kubernetes_network_config.service_ipv4_cidr
    }
  }
  tags = merge(
    {
      Name        = each.key
      environment = each.value.environment
    },
    each.value.tags
  )
  version = each.value.version

  lifecycle {
    ignore_changes = [
      vpc_config[0].security_group_ids
    ]
  }
}
