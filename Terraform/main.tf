provider "aws" {
  region = var.aws_region
}

resource "aws_security_group" "web_sg" {
  name        = "portfolio-sg"
  description = "Allow SSH, HTTP, HTTPS, and Node Exporter"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # SSH (તમારા IPથી રિસ્ટ્રિક્ટ કરવો માટે)
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]   # Prometheus Node Exporter (જો external monitoring હોય તો)
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "portfolio" {
  ami           = "ami-0c55b159cbfafe1f0"   # Amazon Linux 2 (us-east-1)
  instance_type = var.instance_type
  key_name      = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("user_data.sh")   # startup script

  tags = {
    Name = "portfolio-prod"
  }
}

resource "aws_key_pair" "ssh_key" {
  key_name   = "portfolio-key"
  public_key = file(var.public_key_path)
}