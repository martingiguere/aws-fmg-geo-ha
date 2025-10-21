# Oregon Route Table
resource "aws_route_table" "oregon_public" {
  provider = aws.oregon
  vpc_id   = aws_vpc.oregon.id

  tags = {
    Name    = "${var.project_name}-oregon-public-rt"
    Region  = var.oregon_region
    Project = var.project_name
  }
}

# Oregon Route to Internet
resource "aws_route" "oregon_internet" {
  provider               = aws.oregon
  route_table_id         = aws_route_table.oregon_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.oregon.id
}

# Oregon Route to Ohio via TGW
resource "aws_route" "oregon_to_ohio" {
  provider               = aws.oregon
  route_table_id         = aws_route_table.oregon_public.id
  destination_cidr_block = var.ohio_vpc_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.oregon.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.oregon,
    aws_ec2_transit_gateway_peering_attachment_accepter.ohio
  ]
}

# Oregon Route Table Association
resource "aws_route_table_association" "oregon_public" {
  provider       = aws.oregon
  subnet_id      = aws_subnet.oregon_public.id
  route_table_id = aws_route_table.oregon_public.id
}

# Ohio Route Table
resource "aws_route_table" "ohio_public" {
  provider = aws.ohio
  vpc_id   = aws_vpc.ohio.id

  tags = {
    Name    = "${var.project_name}-ohio-public-rt"
    Region  = var.ohio_region
    Project = var.project_name
  }
}

# Ohio Route to Internet
resource "aws_route" "ohio_internet" {
  provider               = aws.ohio
  route_table_id         = aws_route_table.ohio_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ohio.id
}

# Ohio Route to Oregon via TGW
resource "aws_route" "ohio_to_oregon" {
  provider               = aws.ohio
  route_table_id         = aws_route_table.ohio_public.id
  destination_cidr_block = var.oregon_vpc_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.ohio.id

  depends_on = [
    aws_ec2_transit_gateway_vpc_attachment.ohio,
    aws_ec2_transit_gateway_peering_attachment_accepter.ohio
  ]
}

# Ohio Route Table Association
resource "aws_route_table_association" "ohio_public" {
  provider       = aws.ohio
  subnet_id      = aws_subnet.ohio_public.id
  route_table_id = aws_route_table.ohio_public.id
}
