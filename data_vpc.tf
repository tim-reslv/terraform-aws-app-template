data "aws_vpc" "vpcs" {
  for_each = var.vpcs

  cidr_block = each.value.cidr_block
}
