resource "aws_security_group_rule" "security_group_rules" {
  for_each = {
    for security_group_rule in local.security_group_rules : join("-", [security_group_rule.security_group_key, security_group_rule.security_group_rule_key]) => security_group_rule
  }

  security_group_id = aws_security_group.security_groups[each.value.security_group_key].id
  type              = each.value.rule_type

  description = each.value.description

  protocol  = each.value.protocol
  from_port = each.value.from_port
  to_port   = each.value.to_port

  cidr_blocks              = length(each.value.cidr_blocks) != 0 ? each.value.cidr_blocks : null
  ipv6_cidr_blocks         = length(each.value.ipv6_cidr_blocks) != 0 ? each.value.ipv6_cidr_blocks : null
  source_security_group_id = each.value.source_security_group_id_key != null ? aws_security_group.security_groups[each.value.source_security_group_id_key].id : null
  self                     = each.value.self ? true : null
}
