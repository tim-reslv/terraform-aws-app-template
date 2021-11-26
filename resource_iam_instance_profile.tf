resource "aws_iam_instance_profile" "iam_instance_profiles" {
  for_each = var.iam_instance_profiles

  name = each.value.name
  path = each.value.path
  role = each.value.role_key
}
