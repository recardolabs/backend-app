resource "aws_security_group" "allow_all" {
  name_prefix = "allow_all"
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "example" {
  name        = "example"
  subnet_ids  = ["subnet-12345678", "subnet-abcdefgh"]
}

resource "aws_db_instance" "example" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "8.0.21"
  instance_class       = "db.t3.micro"
  name                 = "example"
  username             = "admin"
  password             = "password123"
  db_subnet_group_name = aws_db_subnet_group.example.name
  vpc_security_group_ids = [
    aws_security_group.allow_all.id,
  ]
  publicly_accessible    = true
}

output "rds_endpoint" {
  value = aws_db_instance.example.endpoint
}
