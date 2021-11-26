resource "aws_iam_role" "iam_roles" {
  for_each = var.iam_roles

  name                  = each.value.name
  assume_role_policy    = data.template_file.files[each.value.assume_role_policy_key].rendered
  force_detach_policies = each.value.force_detach_policies
  path                  = each.value.path
  description           = each.value.description
  max_session_duration  = each.value.max_session_duration

  tags = merge(
    {
      Name        = each.key
      environment = each.value.environment
    },
    each.value.tags
  )
}
