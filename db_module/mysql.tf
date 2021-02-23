resource "aws_db_parameter_group" "db_para_group" {
  name   = "mysql"
  family = "mysql5.7"

  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "main"
  subnet_ids = [var.private_subnet_id_1 , var.private_subnet_id_2]

  tags = {
    Name = "Database subnet group"
  }
}

resource "aws_db_instance" "mysql_db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "test"
  username             = "root"
  password             = var.db-password
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name=aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids=[aws_security_group.db.id]
  skip_final_snapshot = "true"
  multi_az            = "true"

  tags = {
    Name = "mysql_db"
  }
}

output "end_point" {
  value = aws_db_instance.mysql_db.endpoint
}
