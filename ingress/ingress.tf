provider "helm" {
  kubernetes {
     # Configuration to connect to the EKS cluster
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
     # Use the AWS CLI to obtain an EKS cluster token
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name, "--output", "json"]
      command     = "aws"
    }
  }
}

provider "kubernetes" {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name, "--output", "json"]
      command     = "aws"
    }
  }

# Fetch EKS cluster information

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

resource "kubernetes_namespace" "nginx_ingress" {
  metadata {
    name = "${var.ingress_name}"
  }
}

module "nginx_ingress" {
  source  = "terraform-module/release/helm"
  version = "2.7.0"

  namespace  = kubernetes_namespace.nginx_ingress.metadata.0.name
  repository = "${var.ingress_repo}"
  app = {
    name          = "ingress-nginx"
    version       = "4.1.0"
    chart         = "ingress-nginx"
    force_update  = true
    wait          = false
    recreate_pods = false
    deploy        = 1
  }

  set = [
    {
      name  = "replicaCount"
      value = 2
    }
  ]
}
