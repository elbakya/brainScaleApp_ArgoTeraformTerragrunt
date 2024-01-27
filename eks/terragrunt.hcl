
terraform {
  source = "${get_terragrunt_dir()}"
}

# Indicate the input values to use for the variables of the module.
inputs = {
  vpc_id_for_eks = dependency.vpc.outputs.vpc_id
  vpc_public_subnets = dependency.vpc.outputs.public_subnets
  sg_id = dependency.sg_common.outputs.security_groups
}

dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../vpc"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"] # Configure mock outputs for the "init", "validate", "plan" commands that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs = {
  vpc_id = "vpc-fake-id"
  public_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  }
}

dependency "sg_common" {
  config_path = "${get_terragrunt_dir()}/../sg_common"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"] # Configure mock outputs for the "init", "validate", "plan" commands that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs = {
  security_groups = "security-fake-groups-id"
  }
}
