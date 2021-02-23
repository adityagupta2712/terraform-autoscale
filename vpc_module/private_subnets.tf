resource "aws_subnet" "private_1" {
  availability_zone = "ap-southeast-1a"
  vpc_id     = aws_vpc.vpc_test.id
  map_public_ip_on_launch = false
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "private_1"
  }
}
resource "aws_subnet" "private_2" {
  availability_zone = "ap-southeast-1b"
  vpc_id     = aws_vpc.vpc_test.id
  map_public_ip_on_launch = false
  cidr_block = "10.0.5.0/24"

  tags = {
    Name = "private_2"
  }
}
resource "aws_subnet" "private_3" {
  availability_zone = "ap-southeast-1c"
  vpc_id     = aws_vpc.vpc_test.id
  map_public_ip_on_launch = false
  cidr_block = "10.0.6.0/24"

  tags = {
    Name = "private_3"
  }
}

output "private_subnet_id_1"{
  value = aws_subnet.private_1.id
}
output "private_subnet_id_2"{
  value = aws_subnet.private_2.id
}
