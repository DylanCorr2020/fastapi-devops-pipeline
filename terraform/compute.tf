# ============================= EC2 instance =================================
resource "aws_instance" "instance-eu-west-1a" {
  ami           = var.ami_id
  instance_type = "t2.micro" # Free tier eligible

  associate_public_ip_address = true # Gives instance a public IP so you can access it
  subnet_id                   = aws_subnet.main.id

  key_name = var.key_name

  # Attach the security group to this instance
  vpc_security_group_ids = [aws_security_group.public_http_traffic.id]

  user_data = <<-EOF
#!/bin/bash
set -e

# Update system
apt-get update -y
apt-get upgrade -y

# Install prerequisites
apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker GPG key
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# Add Docker repo
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update again after repo add
apt-get update -y

# Install Docker
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable Docker
systemctl enable docker
systemctl start docker

# Allow ubuntu user to run docker without sudo
usermod -aG docker ubuntu
EOF

  tags = {
    Name = "fastapi-dev-server-1"
  }
}







