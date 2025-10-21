# AWS Multi-Region Transit Gateway with Terraform

This Terraform project deploys an AWS Transit Gateway infrastructure connecting two regions (Oregon and Ohio) with VPCs, Internet Gateways, public subnets, route tables, and Transit Gateway attachments.

## Architecture

The deployment creates:

### Oregon Region (us-west-2)
- VPC with CIDR 10.1.0.0/16
- Public subnet with CIDR 10.1.1.0/24
- Internet Gateway
- Route table with routes to internet and Ohio VPC via TGW
- Transit Gateway
- Transit Gateway VPC attachment
- EC2 Instance (m5.large) running Fortinet FortiManager1
- Security group for FortiManager1

### Ohio Region (us-east-2)
- VPC with CIDR 10.2.0.0/16
- Public subnet with CIDR 10.2.1.0/24
- Internet Gateway
- Route table with routes to internet and Oregon VPC via TGW
- Transit Gateway
- Transit Gateway VPC attachment
- EC2 Instance (m5.large) running Fortinet FortiManager2
- EC2 Instance (c5.large) running Fortinet FortiGate (BYOL)
- Security groups for FortiManager2 and FortiGate

### Cross-Region Connectivity
- Transit Gateway Peering connection between Oregon and Ohio
- Routes configured in both TGW route tables for cross-region communication

### S3 Storage
- S3 bucket for storing Fortinet configuration files and licenses
- Organized folder structure:
  - `fortimanager1/` - FortiManager1 license and config
  - `fortimanager2/` - FortiManager2 license and config
  - `fortigate/` - FortiGate license and config
- Versioning enabled
- Server-side encryption enabled (AES256)
- Public access blocked

### IAM Configuration
- IAM role for EC2 instances to access S3 bucket
- IAM policy granting read access to configuration bucket
- IAM instance profile attached to all Fortinet instances
- User data automatically configured with S3 bucket details and file paths

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with appropriate credentials
- AWS account with permissions to create VPCs, Transit Gateways, S3 buckets, and related resources
- Access to both us-west-2 (Oregon) and us-east-2 (Ohio) regions
- License files and configuration files in the project directory:
  - `FGVM8VTM25000613.lic` - FortiGate license
  - `FMG-VMTM25014032.lic` - FortiManager1 license
  - `FMG-VMTM25014033.lic` - FortiManager2 license
  - `fortigate.txt` - FortiGate configuration
  - `fortimanager1.txt` - FortiManager1 configuration
  - `fortimanager2.txt` - FortiManager2 configuration

## File Structure

```
.
├── main.tf              # Provider configuration
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── vpc.tf              # VPC resources
├── subnets.tf          # Subnet resources
├── igw.tf              # Internet Gateway resources
├── route-tables.tf     # Route table resources and associations
├── transit-gateway.tf  # Transit Gateway and peering resources
├── ec2.tf              # EC2 instances and security groups
├── iam.tf              # IAM roles and policies for S3 access
├── s3.tf               # S3 bucket and file uploads
├── README.md           # This file
├── FGVM8VTM25000613.lic       # FortiGate license file
├── FMG-VMTM25014032.lic       # FortiManager1 license file
├── FMG-VMTM25014033.lic       # FortiManager2 license file
├── fortigate.txt              # FortiGate configuration file
├── fortimanager1.txt          # FortiManager1 configuration file
└── fortimanager2.txt          # FortiManager2 configuration file
```

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the planned changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

4. To destroy all resources:
```bash
terraform destroy
```

## Variables

| Name | Description | Default |
|------|-------------|---------|
| `oregon_region` | Oregon region | `us-west-2` |
| `ohio_region` | Ohio region | `us-east-2` |
| `oregon_vpc_cidr` | CIDR block for Oregon VPC | `10.1.0.0/16` |
| `ohio_vpc_cidr` | CIDR block for Ohio VPC | `10.2.0.0/16` |
| `oregon_subnet_cidr` | CIDR block for Oregon public subnet | `10.1.1.0/24` |
| `ohio_subnet_cidr` | CIDR block for Ohio public subnet | `10.2.1.0/24` |
| `project_name` | Project name for resource tagging | `tgw-multiregion` |
| `instance_type` | EC2 instance type for FortiManager | `m5.large` |
| `fortigate_instance_type` | EC2 instance type for FortiGate | `c5.large` |

## Outputs

- `oregon_vpc_id` - Oregon VPC ID
- `ohio_vpc_id` - Ohio VPC ID
- `oregon_tgw_id` - Oregon Transit Gateway ID
- `ohio_tgw_id` - Ohio Transit Gateway ID
- `tgw_peering_attachment_id` - Transit Gateway Peering Attachment ID
- `oregon_subnet_id` - Oregon Public Subnet ID
- `ohio_subnet_id` - Ohio Public Subnet ID
- `fortimanager_oregon_instance_id` - Oregon FortiManager1 Instance ID
- `fortimanager_oregon_public_ip` - Oregon FortiManager1 Public IP
- `fortimanager_oregon_private_ip` - Oregon FortiManager1 Private IP
- `fortimanager_ohio_instance_id` - Ohio FortiManager2 Instance ID
- `fortimanager_ohio_public_ip` - Ohio FortiManager2 Public IP
- `fortimanager_ohio_private_ip` - Ohio FortiManager2 Private IP
- `fortigate_ohio_instance_id` - Ohio FortiGate Instance ID
- `fortigate_ohio_public_ip` - Ohio FortiGate Public IP
- `fortigate_ohio_private_ip` - Ohio FortiGate Private IP
- `s3_bucket_name` - S3 Bucket name for Fortinet configuration files
- `s3_bucket_arn` - S3 Bucket ARN for Fortinet configuration files

## Customization

You can customize the deployment by creating a `terraform.tfvars` file:

```hcl
project_name       = "my-project"
oregon_vpc_cidr    = "10.10.0.0/16"
ohio_vpc_cidr      = "10.20.0.0/16"
oregon_subnet_cidr = "10.10.1.0/24"
ohio_subnet_cidr         = "10.20.1.0/24"
instance_type            = "m5.xlarge"
fortigate_instance_type  = "c5.xlarge"
```

## Notes

- Transit Gateway peering takes a few minutes to become fully active
- Ensure your AWS credentials have permissions for both regions
- Transit Gateway data transfer charges apply for cross-region traffic
- Public subnets are configured with `map_public_ip_on_launch = true`
- FortiManager instances are deployed with m5.large instance type by default
- FortiGate instance is deployed with c5.large instance type (BYOL licensing)
- **Important**: You must accept the Fortinet FortiManager and FortiGate AWS Marketplace terms before deployment
- Security groups allow HTTPS (443), HTTP (80), SSH (22), FortiManager registration (541), and inter-region VPC traffic
- FortiManager and FortiGate instances are accessible via public IPs for management
- License and configuration files are automatically uploaded to S3 during deployment
- S3 bucket has versioning and encryption enabled for security
- EC2 instances have IAM roles with S3 read access to retrieve licenses and configs
- User data is automatically configured with JSON containing bucket, region, license, and config paths

## Cost Considerations

This infrastructure will incur charges for:
- Transit Gateway hourly charges (per TGW)
- Transit Gateway attachments (VPC attachments and peering attachment)
- Data transfer between regions
- EC2 instances (2x m5.large FortiManager + 1x c5.large FortiGate running 24/7)
- FortiManager licensing from AWS Marketplace
- FortiGate BYOL licensing (bring your own license - license not included)
- EBS volumes (50GB gp3 per FortiManager, 30GB gp3 for FortiGate)
- S3 bucket storage and requests
- Standard AWS resource charges (VPCs, subnets, etc.)

## FortiManager Access

After deployment, you can access the FortiManager instances:

**Oregon FortiManager1:**
- Public IP: `terraform output fortimanager_oregon_public_ip`
- HTTPS: `https://<public-ip>`
- Default credentials: Check Fortinet documentation

**Ohio FortiManager2:**
- Public IP: `terraform output fortimanager_ohio_public_ip`
- HTTPS: `https://<public-ip>`
- Default credentials: Check Fortinet documentation

**Ohio FortiGate:**
- Public IP: `terraform output fortigate_ohio_public_ip`
- HTTPS: `https://<public-ip>`
- HTTP: `http://<public-ip>`
- Default credentials: Check Fortinet documentation
- **Note**: BYOL license required - apply your FortiGate license after initial setup

## S3 Bucket Access

The S3 bucket contains license and configuration files organized by instance:

**View bucket contents:**
```bash
aws s3 ls s3://$(terraform output -raw s3_bucket_name)/
```

**Download files:**
```bash
# FortiManager1 files
aws s3 cp s3://$(terraform output -raw s3_bucket_name)/fortimanager1/FMG-VMTM25014032.lic .
aws s3 cp s3://$(terraform output -raw s3_bucket_name)/fortimanager1/fortimanager1.txt .

# FortiManager2 files
aws s3 cp s3://$(terraform output -raw s3_bucket_name)/fortimanager2/FMG-VMTM25014033.lic .
aws s3 cp s3://$(terraform output -raw s3_bucket_name)/fortimanager2/fortimanager2.txt .

# FortiGate files
aws s3 cp s3://$(terraform output -raw s3_bucket_name)/fortigate/FGVM8VTM25000613.lic .
aws s3 cp s3://$(terraform output -raw s3_bucket_name)/fortigate/fortigate.txt .
```
# aws-fmg-geo-ha
