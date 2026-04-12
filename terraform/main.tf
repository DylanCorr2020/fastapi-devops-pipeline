# Configure AWS provider and region
provider "aws" {
  region = "eu-west-1"
}

# =================== VPC (Private Network) =========================
# Defines the main virtual network with a private IP range
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16" # Allows IPs from 10.0.0.0 → 10.0.255.255

  tags = {
    Name = "Main VPC"
  }
}

# =================== Subnet =========================
# A smaller network inside the VPC where resources (e.g. EC2) will live
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24" # Subset of VPC range (256 IPs)

  tags = {
    Name = "Public Subnet"
  }
}

# =================== Internet Gateway =========================
# Enables communication between the VPC and the internet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Internet Gateway"
  }
}

# =================== Route Table =========================
# Defines how traffic is routed from the subnet
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"                # Match all external traffic
    gateway_id = aws_internet_gateway.gw.id # Send it to the Internet Gateway
  }

  tags = {
    Name = "Public Route Table"
  }
}

# =================== Route Table Association =========================
# Links the subnet to the route table so it can access the internet
resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.route.id
}




# ============================= EC2 instance =================================
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


# ======================= Security Groups ============================== 

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


