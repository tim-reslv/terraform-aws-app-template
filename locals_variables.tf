locals {
  subnet_keys = concat(
    sort(keys(var.subnets))
  )
  subnet_ids = concat(
    [for subnet in sort(keys(var.subnets)) : data.aws_subnet.subnets[subnet].id]
  )

  security_group_keys = concat(
    sort(keys(var.security_groups)),
    sort(keys(var.common_security_groups))
  )
  security_group_ids = concat(
    [for security_group_name in sort(keys(var.security_groups)) : aws_security_group.security_groups[security_group_name].id],
    [for security_group_name in sort(keys(var.common_security_groups)) : data.aws_security_group.common_security_groups[security_group_name].id]
  )

  security_group_rules = flatten([
    for security_group_key, security_group_rules in var.security_groups : [
      for security_group_rule_key, security_group_rule in security_group_rules.rules : {
        security_group_key           = security_group_key
        security_group_rule_key      = security_group_rule_key
        description                  = security_group_rule.description
        rule_type                    = security_group_rule.rule_type
        protocol                     = security_group_rule.protocol
        from_port                    = security_group_rule.from_port
        to_port                      = security_group_rule.to_port
        cidr_blocks                  = security_group_rule.cidr_blocks
        ipv6_cidr_blocks             = security_group_rule.ipv6_cidr_blocks
        source_security_group_id_key = security_group_rule.source_security_group_id_key
        self                         = security_group_rule.self
      }
    ]
  ])

  eip_keys = concat(
    sort(keys(var.eips)),
    sort(keys(var.data_eips))
  )
  eip_ids = concat(
    [for eip in sort(keys(var.eips)) : aws_eip.eips[eip].id],
    [for eip in sort(keys(var.data_eips)) : data.aws_eip.eips[eip].id]
  )
}
