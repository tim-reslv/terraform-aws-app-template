resource "aws_db_subnet_group" "db_subnet_groups" {
  for_each = var.db_instances

  name        = each.value.db_subnet_group_name
  description = each.value.description
  subnet_ids  = matchkeys(local.subnet_ids, local.subnet_keys, each.value.subnet_ids_keys)

  tags = merge(
    {
      Name        = each.key
      environment = each.value.environment
    },
    each.value.tags
  )
}
