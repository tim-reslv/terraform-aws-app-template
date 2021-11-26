data "aws_kms_key" "kms_keys" {
  for_each = var.data_kms_keys

  key_id = each.value.key_id
}
