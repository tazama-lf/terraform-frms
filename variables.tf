variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "frms-infra"
}

variable "create_vpc" {
  description = "Create VPC"
  type        = bool
  default     = true
}

variable "create_eks" {
  description = "Create EKS cluster"
  type        = bool
  default     = true
}

variable "create_ecr" {
  description = "Create ECR repository"
  type        = bool
  default     = true
}
