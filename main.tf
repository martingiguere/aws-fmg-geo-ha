terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}
# default AWS provider
provider "aws" {
  region = "us-east-2"
}


# Oregon provider (us-west-2)
provider "aws" {
  alias  = "oregon"
  region = var.oregon_region
}

# Ohio provider (us-east-2)
provider "aws" {
  alias  = "ohio"
  region = var.ohio_region
}
