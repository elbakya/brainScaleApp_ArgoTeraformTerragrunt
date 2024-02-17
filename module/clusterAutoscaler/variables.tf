variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "cluster_oidc_issuer_url" {
  type        = string
  description = "The OIDC issuer of the cluster"
}

variable "oidc_provider_arn" {
  type        = string
  description = "The OIDC provider of the cluster"
}

variable "aws_region" {
  type        = string
  default     = "eu-central-1"
  description = "The aws region"
}
