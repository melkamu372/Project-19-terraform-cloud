variable "region" {
  type        = string
  description = "The region to deploy resources"
}

variable "vpc_cidr" {
  type        = string
  description = "The VPC cidr"
}

variable "enable_dns_support" {
  type = bool
}

variable "enable_dns_hostnames" {
  type = bool
}

variable "enable_classiclink" {
  type = bool
}

variable "enable_classiclink_dns_support" {
  type = bool
}

variable "preferred_number_of_public_subnets" {
  # default =null
  type        = number
  description = "Number of public subnets"
}

variable "preferred_number_of_private_subnets" {
  # default = null
  type        = number
  description = "Number of private subnets"
}

variable "name" {
  type    = string
  default = "Project-18"

}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}

variable "environment" {
  type        = string
  description = "Environment"

}

variable "ami-bastion" {
  type        = string
  description = "AMI ID for the launch template"
}


variable "ami-web" {
  type        = string
  description = "AMI ID for the launch template"
}


variable "ami-nginx" {
  type        = string
  description = "AMI ID for the launch template"
}


variable "ami-sonar" {
  type        = string
  description = "AMI ID for the launch template"
}



variable "keypair" {
  type        = string
  description = "key pair for the instances"
}

variable "account_no" {
  type        = number
  description = "the aws account number"
}


variable "master-username" {
  type        = string
  description = "RDS admin username"
}

variable "master-password" {
  type        = string
  description = "RDS master password"
}

variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "force_destroy" {
  description = "Whether to force destroy the S3 bucket"
  type        = bool
  default     = false
}

# variable "ami_ids" {
#   description = "Map of AMI IDs per region"
#   type        = map(map(string))
# }