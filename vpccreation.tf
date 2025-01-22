provider "aws"{
    region="us-east-1"
    access_key= var.access_key
    secret_key= var.secret_key
}


# 1 creating vpc
resource "aws_vpc" "firstvpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "my_firstvpc"
  }
}

# 2 creating internet gateway
resource "aws_internet_gateway" "gateway01" {
  vpc_id = aws_vpc.firstvpc.id

   tags = {
    Name = "my_gateway"
  }
}

# 3 creating route table
resource "aws_route_table" "routes" {
  vpc_id = aws_vpc.firstvpc.id

route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.gateway01.id
  }

  tags = {
    Name = "route-table"
  }
}

# 4 creating a subnet

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.firstvpc.id
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my_subnet"
  }
}

# 5 Associate subnet with route table

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.routes.id
}

# 6 Create a security group to allow port 22,80,443

resource "aws_security_group" "allow_ports" {
  vpc_id = aws_vpc.firstvpc.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  tags = {
    Name = "allow-ssh-http-https"
  }
}

# 7 Create a network interface with an ip in the subnet that was created in step 4

resource "aws_network_interface" "netinter" {
  subnet_id = aws_subnet.subnet.id
  private_ips = ["10.0.1.10"]  # Private IP in the subnet

  security_groups = [aws_security_group.allow_ports.id]

  tags = {
    Name = "network-interface"
  }
}

# 8 Assign an Elastic IP to the Network Interface

resource "aws_eip" "main" {
  network_interface = aws_network_interface.netinter.id
  # associate_with_private_ip = true

  tags = {
    Name = "elastic-ip"
  }
}

# 9 Create an Ubuntu EC2 instance and install Apache

resource "aws_instance" "ubuntu" {
  ami           = "ami-04b4f1a9cf54c11d0"  
  instance_type = "t2.micro"  

  

  network_interface {
    network_interface_id = aws_network_interface.netinter.id
    device_index = 0
  }

  tags = {
    Name = "ubuntu-apache-server"
  }

  # User data to install Apache on the EC2 instance
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install apache2 -y
              systemctl start apache2
              systemctl enable apache2
              EOF
}

