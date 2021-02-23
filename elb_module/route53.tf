resource "aws_route53_zone" "test_aditya" {
  name = "testaditya.in"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.test_aditya.zone_id
  name    = "www.testaditya.in"
  type    = "A"

  alias {
     name                   = aws_lb.elb_test.dns_name
     zone_id                = aws_lb.elb_test.zone_id
     evaluate_target_health = true
   }

}

output "name_server"{
  value=aws_route53_zone.test_aditya.name_servers
}
