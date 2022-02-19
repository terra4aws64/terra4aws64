
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
