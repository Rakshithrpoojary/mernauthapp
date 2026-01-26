resource "aws_vpc" "vpc" {
  cidr_block = var.aws_vpc.cidr
  tags       = var.aws_vpc.tags
}

resource "aws_subnet" "pubsubnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.aws_subnet.cidr
  availability_zone       = var.aws_subnet.availabiltyzone
  map_public_ip_on_launch = true
  tags                    = var.aws_subnet.tags
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.vpc.id
  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "jenkinsui"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "sonar"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "app"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg"
  }
}

resource "aws_instance" "master" {
  ami                    = var.aws_instance_master.ami
  instance_type          = var.aws_instance_master.instancetype
  subnet_id              = aws_subnet.pubsubnet.id
  vpc_security_group_ids = [aws_security_group.sg.id]
  key_name               = "jenkins-key"
  root_block_device {
    volume_type = var.aws_instance_master.storagetype
    volume_size = var.aws_instance_master.storage
  }
}
resource "aws_instance" "agent" {
  ami                    = var.aws_instance_agent.ami
  instance_type          = var.aws_instance_agent.instancetype
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = aws_subnet.pubsubnet.id

  key_name = "jenkins-key"
  root_block_device {
    volume_type = var.aws_instance_agent.storagetype
    volume_size = var.aws_instance_agent.storage
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IGW"
  }
}
resource "aws_route_table" "aws_rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    "Name" = "Rotetable"
  }

}

resource "aws_route" "rt" {
  route_table_id         = aws_route_table.aws_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "rtassoc" {
  route_table_id = aws_route_table.aws_rt.id
  subnet_id      = aws_subnet.pubsubnet.id
}
