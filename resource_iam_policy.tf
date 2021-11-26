resource "aws_iam_policy" "iam_polices" {
  for_each = var.iam_polices

  name        = each.value.name
  path        = each.value.path
  description = each.value.description

  policy = data.template_file.files[each.value.policy_key].rendered
}
