resource "aws_instance" "postgres_server" {
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.postgres_server_security_group.id]

  tags = {
    Name = var.app_name
  }
}

resource "aws_security_group" "postgres_server_security_group" {
  name        = var.postgres_security_group_name
  description = "Allow inbound traffic for PostgreSQL"

  ingress {
    from_port   = 5432 # PostgreSQL
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22 # SSH
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}