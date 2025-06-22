# main.tf

# Configure the AWS Provider
# This block tells Terraform which cloud provider to use (AWS)
# and in which region to deploy your resources.
# It's recommended to set the region explicitly.
provider "aws" {
  region = "eu-west-2" # London region
}

# Create a Security Group for the EC2 instance
# A security group acts as a virtual firewall that controls inbound and outbound
# traffic for your instance.
resource "aws_security_group" "ec2_security_group" {
  name        = "web_server_security_group"
  description = "Allow SSH and HTTP inbound traffic"

  # Ingress (inbound) rules
  # This rule allows SSH access from anywhere (0.0.0.0/0)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Be cautious with 0.0.0.0/0 for SSH in production
    description = "Allow SSH from anywhere"
  }

  # This rule allows HTTP access from anywhere (0.0.0.0/0)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere"
  }

  # Egress (outbound) rule
  # This rule allows all outbound traffic from the instance
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "WebServerSG"
  }
}

# Create an EC2 Instance
# This resource block defines the EC2 instance itself, including its type,
# Amazon Machine Image (AMI), and associates it with the security group.
resource "aws_instance" "web_server" {
  # ami = "ami-0abcdef1234567890" # Replace with a valid AMI ID for eu-west-2
  ami           = "ami-044415bb13eee2391" # Example AMI for Ubuntu 20.04 LTS 
  instance_type = "t2.micro"              # Free tier eligible instance type

  # Associate the instance with the security group created above
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  key_name = "aws-test"

  # User data to run commands on instance launch
  # The instance will still update its package list.
  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y

              # Install Docker
              sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
              echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
              sudo apt-get update -y
              sudo apt-get install -y docker-ce docker-ce-cli containerd.io

              # Add ubuntu user to the docker group so it can run docker commands without sudo
              sudo usermod -aG docker ubuntu
              # Note: For this group change to take effect for the 'ubuntu' user
              # without a reboot, you would typically need to log out and log back in,
              # or run 'newgrp docker'. In a user_data script, this will apply
              # for subsequent SSH sessions.

              echo "Docker installation complete."
              EOF

  # Tags are key-value pairs that help you manage, identify, organize,
  # search for, and filter resources.
  tags = {
    Name        = "MyWebServer"
    Environment = "Development"
  }
}

# Output the public IP address of the EC2 instance
# This output variable will display the public IP after Terraform applies the configuration.
output "public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}
