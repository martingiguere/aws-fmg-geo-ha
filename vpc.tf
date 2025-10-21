# Oregon VPC
resource "aws_vpc" "oregon" {
  provider             = aws.oregon
  cidr_block           = var.oregon_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "${var.project_name}-oregon-vpc"
    Region  = var.oregon_region
    Project = var.project_name
  }
}

# Ohio VPC
resource "aws_vpc" "ohio" {
  provider             = aws.ohio
  cidr_block           = var.ohio_vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name    = "${var.project_name}-ohio-vpc"
    Region  = var.ohio_region
    Project = var.project_name
  }
}
