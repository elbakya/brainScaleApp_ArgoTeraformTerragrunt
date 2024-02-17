output "eks_cluster_name" {
  value = var.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluster_auth_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "eks_cluster_oidc_issuer_url" {
  value = module.eks.cluster_oidc_issuer_url
}

output "eks_oidc_provider_arn" {
  value = module.eks.oidc_provider_arn
}

