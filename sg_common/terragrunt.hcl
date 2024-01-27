
terraform {
  source = "${get_terragrunt_dir()}"
}


# Indicate the input values to use for the variables of the module.
inputs = {
  sg_vpc_id = dependency.vpc.outputs.vpc_id
}


dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../vpc"
  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"] # Configure mock outputs for the "init", "validate", "plan" commands that are returned when there are no outputs available (e.g the module hasn't been applied yet.)
  mock_outputs = {
  vpc_id = "vpc-fake-id"
  }
}

