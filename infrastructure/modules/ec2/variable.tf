variable "img_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-0d06c73ba195c1c0c"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# variable "key" {
#   description = "SSH key pair name for EC2 instances"
#   type        = string
#   default     = "june18"
# }

variable "profile_arn" {
  description = "IAM role ARN for the EC2 instances"
  type        = string
}

variable "ecs_sg" {
  description = "Security groups for the ECS instances"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}