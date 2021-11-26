resource "aws_iam_role_policy_attachment" "iam_role_policy_attachments" {
  for_each = {
    for attach_key, attach_value in var.iam_policy_attachments : attach_key => attach_value
    if attach_value.role_key != null
  }

  role       = aws_iam_role.iam_roles[each.value.role_key].name
  policy_arn = each.value.policy_arn_key != null ? aws_iam_policy.iam_polices[each.value.policy_arn_key].arn : each.value.policy_arn
}
