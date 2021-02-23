resource "aws_subnet" "public_1" {
  availability_zone = "ap-southeast-1a"
  vpc_id     = aws_vpc.vpc_test.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public_1"
  }
}
resource "aws_subnet" "public_2" {
  availability_zone = "ap-southeast-1b"
  vpc_id     = aws_vpc.vpc_test.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public_2"
  }
}
resource "aws_subnet" "public_3" {
  availability_zone = "ap-southeast-1c"
  vpc_id     = aws_vpc.vpc_test.id
  map_public_ip_on_launch = true
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "public_3"
  }
}

output "public_subnet_id_1"{
  value = aws_subnet.public_1.id
}
output "public_subnet_id_2"{
  value = aws_subnet.public_2.id
}
output "public_subnet_id_3"{
  value = aws_subnet.public_3.id
}
