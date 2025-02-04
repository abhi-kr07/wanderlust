resource "aws_key_pair" "deployer" {
  key_name   = "terraform-automate-key"
  public_key = file("terra-key.pub")
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "allow_user_to_connect" {
  name   = "allow TLS"
  vpc_id = aws_default_vpc.default.id

  ingress {
    description = "SSH allow"
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 22
    protocol    = "TCP"
    from_port   = 22
  }

  ingress {
    description = "allow HTTP"
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 80
    protocol    = "TCP"
    from_port   = 80
  }

  ingress {
    description = "allow HTTPS"
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 443
    protocol    = "TCP"
    from_port   = 443
  }

  ingress {
    description = "k8s node port"
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 32767
    protocol    = "TCP"
    from_port   = 30000
  }

  ingress {
    description = "SMTPS"
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 465
    protocol    = "TCP"
    from_port   = 465
  }

  ingress {
    description = "SMTP"
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 25
    protocol    = "TCP"
    from_port   = 25
  }

  ingress {
    description = "For our Application"
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 10000
    protocol    = "TCP"
    from_port   = 3000
  }

  ingress {
    description = "redis"
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 6379
    protocol    = "TCP"
    from_port   = 6379
  }

  ingress {
    description = "k8s"
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 6443
    protocol    = "TCP"
    from_port   = 6443
  }

  egress {
    description = "Allow all Outgoing traffic"
    cidr_blocks = ["0.0.0.0/0"]
    to_port     = 0
    protocol    = "-1"
    from_port   = 0
  }

  tags = {
    name = "mysecurity"
  }
}

resource "aws_instance" "testinstance" {
  ami             = var.ami-id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.allow_user_to_connect.name]
  key_name        = aws_key_pair.deployer.key_name

  tags = {
    name = "Automate"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }
}
