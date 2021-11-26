resource "aws_ecr_repository_policy" "ecr_repository_policies" {
  for_each = var.ecr_repository_policies

  repository = aws_ecr_repository.ecr_repositories[each.value.repository_key].name
  policy     = data.template_file.files[each.value.policy_key].rendered
}
