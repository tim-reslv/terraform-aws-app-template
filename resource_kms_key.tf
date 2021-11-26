resource "aws_kms_key" "kms_keys" {
  for_each = var.kms_keys

  description              = each.value.description
  key_usage                = each.value.key_usage
  customer_master_key_spec = each.value.customer_master_key_spec
  policy                   = each.value.policy_key != null ? data.template_file.files[each.value.policy_key].rendered : null
  deletion_window_in_days  = each.value.deletion_window_in_days
  is_enabled               = each.value.is_enabled
  enable_key_rotation      = each.value.enable_key_rotation

  tags = merge(
    {
      Name        = each.key
      environment = each.value.environment
    },
    each.value.tags
  )
}
