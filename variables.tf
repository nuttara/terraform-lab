variable "aws_region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  default     = "t2.micro"
}
