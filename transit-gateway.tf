# Oregon Transit Gateway
resource "aws_ec2_transit_gateway" "oregon" {
  provider                       = aws.oregon
  description                    = "Transit Gateway in Oregon"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support                    = "enable"
  vpn_ecmp_support              = "enable"

  tags = {
    Name    = "${var.project_name}-oregon-tgw"
    Region  = var.oregon_region
    Project = var.project_name
  }
}

# Ohio Transit Gateway
resource "aws_ec2_transit_gateway" "ohio" {
  provider                       = aws.ohio
  description                    = "Transit Gateway in Ohio"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  dns_support                    = "enable"
  vpn_ecmp_support              = "enable"

  tags = {
    Name    = "${var.project_name}-ohio-tgw"
    Region  = var.ohio_region
    Project = var.project_name
  }
}

# Oregon VPC Attachment to Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "oregon" {
  provider           = aws.oregon
  subnet_ids         = [aws_subnet.oregon_public.id]
  transit_gateway_id = aws_ec2_transit_gateway.oregon.id
  vpc_id             = aws_vpc.oregon.id

  tags = {
    Name    = "${var.project_name}-oregon-tgw-attachment"
    Region  = var.oregon_region
    Project = var.project_name
  }
}

# Ohio VPC Attachment to Transit Gateway
resource "aws_ec2_transit_gateway_vpc_attachment" "ohio" {
  provider           = aws.ohio
  subnet_ids         = [aws_subnet.ohio_public.id]
  transit_gateway_id = aws_ec2_transit_gateway.ohio.id
  vpc_id             = aws_vpc.ohio.id

  tags = {
    Name    = "${var.project_name}-ohio-tgw-attachment"
    Region  = var.ohio_region
    Project = var.project_name
  }
}

# Transit Gateway Peering Attachment (Oregon to Ohio)
resource "aws_ec2_transit_gateway_peering_attachment" "oregon_to_ohio" {
  provider                = aws.oregon
  peer_region             = var.ohio_region
  peer_transit_gateway_id = aws_ec2_transit_gateway.ohio.id
  transit_gateway_id      = aws_ec2_transit_gateway.oregon.id

  tags = {
    Name    = "${var.project_name}-oregon-to-ohio-peering"
    Project = var.project_name
  }
}

# Accept Transit Gateway Peering Attachment in Ohio
resource "aws_ec2_transit_gateway_peering_attachment_accepter" "ohio" {
  provider                      = aws.ohio
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.oregon_to_ohio.id

  tags = {
    Name    = "${var.project_name}-ohio-peering-accepter"
    Project = var.project_name
  }
}

# Oregon TGW Route Table Route to Ohio
resource "aws_ec2_transit_gateway_route" "oregon_to_ohio" {
  provider                       = aws.oregon
  destination_cidr_block         = var.ohio_vpc_cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.oregon_to_ohio.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.oregon.association_default_route_table_id

  depends_on = [aws_ec2_transit_gateway_peering_attachment_accepter.ohio]
}

# Ohio TGW Route Table Route to Oregon
resource "aws_ec2_transit_gateway_route" "ohio_to_oregon" {
  provider                       = aws.ohio
  destination_cidr_block         = var.oregon_vpc_cidr
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.oregon_to_ohio.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway.ohio.association_default_route_table_id

  depends_on = [aws_ec2_transit_gateway_peering_attachment_accepter.ohio]
}
