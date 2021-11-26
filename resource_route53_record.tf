resource "aws_route53_record" "route53_records" {
  for_each = var.route53_records

  zone_id = data.aws_route53_zone.route53_zones[each.value.zone_id_key].zone_id
  name    = join(".", [each.value.name, data.aws_route53_zone.route53_zones[each.value.zone_id_key].name])
  type    = each.value.type
  ttl     = each.value.ttl
  records = each.value.records
}
