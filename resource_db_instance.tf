resource "aws_db_instance" "db_instances" {
  for_each = var.db_instances

  allocated_storage                     = each.value.allocated_storage
  allow_major_version_upgrade           = each.value.allow_major_version_upgrade
  apply_immediately                     = each.value.apply_immediately
  auto_minor_version_upgrade            = each.value.auto_minor_version_upgrade
  availability_zone                     = each.value.multi_az ? null : join("", [var.aws_region, each.value.availability_zone])
  backup_retention_period               = each.value.backup_retention_period
  backup_window                         = each.value.backup_window
  ca_cert_identifier                    = each.value.ca_cert_identifier
  character_set_name                    = each.value.character_set_name
  copy_tags_to_snapshot                 = each.value.copy_tags_to_snapshot
  db_subnet_group_name                  = aws_db_subnet_group.db_subnet_groups[each.value.db_subnet_group_name].name
  delete_automated_backups              = each.value.delete_automated_backups
  deletion_protection                   = each.value.deletion_protection
  domain                                = each.value.domain
  domain_iam_role_name                  = each.value.domain_iam_role_name
  enabled_cloudwatch_logs_exports       = each.value.enabled_cloudwatch_logs_exports
  engine                                = each.value.engine
  engine_version                        = each.value.engine_version
  final_snapshot_identifier             = each.value.final_snapshot_identifier
  iam_database_authentication_enabled   = each.value.iam_database_authentication_enabled
  identifier                            = each.value.identifier
  instance_class                        = each.value.instance_class
  iops                                  = each.value.iops
  kms_key_id                            = each.value.kms_key_id_key != null ? aws_kms_key.kms_keys[each.value.kms_key_id_key].arn : null
  license_model                         = each.value.license_model
  maintenance_window                    = each.value.maintenance_window
  max_allocated_storage                 = each.value.max_allocated_storage
  monitoring_interval                   = each.value.monitoring_interval
  monitoring_role_arn                   = each.value.monitoring_role_arn_key != null ? aws_iam_role.iam_roles[each.value.monitoring_role_arn_key].arn : null
  multi_az                              = each.value.multi_az
  name                                  = each.value.name
  option_group_name                     = each.value.option_group_name
  parameter_group_name                  = each.value.parameter_group_name
  password                              = random_password.passwords[each.value.password_key].result
  performance_insights_enabled          = each.value.performance_insights_enabled
  performance_insights_kms_key_id       = each.value.performance_insights_kms_key_id_key != null ? aws_kms_key.kms_keys[each.value.performance_insights_kms_key_id_key].arn : null
  performance_insights_retention_period = each.value.performance_insights_retention_period
  port                                  = each.value.port
  publicly_accessible                   = each.value.publicly_accessible
  skip_final_snapshot                   = each.value.skip_final_snapshot
  storage_encrypted                     = each.value.storage_encrypted
  storage_type                          = each.value.storage_type
  timezone                              = each.value.timezone
  username                              = each.value.username
  vpc_security_group_ids                = matchkeys(local.security_group_ids, local.security_group_keys, each.value.vpc_security_group_ids_keys)

  tags = merge(
    {
      Name        = each.key
      environment = each.value.environment
    },
    each.value.tags
  )
}
