
terraform {
  source = "${get_terragrunt_dir()}/../module/clusterAutoscaler"
}


# Indicate the input values to use for the variables of the module.
inputs = {
  cluster_name              = dependency.eks.outputs.eks_cluster_name
  cluster_oidc_issuer_url   = dependency.eks.outputs.eks_cluster_oidc_issuer_url
  oidc_provider_arn         = dependency.eks.outputs.eks_oidc_provider_arn
}

dependency "eks" {
  config_path = "${get_terragrunt_dir()}/../eks"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"] # Configure mock outputs for the "init", "validate", "plan" commands that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs = {
  eks_cluster_name = "fake_eks_cluster_name"
  eks_cluster_identity_oidc_issuer = "fake_cluster_identity_oidc_issuer"
  eks_cluster_identity_oidc_issuer_arn = "fake_cluster_identity_oidc_issuer_arn"
  }
}
