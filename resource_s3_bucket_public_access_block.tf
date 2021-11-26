resource "aws_s3_bucket_public_access_block" "s3_bucket_public_access_blocks" {
  for_each = var.s3_buckets

  bucket = aws_s3_bucket.s3_buckets[each.value.bucket].id

  block_public_acls       = each.value.public_access_block.block_public_acls
  block_public_policy     = each.value.public_access_block.block_public_policy
  ignore_public_acls      = each.value.public_access_block.ignore_public_acls
  restrict_public_buckets = each.value.public_access_block.restrict_public_buckets
}
