resource "aws_kms_alias" "kms_alias" {
  for_each = var.kms_keys

  name          = each.value.kms_alias
  target_key_id = aws_kms_key.kms_keys[each.key].key_id
}
