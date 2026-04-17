# ============================= EC2 instance =================================
resource "aws_instance" "instance-eu-west-1a" {
  ami           = var.ami_id
  instance_type = "t2.micro" # Free tier eligible

  associate_public_ip_address = true # Gives instance a public IP so you can access it
  subnet_id                   = aws_subnet.main.id

  key_name = var.key_name

  # Attach the security group to this instance
  vpc_security_group_ids = [aws_security_group.public_http_traffic.id]



  tags = {
    Name = "fastapi-dev-server-1"
  }
}







