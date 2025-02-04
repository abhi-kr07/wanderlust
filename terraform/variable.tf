variable "aws-region" {
  description = "This will be the region where your EC2 will made"
  default     = "us-east-1"
}

variable "ami-id" {
  description = "This will be your AMI-ID of ubuntu machine"
  default     = "ami-0e2c8caa4b6378d8c"

}


variable "instance_type" {
  description = "This will be your instance type"
  default     = "t2.large"
}




