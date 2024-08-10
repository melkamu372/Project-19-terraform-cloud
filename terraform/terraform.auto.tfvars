region = "us-east-1"

bucket_name   = "melkamu-prod-terraform-bucket"
force_destroy = true
table_name    = "terraform-locks"

vpc_cidr = "172.16.0.0/16"

enable_dns_support = true

enable_dns_hostnames = true
enable_classiclink   = false

enable_classiclink_dns_support      = false
preferred_number_of_public_subnets  = 2
preferred_number_of_private_subnets = 4

environment = "dev"

ami-web = "ami-0f52b35733fd9d953"

ami-bastion = "ami-041ae799ea3b965a2"

ami-nginx = "ami-06fc8c99aa46e502f"

ami-sonar = "ami-004159023bf335902"

keypair = "melkamu_key"

master-username = "melkamu"
master-password = "PassWord.1"
account_no = 736498736845
tags = {
  Owner-Email     = "melkamu372@gmail.com"
  Managed-By      = "Terraform"
  Billing-Account = "736498736845"
}
