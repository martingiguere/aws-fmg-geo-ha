output "oregon_vpc_id" {
  description = "Oregon VPC ID"
  value       = aws_vpc.oregon.id
}

output "ohio_vpc_id" {
  description = "Ohio VPC ID"
  value       = aws_vpc.ohio.id
}

output "oregon_tgw_id" {
  description = "Oregon Transit Gateway ID"
  value       = aws_ec2_transit_gateway.oregon.id
}

output "ohio_tgw_id" {
  description = "Ohio Transit Gateway ID"
  value       = aws_ec2_transit_gateway.ohio.id
}

output "tgw_peering_attachment_id" {
  description = "Transit Gateway Peering Attachment ID"
  value       = aws_ec2_transit_gateway_peering_attachment.oregon_to_ohio.id
}

output "oregon_subnet_id" {
  description = "Oregon Public Subnet ID"
  value       = aws_subnet.oregon_public.id
}

output "ohio_subnet_id" {
  description = "Ohio Public Subnet ID"
  value       = aws_subnet.ohio_public.id
}

output "fortimanager_oregon_instance_id" {
  description = "Oregon FortiManager1 Instance ID"
  value       = aws_instance.fortimanager_oregon.id
}

output "fortimanager_oregon_public_ip" {
  description = "Oregon FortiManager1 Public IP"
  value       = aws_instance.fortimanager_oregon.public_ip
}

output "fortimanager_oregon_private_ip" {
  description = "Oregon FortiManager1 Private IP"
  value       = aws_instance.fortimanager_oregon.private_ip
}

output "fortimanager_ohio_instance_id" {
  description = "Ohio FortiManager2 Instance ID"
  value       = aws_instance.fortimanager_ohio.id
}

output "fortimanager_ohio_public_ip" {
  description = "Ohio FortiManager2 Public IP"
  value       = aws_instance.fortimanager_ohio.public_ip
}

output "fortimanager_ohio_private_ip" {
  description = "Ohio FortiManager2 Private IP"
  value       = aws_instance.fortimanager_ohio.private_ip
}

output "fortigate_ohio_instance_id" {
  description = "Ohio FortiGate Instance ID"
  value       = aws_instance.fortigate_ohio.id
}

output "fortigate_ohio_public_ip" {
  description = "Ohio FortiGate Public IP"
  value       = aws_instance.fortigate_ohio.public_ip
}

output "fortigate_ohio_private_ip" {
  description = "Ohio FortiGate Private IP"
  value       = aws_instance.fortigate_ohio.private_ip
}

output "s3_bucket_name" {
  description = "S3 Bucket name for Fortinet configuration files"
  value       = aws_s3_bucket.fortinet_config.id
}

output "s3_bucket_arn" {
  description = "S3 Bucket ARN for Fortinet configuration files"
  value       = aws_s3_bucket.fortinet_config.arn
}
