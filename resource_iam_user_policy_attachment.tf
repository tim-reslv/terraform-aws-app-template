resource "aws_iam_user_policy_attachment" "iam_user_policy_attachments" {
  for_each = {
    for attach_key, attach_value in var.iam_policy_attachments : attach_key => attach_value
    if attach_value.user_key != null
  }

  user       = aws_iam_user.iam_users[each.value.user_key].name
  policy_arn = each.value.policy_arn_key != null ? aws_iam_policy.iam_polices[each.value.policy_arn_key].arn : each.value.policy_arn
}
