# terraform {
#   backend "s3" {
#     bucket         = "melkamu-dev-terraform-bucket"
#     key            = "global/s3/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#     encrypt        = true
#   }
# }


terraform {
  backend "remote" {
    organization = "melkamu-pbl-19"

    workspaces {
      name = "Packer-ami-pbl-19"
    }
  }
}