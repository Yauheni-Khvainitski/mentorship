resource "aws_security_group" "rds" {
  name   = "rds-pg-airflow-backend"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_parameter_group" "rds_mentorship" {
  name   = "rds-pg-airflow-backend"
  family = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "airflow_backend" {
  identifier             = "rds-pg-airflow-backend"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13"
  username               = var.airflow_user_name
  password               = var.airflow_password
  db_name                = "airflow"
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.rds_mentorship.name
  publicly_accessible    = true
  skip_final_snapshot    = true
}
