
variable "aws_region" {
  type = string
}
variable "aws_account" {
  type = string
}
variable "aws_access_key" {
  type = string
}
variable "aws_secret_key" {
  type = string
}

variable "ssh_key_public_test" {
  type = string
}

terraform {

  backend "local" {}

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }

}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "vpc" {
  source          = "../../src/teraform-aws-vpc"
  vpc_name        = "test-vpc"
  bastion_enabled = true
  ec2_key         = var.ssh_key_public_test
}

module "aws_aurora" {
  source                    = "../../src/teraform-aws-aurora"
  aurora_cluster_identifier = "test-aurora"
  aurora_engine             = "aurora-mysql"
  aurora_engine_version     = "8.0"
  aurora_port               = 3306
  vpc_id                    = module.vpc.vpc_id
  vpc_az_names              = module.vpc.vpc_az_names
  vpc_subnet_db_ids         = module.vpc.vpc_subnet_db_ids
  vpc_subnet_app_cidrs      = module.vpc.vpc_subnet_app_cidrs
}
