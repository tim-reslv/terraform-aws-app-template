resource "aws_network_interface" "network_interfaces" {
  for_each = var.network_interfaces

  subnet_id         = data.aws_subnet.subnets[each.value.subnet_id_key].id
  description       = each.value.description
  private_ips       = each.value.private_ips
  ipv6_addresses    = each.value.ipv6_addresses
  security_groups   = matchkeys(local.security_group_ids, local.security_group_keys, each.value.security_groups_keys)
  source_dest_check = each.value.source_dest_check

  tags = merge(
    {
      Name        = each.key
      environment = each.value.environment
    },
    each.value.tags
  )
}
