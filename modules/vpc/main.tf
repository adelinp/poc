resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-central-1a"
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-central-1b"
}

resource "aws_security_group" "lambda_sg" {
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.lambda_sg.id] # Only allow Lambda access
  }
}


resource "aws_vpc_endpoint" "rds" {
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.${var.aws_region}.rds"
  vpc_endpoint_type = "Interface"
  subnet_ids        = var.private_subnet_ids
  security_group_ids = [aws_security_group.lambda_sg.id]

  private_dns_enabled = true
}
resource "aws_security_group_rule" "allow_lambda_egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1" # Allow all protocols
  security_group_id = aws_security_group.lambda_sg.id
  cidr_blocks = ["0.0.0.0/0"]
  description = "Allow Lambda outbound traffic"
}

