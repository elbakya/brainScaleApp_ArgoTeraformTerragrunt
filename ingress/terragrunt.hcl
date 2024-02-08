
terraform {
  source = "${get_terragrunt_dir()}/../module/ingress"
}


# Indicate the input values to use for the variables of the module.
inputs = {
  ingress_name = "ingress-nginx"
  ingress_repo = "https://kubernetes.github.io/ingress-nginx"
  cluster_name = dependency.eks.outputs.eks_cluster_name
}

dependency "eks" {
  config_path = "${get_terragrunt_dir()}/../eks"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"] # Configure mock outputs for the "init", "validate", "plan" commands that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs = {
  eks_cluster_auth_data = "fake-eks_cluster_auth_data"
  eks_cluster_endpoint = "fake-eks_cluster_endpoint"
  eks_cluster_name = "fake_eks_cluster_name"
  }
}

