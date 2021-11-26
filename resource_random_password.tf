resource "random_password" "passwords" {
  for_each = var.random_passwords

  length           = each.value.length
  upper            = each.value.upper
  min_upper        = each.value.min_upper
  lower            = each.value.lower
  min_lower        = each.value.min_lower
  number           = each.value.number
  min_numeric      = each.value.min_numeric
  special          = each.value.special
  min_special      = each.value.min_special
  override_special = each.value.override_special
}
