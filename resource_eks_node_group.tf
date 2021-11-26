resource "aws_eks_node_group" "eks_node_groups" {
  for_each = var.eks_node_groups

  cluster_name    = aws_eks_cluster.eks_clusters[each.value.cluster_name_key].name
  node_group_name = each.value.node_group_name
  node_role_arn   = aws_iam_role.iam_roles[each.value.node_role_arn_key].arn
  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }
  subnet_ids = matchkeys(local.subnet_ids, local.subnet_keys, each.value.subnet_ids_keys)

  ami_type             = each.value.ami_type
  capacity_type        = each.value.capacity_type
  disk_size            = each.value.disk_size
  force_update_version = each.value.force_update_version
  instance_types       = each.value.instance_types
  labels               = each.value.labels
  dynamic "launch_template" {
    for_each = each.value.launch_template.name_key != null ? { "launch_template" = each.value } : {}

    content {
      id      = aws_launch_template.launch_templates[each.value.launch_template.name_key].id
      version = each.value.version == null ? aws_launch_template.launch_templates[each.value.launch_template.name_key].latest_version : each.value.version
    }
  }
  release_version = each.value.release_version
  dynamic "remote_access" {
    for_each = each.value.remote_access.ec2_ssh_key_key != null ? { "remote_access" = each.value } : {}

    content {
      ec2_ssh_key               = aws_key_pair.key_pairs[each.value.remote_access.ec2_ssh_key_key].key_name
      source_security_group_ids = matchkeys(local.security_group_ids, local.security_group_keys, each.value.remote_access.source_security_group_ids_keys)
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
}
