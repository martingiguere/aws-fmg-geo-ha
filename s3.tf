# Random string for unique S3 bucket name
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# S3 Bucket for Fortinet configuration files and licenses
resource "aws_s3_bucket" "fortinet_config" {
  bucket = "${var.project_name}-fortinet-config-${random_string.bucket_suffix.result}"

  tags = {
    Name    = "${var.project_name}-fortinet-config"
    Project = var.project_name
  }
}

# Enable versioning for the bucket
resource "aws_s3_bucket_versioning" "fortinet_config" {
  bucket = aws_s3_bucket.fortinet_config.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Enable encryption for the bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "fortinet_config" {
  bucket = aws_s3_bucket.fortinet_config.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Block public access to the bucket
resource "aws_s3_bucket_public_access_block" "fortinet_config" {
  bucket = aws_s3_bucket.fortinet_config.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Upload FortiManager1 license file
resource "aws_s3_object" "fortimanager1_license" {
  bucket = aws_s3_bucket.fortinet_config.id
  key    = "fortimanager1/FMG-VMTM25014032.lic"
  source = "${path.module}/FMG-VMTM25014032.lic"
  etag   = filemd5("${path.module}/FMG-VMTM25014032.lic")

  tags = {
    Name     = "FortiManager1 License"
    Instance = "fortimanager1"
    Project  = var.project_name
  }
}

# Upload FortiManager1 configuration file
resource "aws_s3_object" "fortimanager1_config" {
  bucket = aws_s3_bucket.fortinet_config.id
  key    = "fortimanager1/fortimanager1.txt"
  source = "${path.module}/fortimanager1.txt"
  etag   = filemd5("${path.module}/fortimanager1.txt")

  tags = {
    Name     = "FortiManager1 Config"
    Instance = "fortimanager1"
    Project  = var.project_name
  }
}

# Upload FortiManager2 license file
resource "aws_s3_object" "fortimanager2_license" {
  bucket = aws_s3_bucket.fortinet_config.id
  key    = "fortimanager2/FMG-VMTM25014033.lic"
  source = "${path.module}/FMG-VMTM25014033.lic"
  etag   = filemd5("${path.module}/FMG-VMTM25014033.lic")

  tags = {
    Name     = "FortiManager2 License"
    Instance = "fortimanager2"
    Project  = var.project_name
  }
}

# Upload FortiManager2 configuration file
resource "aws_s3_object" "fortimanager2_config" {
  bucket = aws_s3_bucket.fortinet_config.id
  key    = "fortimanager2/fortimanager2.txt"
  source = "${path.module}/fortimanager2.txt"
  etag   = filemd5("${path.module}/fortimanager2.txt")

  tags = {
    Name     = "FortiManager2 Config"
    Instance = "fortimanager2"
    Project  = var.project_name
  }
}

# Upload FortiGate license file
resource "aws_s3_object" "fortigate_license" {
  bucket = aws_s3_bucket.fortinet_config.id
  key    = "fortigate/FGVM8VTM25000613.lic"
  source = "${path.module}/FGVM8VTM25000613.lic"
  etag   = filemd5("${path.module}/FGVM8VTM25000613.lic")

  tags = {
    Name     = "FortiGate License"
    Instance = "fortigate"
    Project  = var.project_name
  }
}

# Upload FortiGate configuration file
resource "aws_s3_object" "fortigate_config" {
  bucket = aws_s3_bucket.fortinet_config.id
  key    = "fortigate/fortigate.txt"
  source = "${path.module}/fortigate.txt"
  etag   = filemd5("${path.module}/fortigate.txt")

  tags = {
    Name     = "FortiGate Config"
    Instance = "fortigate"
    Project  = var.project_name
  }
}
