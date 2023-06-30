# Create the VPC
module "vpc" {
  count  = var.create_vpc ? 1 : 0
  source = "./modules/vpc"

  # Set the VPC name
  vpc_name = local.vpc_name

  # Set the cluster name
  cluster_name = local.cluster_name
}

# Create the EKS cluster
module "eks" {
  count  = var.create_eks ? 1 : 0
  source = "./modules/eks"

  cluster_name = local.cluster_name

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets

  enable_ebs_csi_driver = true
}

# Create the ECR repository
module "ecr" {
  count  = var.create_ecr ? 1 : 0
  source = "./modules/ecr"

  # Set the project name
  project_name = var.project_name
}
