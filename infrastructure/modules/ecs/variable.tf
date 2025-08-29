variable "ecs-name" {
  description = "IAM role for ECS instances"
  type        = string
  default     = "app-nginx"
}

variable "task-role" {
  description = "IAM role for the ECS task"
  type        = string
}

variable "app-container" {
  description = "Name of the container in the ECS task"
  type        = string
}

variable "app-img" {
  description = "Name of the container in the ECS task"
  type        = string
}

variable "nginx-container" {
  description = "Name of the Nginx container in the ECS task"
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



variable "log_name" {
  description = "value for log_name"
  type        = string
}

variable "tg_arn" {
  description = "ARN of the Application Load Balancer Target Group"
  type        = string
}

variable "asg_arn" {
  description = "ARN of the Auto Scaling Group"
  type        = string
}

variable "network_mode" {
  description = "value for network_mode"
  type        = string
  default     = "awsvpc"
}

variable "region" {
  description = "value for region"
  type        = string
  default     = "ap-south-1"
}

variable "cpu" {
  description = "The number of CPU units to reserve for the container"
  type        = number
  default     = 256
}

variable "memory" {
  description = "The amount of memory (in MiB) to present to the container"
  type        = number
  default     = 512
}


#Environment variable for rds
variable "RAILS_ENV" {
  description = "value for RAILS_ENV"
  type        = string
}

variable "DB_HOSTNAME" {
  description = "value for DB_HOST"
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