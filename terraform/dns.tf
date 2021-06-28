data "aws_route53_zone" "farmiq_domain" {
  zone_id = "Z3YYWVP351JMY"
}

resource "aws_route53_record" "auth" {
  name    = var.api_subdomain
  type    = "A"
  zone_id = data.aws_route53_zone.farmiq_domain.id

  alias {
    name                   = aws_lb.farmiq.dns_name
    zone_id                = aws_lb.farmiq.zone_id
    evaluate_target_health = false
  }
}
