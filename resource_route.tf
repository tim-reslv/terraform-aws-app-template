resource "aws_route" "routes" {
  for_each = var.routes

  route_table_id         = data.aws_route_table.route_tables[each.value.route_table_id_key].id
  destination_cidr_block = each.value.destination_cidr_block
  network_interface_id   = aws_network_interface.network_interfaces[each.value.network_interface_id_key].id
}
