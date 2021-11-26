resource "aws_s3_bucket" "s3_buckets" {
  for_each = var.s3_buckets

  bucket        = each.value.bucket
  acl           = each.value.acl
  force_destroy = each.value.force_destroy

  versioning {
    enabled    = each.value.versioning.enabled
    mfa_delete = each.value.versioning.mfs_delete
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = each.value.server_side_encryption_configuration.rule.apply_server_side_encryption_by_default.sse_algorithm
        kms_master_key_id = each.value.server_side_encryption_configuration.rule.apply_server_side_encryption_by_default.kms_master_key_id_key != null ? aws_kms_key.kms_keys[each.value.server_side_encryption_configuration.rule.apply_server_side_encryption_by_default.kms_master_key_id_key].arn : null
      }
    }
  }

  tags = merge(
    {
      Name        = each.key
      environment = each.value.environment
    },
    each.value.tags
  )
}
