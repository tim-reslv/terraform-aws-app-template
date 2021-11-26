resource "aws_ecr_repository" "ecr_repositories" {
  for_each = var.ecr_repositories

  name = each.value.name
  dynamic "encryption_configuration" {
    for_each = each.value.encryption_configuration.encryption_type != null ? { "encryption_configuration" = each.value } : {}

    content {
      encryption_type = each.value.encryption_configuration.encryption_type
      kms_key         = each.value.encryption_configuration.encryption_type == "KMS" ? aws_kms_key.kms_keys[each.value.encryption_configuration.kms_key_key].arn : null
    }
  }
  image_tag_mutability = each.value.image_tag_mutability
  image_scanning_configuration {
    scan_on_push = each.value.image_scanning_configuration.scan_on_push
  }

  tags = merge(
    {
      Name        = each.key
      environment = each.value.environment
    },
    each.value.tags
  )
}
