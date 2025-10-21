variable "oregon_region" {
  description = "Oregon region"
  type        = string
  default     = "us-west-2"
}

variable "ohio_region" {
  description = "Ohio region"
  type        = string
  default     = "us-east-2"
}

variable "oregon_vpc_cidr" {
  description = "CIDR block for Oregon VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "ohio_vpc_cidr" {
  description = "CIDR block for Ohio VPC"
  type        = string
  default     = "10.2.0.0/16"
}

variable "oregon_subnet_cidr" {
  description = "CIDR block for Oregon public subnet"
  type        = string
  default     = "10.1.1.0/24"
}

variable "ohio_subnet_cidr" {
  description = "CIDR block for Ohio public subnet"
  type        = string
  default     = "10.2.1.0/24"
}

variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "tgw-multiregion"
}

variable "instance_type" {
  description = "EC2 instance type for FortiManager"
  type        = string
  default     = "m5.large"
}

variable "fortigate_instance_type" {
  description = "EC2 instance type for FortiGate"
  type        = string
  default     = "c5.large"
}
