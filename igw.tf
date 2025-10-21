# Oregon Internet Gateway
resource "aws_internet_gateway" "oregon" {
  provider = aws.oregon
  vpc_id   = aws_vpc.oregon.id

  tags = {
    Name    = "${var.project_name}-oregon-igw"
    Region  = var.oregon_region
    Project = var.project_name
  }
}

# Ohio Internet Gateway
resource "aws_internet_gateway" "ohio" {
  provider = aws.ohio
  vpc_id   = aws_vpc.ohio.id

  tags = {
    Name    = "${var.project_name}-ohio-igw"
    Region  = var.ohio_region
    Project = var.project_name
  }
}
