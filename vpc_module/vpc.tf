######
# VPC
######
#terraform version >= 12
############
resource "aws_vpc" "vpc_test" {
  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink

  tags = {
      Name = "vpc test"
    }
}

output "vpc_test_id"{
  value = aws_vpc.vpc_test.id
}
