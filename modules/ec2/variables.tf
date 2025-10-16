variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 1
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "user_data" {
  description = "User data script"
  type        = string
  default     = ""
}

variable "root_volume_type" {
  description = "Root block device volume type"
  type        = string
  default     = "gp3"
}

variable "root_volume_size" {
  description = "Root block device volume size (GiB)"
  type        = number
  default     = 8
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}
