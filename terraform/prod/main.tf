provider "aws" {
  region = "ap-northeast-2"
}

terraform {
  required_version = ">= 1.9.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
  }

  backend "s3" {
    bucket  = "kkamji-app-terraform-state"
    key     = "kkamji-app/terraform.tfstate"
    region  = "ap-northeast-2"
    encrypt = true
  }
}

module "ecr" {
  source = "../modules/ecr"
  name   = "kkamji-app-backend"
}

module "vpc" {
  source                  = "../modules/vpc"
  name                    = "kkamji-app"
  vpc_availability_zones  = ["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c"]
  vpc_cidr                = "10.10.0.0/16"
  vpc_name                = "kkamji-app"
  public_subnet_suffix    = "kkamji-app-public"
  public_subnets_cidr     = ["10.10.100.0/24", "10.10.110.0/24", "10.10.120.0/24"]
  private_subnet_suffix   = "kkamji-app-private"
  private_subnets_cidr    = ["10.10.200.0/24", "10.10.210.0/24", "10.10.220.0/24"]
  map_public_ip_on_launch = true
  enable_dns_support      = true
  enable_dns_hostnames    = true
}