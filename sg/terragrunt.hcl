
terraform {
  source = "${get_terragrunt_dir()}"
}


# Indicate the input values to use for the variables of the module.
inputs = {
  sg_vpc_id = dependency.vpc.outputs.vpc_id
  sg_cluster_name = dependency.eks.outputs.eks_cluster_name
  sg_public_subnets = dependency.vpc.outputs.public_subnets
  sg_private_subnets = dependency.vpc.outputs.private_subnets
}

dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../vpc"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"] # Configure mock outputs for the "init", "validate", "plan" commands that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs = {
  vpc_id = "vpc-fake-id"
  public_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  }
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
