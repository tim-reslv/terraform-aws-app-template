resource "aws_eip" "eips" {
  for_each = var.eips

  vpc = each.value.vpc

  tags = merge(
    {
      Name        = each.key
      environment = each.value.environment
    },
    each.value.tags
  )
}
