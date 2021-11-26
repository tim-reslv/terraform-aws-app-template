resource "aws_eip_association" "eip_associations" {
  for_each = {
    for association_key, association_value in merge(var.eips, var.data_eips) : association_key => association_value
    if association_value.network_interface_id_key != null
  }

  allocation_id        = matchkeys(local.eip_ids, local.eip_keys, [each.key])[0]
  allow_reassociation  = each.value.allow_reassociation
  instance_id          = each.value.instance_id_key != null ? aws_instance.instances[each.value.instance_id_key].id : null
  network_interface_id = each.value.network_interface_id_key != null ? aws_network_interface.network_interfaces[each.value.network_interface_id_key].id : null
  private_ip_address   = each.value.private_ip_address
}
