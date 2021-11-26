resource "aws_security_group" "security_groups" {
  for_each = var.security_groups

  name        = each.key
  description = each.value.description
  vpc_id      = data.aws_vpc.vpcs[each.value.vpc_id_key].id

  tags = merge(
    {
      Name        = each.key
      environment = each.value.environment
    },
    each.value.tags
  )
}
