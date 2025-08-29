variable "vpc_id" {
  description = "VPC ID where the resources will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs"
  type        = list(string)
}

variable "alb_sg" {
  description = "Security group id of ALB"
  type        = string
}