data "aws_eip" "eips" {
  for_each = var.data_eips

  public_ip = each.value.public_ip
}
