# Data source to find Fortinet FortiManager AMI in Oregon
data "aws_ami" "fortimanager_oregon" {
  provider    = aws.oregon
  most_recent = true
  owners      = ["aws-marketplace"]

  filter {
    name   = "name"
    values = ["FortiManager-VM64-AWS *(7.4.*)*"]
  }

  filter {
    name   = "product-code"
    values = ["os40mk0fw6472m8ak2lnzp4s"]
  }
}

# Data source to find Fortinet FortiManager AMI in Ohio
data "aws_ami" "fortimanager_ohio" {
  provider    = aws.ohio
  most_recent = true
  owners      = ["aws-marketplace"]

  filter {
    name   = "name"
    values = ["FortiManager-VM64-AWS *(7.4.*)*"]
  }

  filter {
    name   = "product-code"
    values = ["os40mk0fw6472m8ak2lnzp4s"]
  }
}

# Data source to find Fortinet FortiGate BYOL AMI in Ohio
data "aws_ami" "fortigate_ohio" {
  provider    = aws.ohio
  most_recent = true
  owners      = ["aws-marketplace"]

  filter {
    name   = "name"
    values = ["FortiGate-VM64-AWS *(7.4.*)*"]
  }

  filter {
    name   = "product-code"
    values = ["dlaioq277sglm5mw1y1dmeuqa"]
  }
}

# Data source for current region - Oregon
data "aws_region" "oregon" {
  provider = aws.oregon
}

# Data source for current region - Ohio
data "aws_region" "ohio" {
  provider = aws.ohio
}

# Security group for FortiManager in Oregon
resource "aws_security_group" "fortimanager_oregon" {
  provider    = aws.oregon
  name        = "${var.project_name}-fortimanager1-sg"
  description = "Security group for FortiManager1 in Oregon"
  vpc_id      = aws_vpc.oregon.id

  ingress {
    description = "HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager registration"
    from_port   = 541
    to_port     = 541
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Syslog"
    from_port   = 514
    to_port     = 514
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager communication"
    from_port   = 2032
    to_port     = 2032
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager web UI"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager tunnel"
    from_port   = 5199
    to_port     = 5199
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager API"
    from_port   = 6020
    to_port     = 6020
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager communication"
    from_port   = 6028
    to_port     = 6028
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP alternate"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager secure communication"
    from_port   = 9443
    to_port     = 9443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow traffic from Ohio VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ohio_vpc_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-fortimanager1-sg"
    Region  = var.oregon_region
    Project = var.project_name
  }
}

# Security group for FortiManager in Ohio
resource "aws_security_group" "fortimanager_ohio" {
  provider    = aws.ohio
  name        = "${var.project_name}-fortimanager2-sg"
  description = "Security group for FortiManager2 in Ohio"
  vpc_id      = aws_vpc.ohio.id

  ingress {
    description = "HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager registration"
    from_port   = 541
    to_port     = 541
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Syslog"
    from_port   = 514
    to_port     = 514
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager communication"
    from_port   = 2032
    to_port     = 2032
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager web UI"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager tunnel"
    from_port   = 5199
    to_port     = 5199
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager API"
    from_port   = 6020
    to_port     = 6020
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager communication"
    from_port   = 6028
    to_port     = 6028
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP alternate"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiManager secure communication"
    from_port   = 9443
    to_port     = 9443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow traffic from Oregon VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.oregon_vpc_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-fortimanager2-sg"
    Region  = var.ohio_region
    Project = var.project_name
  }
}

# Security group for FortiGate in Ohio
resource "aws_security_group" "fortigate_ohio" {
  provider    = aws.ohio
  name        = "${var.project_name}-fortigate-ohio-sg"
  description = "Security group for FortiGate in Ohio"
  vpc_id      = aws_vpc.ohio.id

  ingress {
    description = "HTTPS access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "FortiGate to FortiManager"
    from_port   = 541
    to_port     = 541
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow traffic from Oregon VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.oregon_vpc_cidr]
  }

  ingress {
    description = "Allow traffic from Ohio VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.ohio_vpc_cidr]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "${var.project_name}-fortigate-ohio-sg"
    Region  = var.ohio_region
    Project = var.project_name
  }
}

# EC2 Instance - FortiManager1 in Oregon
resource "aws_instance" "fortimanager_oregon" {
  provider               = aws.oregon
  ami                    = data.aws_ami.fortimanager_oregon.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.oregon_public.id
  vpc_security_group_ids = [aws_security_group.fortimanager_oregon.id]
  private_ip             = "10.1.1.10"
  iam_instance_profile   = aws_iam_instance_profile.fortinet_s3_access.name
  
  user_data = jsonencode({
    bucket  = aws_s3_bucket.fortinet_config.id
    region  = data.aws_region.oregon.name
    license = "fortimanager1/FMG-VMTM25014032.lic"
    config  = "fortimanager1/fortimanager1.txt"
  })

  root_block_device {
    volume_type = "gp3"
    volume_size = 50
    encrypted   = true
    tags = {
      Name = "${var.project_name}-fortimanager1-volume"
    }
  }

  tags = {
    Name    = "${var.project_name}-fortimanager1"
    Region  = var.oregon_region
    Project = var.project_name
  }
}

# EC2 Instance - FortiManager2 in Ohio
resource "aws_instance" "fortimanager_ohio" {
  provider               = aws.ohio
  ami                    = data.aws_ami.fortimanager_ohio.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.ohio_public.id
  vpc_security_group_ids = [aws_security_group.fortimanager_ohio.id]
  private_ip             = "10.2.1.10"
  iam_instance_profile   = aws_iam_instance_profile.fortinet_s3_access.name
  
  user_data = jsonencode({
    bucket  = aws_s3_bucket.fortinet_config.id
    region  = data.aws_region.ohio.name
    license = "fortimanager2/FMG-VMTM25014033.lic"
    config  = "fortimanager2/fortimanager2.txt"
  })

  root_block_device {
    volume_type = "gp3"
    volume_size = 50
    encrypted   = true
    tags = {
      Name = "${var.project_name}-fortimanager2-volume"
    }
  }

  tags = {
    Name    = "${var.project_name}-fortimanager2"
    Region  = var.ohio_region
    Project = var.project_name
  }
}

# EC2 Instance - FortiGate in Ohio
resource "aws_instance" "fortigate_ohio" {
  provider               = aws.ohio
  ami                    = data.aws_ami.fortigate_ohio.id
  instance_type          = var.fortigate_instance_type
  subnet_id              = aws_subnet.ohio_public.id
  vpc_security_group_ids = [aws_security_group.fortigate_ohio.id]
  private_ip             = "10.2.1.11"
  iam_instance_profile   = aws_iam_instance_profile.fortinet_s3_access.name
  
  user_data = jsonencode({
    bucket  = aws_s3_bucket.fortinet_config.id
    region  = data.aws_region.ohio.name
    license = "fortigate/FGVM8VTM25000613.lic"
    config  = "fortigate/fortigate.txt"
  })

  root_block_device {
    volume_type = "gp3"
    volume_size = 30
    encrypted   = true
  }

  tags = {
    Name    = "${var.project_name}-fortigate-ohio"
    Region  = var.ohio_region
    Project = var.project_name
  }
}
