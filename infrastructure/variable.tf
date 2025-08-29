variable "region" {
  description = "AWS region"
  type        = string
}


variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "az" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "image" {
  description = "Docker image for the ECS task"
  type        = string
  default     = "nginx:latest"
}

variable "app-img" {
  description = "Name of the container in the ECS task"
  type        = string
}

variable "nginx-img" {
  description = "Name of the container in the ECS task"
  type        = string
}

variable "task-count" {
  description = "Number of tasks to run"
  type        = number
  default     = 1
}

variable "task-role" {
  description = "IAM role for the ECS task"
  type        = string
}

variable "img-id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-0d06c73ba195c1c0c"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key" {
  description = "SSH key pair name for EC2 instances"
  type        = string
  default     = "june18"
}

variable "ecs-name" {
  description = "IAM role for ECS instances"
  type        = string
  default     = "app-nginx"
}

variable "network_mode" {
  description = "Network mode for the ECS task"
  type        = string
}

variable "app-container" {
  description = "Name of the container in the ECS task"
  type        = string
}

variable "nginx-container" {
  description = "Name of the Nginx container in the ECS task"
  type        = string
}


#RDS Variables 
variable "identifier" {
  type        = string
  description = "Identifier for the RDS instance"
}

variable "instance_class" {
  type = string
  description = "Instance type for the RDS instance"
}

variable "engine" {
  type        = string
  description = "Database engine for the RDS instance"
}

variable "engine_version" {
  type        = string
  description = "Version of the database engine"
}

variable "storage" {
  type = number
  description = "Storage size for the RDS instance (in GB)"
}

variable "multi_az" {
  type        = bool
  description = "Enable Multi-AZ for the RDS instance"
  default     = true
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot before deleting the RDS instance"
  default     = true
}



#Environment variable for rds
variable "RAILS_ENV" {
  description = "value for RAILS_ENV"
  type        = string
}



variable "DB_NAME" {
  description = "value for DB_NAME"
  type        = string
}

variable "DB_USERNAME" {
  description = "value for DB_USER"
  type        = string
}

variable "DB_PASSWORD" {
  description = "value for DB_PASSWORD"
  type        = string
}

variable "DB_PORT" {
  description = "value for DB_PORT"
  type        = string
}
