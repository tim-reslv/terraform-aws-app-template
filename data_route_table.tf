data "aws_route_table" "route_tables" {
  for_each = var.route_tables

  subnet_id = data.aws_subnet.subnets[each.value.subnet_id_key].id
}
