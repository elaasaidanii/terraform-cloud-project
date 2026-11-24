terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    bucket       = "REPLACE_ME"
    key          = "dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = "cloud5"
      Environment = "dev"
      Owner       = "elaa"
      ManagedBy   = "Terraform"
    }
  }
}

module "network" {
  source = "../../modules/network"

  project_name             = "cloud5"
  environment              = "dev"
  azs                      = ["us-east-1a", "us-east-1b"]
  public_subnet_cidrs      = ["10.20.1.0/24", "10.20.2.0/24"]
  private_app_subnet_cidrs = ["10.20.11.0/24", "10.20.12.0/24"]
  private_db_subnet_cidrs  = ["10.20.21.0/24", "10.20.22.0/24"]
}

output "vpc_id" {
  value = module.network.vpc_id
}
