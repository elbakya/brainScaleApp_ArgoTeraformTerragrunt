data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

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


module "cluster_autoscaler" {
  source = "git::https://github.com/DNXLabs/terraform-aws-eks-cluster-autoscaler.git"
  
  enabled = true

  cluster_name                     = var.cluster_name
  cluster_identity_oidc_issuer     = var.cluster_oidc_issuer_url
  cluster_identity_oidc_issuer_arn = var.oidc_provider_arn
  aws_region                       = var.aws_region
  helm_chart_version               = "9.35.0"

}
