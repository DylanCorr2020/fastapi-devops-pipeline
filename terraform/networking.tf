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