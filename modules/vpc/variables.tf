variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block."
  }
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) >= 1 && length(var.public_subnet_cidrs) <= 6
    error_message = "Must specify between 1 and 6 public subnet CIDR blocks."
  }
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)

  validation {
    condition     = length(var.private_subnet_cidrs) >= 1 && length(var.private_subnet_cidrs) <= 6
    error_message = "Must specify between 1 and 6 private subnet CIDR blocks."
  }
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}

variable "enable_dns_hostnames" {
  description = "Whether DNS hostnames are enabled in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Whether DNS support is enabled in the VPC"
  type        = bool
  default     = true
}
