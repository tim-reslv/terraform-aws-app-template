data "aws_security_group" "common_security_groups" {
  for_each = var.common_security_groups

  vpc_id = data.aws_vpc.vpcs[each.value.vpc_id_key].id
  name   = each.value.name
}
