module "S3" {
  source        = "./modules/S3"
  bucket_name   = var.bucket_name
  force_destroy = var.force_destroy
}

module "Dynamodb" {
  source     = "./modules/Dynamodb"
  table_name = var.table_name
}
module "Network" {
  source                              = "./modules/Network"
  region                              = var.region
  vpc_cidr                            = var.vpc_cidr
  enable_dns_support                  = var.enable_dns_support
  enable_dns_hostnames                = var.enable_dns_hostnames
  enable_classiclink                  = var.enable_classiclink
  preferred_number_of_public_subnets  = var.preferred_number_of_public_subnets
  preferred_number_of_private_subnets = var.preferred_number_of_private_subnets
  private_subnets                     = [for i in range(1, 8, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
  public_subnets                      = [for i in range(2, 5, 2) : cidrsubnet(var.vpc_cidr, 8, i)]
}

module "ALB" {
  source             = "./modules/ALB"
  name               = "project18-ext-alb"
  vpc_id             = module.Network.vpc_id
  public-sg          = module.SG.ALB-sg
  private-sg         = module.SG.IALB-sg
  public-sbn-1       = module.Network.public_subnets-1
  public-sbn-2       = module.Network.public_subnets-2
  private-sbn-1      = module.Network.private_subnets-1
  private-sbn-2      = module.Network.private_subnets-2
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
}

module "SG" {
  source = "./modules/SG"
  vpc_id = module.Network.vpc_id
}


module "ASG" {
  source            = "./modules/ASG"
  ami-web           = var.ami
  ami-bastion       = var.ami
  ami-nginx         = var.ami
  desired_capacity  = 2
  min_size          = 2
  max_size          = 2
  web-sg            = [module.SG.web-sg]
  bastion-sg        = [module.SG.bastion-sg]
  nginx-sg          = [module.SG.nginx-sg]
  wordpress-alb-tgt = module.ALB.wordpress-tgt
  nginx-alb-tgt     = module.ALB.nginx-tgt
  tooling-alb-tgt   = module.ALB.tooling-tgt
  instance_profile  = module.Network.instance_profile
  public_subnets    = [module.Network.public_subnets-1, module.Network.public_subnets-2]
  private_subnets   = [module.Network.private_subnets-1, module.Network.private_subnets-2]
  keypair           = var.keypair

}

# # Module for Elastic Filesystem; this module will creat elastic file system in the webservers availablity
# # zone and allow traffic fro the webservers

module "EFS" {
  source       = "./modules/EFS"
  efs-subnet-1 = module.Network.private_subnets-1
  efs-subnet-2 = module.Network.private_subnets-2
  efs-sg       = [module.SG.datalayer-sg]
  account_no   = var.account_no
}

# # RDS module; this module will create the RDS instance in the private subnet

module "RDS" {
  source          = "./modules/RDS"
  db-password     = var.master-password
  db-username     = var.master-username
  db-sg           = [module.SG.datalayer-sg]
  private_subnets = [module.Network.private_subnets-3, module.Network.private_subnets-4]
}

# The Module creates instances for jenkins, sonarqube abd jfrog
module "Compute" {
  source          = "./modules/Compute"
  region          = var.region
  ami             = var.ami
  ami-jenkins     = lookup(lookup(var.ami_ids, var.region, {}), "jenkins", var.ami)
  ami-sonar       = lookup(lookup(var.ami_ids, var.region, {}), "sonar", var.ami)
  ami-jfrog       = lookup(lookup(var.ami_ids, var.region, {}), "jfrog", var.ami)
  subnets-compute = module.Network.public_subnets-1
  sg-compute      = [module.SG.ALB-sg]
  keypair         = var.keypair
}
