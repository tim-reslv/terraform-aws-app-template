data "aws_subnet" "subnets" {
  for_each = var.subnets

  cidr_block = each.value.cidr_block
}
