# Configure AWS provider and region
provider "aws" {
  region = "eu-west-1"
}

# Create default VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

#Create default subnet 
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "Main"
  }
}

# Create EC2 instance
resource "aws_instance" "instance-eu-west-1a" {
  ami           = "ami-0324bce2436ce02b2" # Ubuntu AMI (region-specific)
  instance_type = "t2.micro"              # Free tier eligible

  associate_public_ip_address = true # Gives instance a public IP so you can access it
  subnet_id                   = aws_subnet.main.id 

  # Attach the security group to this instance
  vpc_security_group_ids = [aws_security_group.public_http_traffic.id]

  tags = {
    Name = "instance-eu-west-1a"
  }
}

# Create a security group 
resource "aws_security_group" "public_http_traffic" {
  description = "Security group to allow traffic on ports"
  vpc_id      = aws_vpc.main.id
  name        = "public-http-traffic"
}

# Allow inbound traffic on port 8000 for fast api app
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0" # Allow from anywhere (public access)
  from_port         = 8000
  to_port           = 8000
  ip_protocol       = "tcp"
}

# Allow SSH access 
resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# Allow ALL outbound traffic (needed for internet access, Docker install, etc.)
resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
