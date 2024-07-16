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
    profile =  "OrHaz"
  }
}

# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }

data "aws_eks_cluster_auth" "eks_cluster_auth" {
  depends_on = [aws_eks_cluster.eks-cluster]
  name       = aws_eks_cluster.eks-cluster.name
}

provider "kubernetes" {
  config_path = "~/.kube/config"
  host                   = data.aws_eks_cluster.eks-cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks_cluster_auth.token
}

provider "aws" {
  region  = "eu-west-1"
  profile = "OrHaz"
}