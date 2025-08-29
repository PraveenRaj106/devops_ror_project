variable "private_subnet_ids" {
  description = "List of private subnet IDs for the RDS instance"
  type        = list(string)
}

variable "db_sg" {
  description = "Security group for the RDS instance"
  type        = string
}

variable "identifier" {
  type        = string
  description = "Identifier for the RDS instance"
  # default     = "my-rds-instance"
}

variable "instance_class" {
  type = string
  description = "Instance type for the RDS instance"
  # default = "db.t3.micro"
}

variable "engine" {
  type        = string
  description = "Database engine for the RDS instance"
  # default     = "postgres"
}

variable "engine_version" {
  type        = string
  description = "Version of the database engine"
  # default     = "13.21"
}

variable "storage" {
  type = number
  description = "Storage size for the RDS instance (in GB)"
  # default = 20
}

variable "multi_az" {
  type        = bool
  description = "Enable Multi-AZ for the RDS instance"
  default     = true
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot before deleting the RDS instance"
  # default     = false
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
