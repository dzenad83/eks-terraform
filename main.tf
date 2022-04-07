#==================================================================================================
# Locals and Conditional Values
#==================================================================================================
locals {
  aws-account-id        = "345193624082"
  region                = "us-west-2"
  project-name          = "nydata"
  number-of-azs         = 3
  vpc-cidr              = terraform.workspace == "dev" ? "10.0.0.0/16" : terraform.workspace == "stg" ? "172.16.0.0/16" : terraform.workspace == "prod" ? "192.168.0.0/16" : ""
  az-ids                = join(",", ["usw2-az2", "usw2-az3"])
  public-subnets-cidrs  = terraform.workspace == "dev" ? join(",", ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]) : terraform.workspace == "stg" ? join(",", ["172.16.10.0/24", "172.16.20.0/24", "172.16.30.0/24"]) : terraform.workspace == "prod" ? join(",", ["192.168.10.0/24", "192.168.20.0/24", "192.168.30.0/24"]) : ""
  private-subnets-cidrs = terraform.workspace == "dev" ? join(",", ["10.0.110.0/24", "10.0.120.0/24", "10.0.130.0/24"]) : terraform.workspace == "stg" ? join(",", ["172.110.30.0/24", "172.16.120.0/24", "172.16.130.0/24"]) : terraform.workspace == "prod" ? join(",", ["192.168.110.0/24", "192.168.120.0/24", "192.168.130.0/24"]) : ""
  ec2-natgw-ami         = "ami-003af5caf3be398ca"
  ec2-key-pair-name     = "key-ec2-nydata"
  node_instance_type    = terraform.workspace == "dev" ? "t3.medium" : terraform.workspace == "stg" ? "t3.large" : terraform.workspace == "prod" ? "c5.large" : ""
}


#==================================================================================================
# TF Backend and Required Providers
#==================================================================================================
terraform {
  backend "s3" {
    region = "us-west-2"
    bucket = "tfstate-dzenad"
    key    = "infrastructure.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.8.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.9.0"
    }
    github = {
      source  = "hashicorp/github"
      version = "4.3.1"
      # source  = "integrations/github"
      # version = "~> 4.17.0"
      /*Newer versions are having known issues with creating github_repository_webhook
      resource. At the moment of writing these configurations, latest GitHub provider
      version was 4.17.0 and the source was integrations/github
      */
    }
  }
  required_version = "~> 1.1.2"
}

#==================================================================================================
# Modules
#==================================================================================================
module "kms_key" {
  source = "./modules/kms_key"

  env            = terraform.workspace
  region         = local.region
  project-name   = local.project-name
  aws-account-id = local.aws-account-id
}

module "vpc" {
  source = "./modules/vpc"

  env                   = terraform.workspace
  region                = local.region
  project-name          = local.project-name
  vpc-cidr              = local.vpc-cidr
  number-of-azs         = local.number-of-azs
  az-ids                = local.az-ids
  public-subnets-cidrs  = local.public-subnets-cidrs
  private-subnets-cidrs = local.private-subnets-cidrs
  ec2-natgw-ami         = local.ec2-natgw-ami
  ec2-key-pair-name     = local.ec2-key-pair-name
  kms-key               = module.kms_key.kms-key.arn

  depends_on = [
    module.kms_key
  ]
}

module "eks" {
  source = "./modules/eks"

  vpc-id             = module.vpc.vpc-params.id
  vpc-cidr           = module.vpc.vpc-params.cidr_block
  private-subnet-ids = module.vpc.private-subnets.*.id
  project-name       = local.project-name
  node_instance_type = local.node_instance_type
  ec2-key-pair-name  = local.ec2-key-pair-name


}
