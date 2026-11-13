terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  
  backend "s3" {
    bucket = "fs-nam-tfstate"
    key = "tfstate/terraform.tfstate"
    region = "ap-southeast-1"

  }

} 