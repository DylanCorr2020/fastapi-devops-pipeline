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



# Allow ALL outbound traffic (needed for internet access, Docker install, etc.)
resource "aws_vpc_security_group_egress_rule" "all_outbound" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
