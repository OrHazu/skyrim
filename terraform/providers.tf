terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.55.0"
    }
  }
  backend "s3" {
    bucket  = "tf-state-hazut"
    key     = "terraform.tfstate"
    region  = "eu-west-1"
    profile = "OrHaz"
  }
}

# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "aws" {
  region  = "eu-west-1"
  profile = "OrHaz"
}