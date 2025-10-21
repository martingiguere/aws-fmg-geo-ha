# Oregon Public Subnet
resource "aws_subnet" "oregon_public" {
  provider                = aws.oregon
  vpc_id                  = aws_vpc.oregon.id
  cidr_block              = var.oregon_subnet_cidr
  availability_zone       = data.aws_availability_zones.oregon.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.project_name}-oregon-public-subnet"
    Region  = var.oregon_region
    Project = var.project_name
  }
}

# Ohio Public Subnet
resource "aws_subnet" "ohio_public" {
  provider                = aws.ohio
  vpc_id                  = aws_vpc.ohio.id
  cidr_block              = var.ohio_subnet_cidr
  availability_zone       = data.aws_availability_zones.ohio.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.project_name}-ohio-public-subnet"
    Region  = var.ohio_region
    Project = var.project_name
  }
}

# Data sources for availability zones
data "aws_availability_zones" "oregon" {
  provider = aws.oregon
  state    = "available"
}

data "aws_availability_zones" "ohio" {
  provider = aws.ohio
  state    = "available"
}
