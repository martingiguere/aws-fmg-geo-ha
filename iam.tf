# IAM Role for EC2 instances to access S3 bucket
resource "aws_iam_role" "fortinet_s3_access" {
  name = "${var.project_name}-fortinet-s3-access"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name    = "${var.project_name}-fortinet-s3-access-role"
    Project = var.project_name
  }
}

# IAM Policy for S3 bucket access
resource "aws_iam_role_policy" "fortinet_s3_access" {
  name = "${var.project_name}-fortinet-s3-access-policy"
  role = aws_iam_role.fortinet_s3_access.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.fortinet_config.arn,
          "${aws_s3_bucket.fortinet_config.arn}/*"
        ]
      }
    ]
  })
}

# IAM Instance Profile
resource "aws_iam_instance_profile" "fortinet_s3_access" {
  name = "${var.project_name}-fortinet-s3-access-profile"
  role = aws_iam_role.fortinet_s3_access.name

  tags = {
    Name    = "${var.project_name}-fortinet-s3-access-profile"
    Project = var.project_name
  }
}
