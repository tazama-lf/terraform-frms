<!-- SPDX-License-Identifier: Apache-2.0 -->

# FRMS Terraform

[![tfsec](https://github.com/frmscoe/terraform-frms/actions/workflows/tfsec.yml/badge.svg)](https://github.com/frmscoe/terraform-frms/actions/workflows/tfsec.yml)

## Overview

This repository contains the terraform code to create a Kubernetes cluster on AWS. The cluster is created using EKS and the nodes are created using EC2. The cluster is created in a public subnet and the nodes are created in a private subnet.

## Table of Contents

- [FRMS Terraform](#frms-terraform)
  - [Overview](#overview)
  - [Table of Contents](#table-of-contents)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Architecture](#architecture)
    - [Dependencies](#dependencies)
    - [Single Command Provisioning](#single-command-provisioning)
    - [Provisioning](#provisioning)
    - [Uninstalling](#uninstalling)

## Getting Started

### Prerequisites

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
  - [AWS IAM Account with Permissions](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) (optional - for testing)

### Architecture

![Architecture](./docs/images/Architecture.png)

The deployment sequence diagram can be found [here](./docs/Architecture.md).

### Dependencies

- VPC
- EKS Cluster

  - EKS Addon: EBS CSI Driver | The EBS CSI driver addon is added to the Amazon EKS cluster to allow Kubernetes to use Amazon Elastic Block Store (EBS) volumes as persistent volumes in the cluster.

- ECR Repository

The dependencies can be found [here](./docs/Dependencies.md). It has been generated using terraform-docs

### Single Command Provisioning

```bash
make all
```

### Provisioning

```bash
terraform init
terraform apply
```

### Uninstalling

```bash
terraform destroy
```

If you get an error related nodegroups, you can delete the nodegroup and cluster manually.

```bash
aws eks list-nodegroups --cluster-name frms-eks
aws eks delete-nodegroup --cluster-name frms-eks --nodegroup-name frms-eks-default-winning-chipmunk
aws eks delete-cluster --name frms-eks
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.47.0 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | ~> 2.2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4.3 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ecr"></a> [ecr](#module\_ecr) | ./modules/ecr | n/a |
| <a name="module_eks"></a> [eks](#module\_eks) | ./modules/eks | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ./modules/vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name | `string` | `"frms-infra"` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS region | `string` | `"eu-west-2"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for EKS control plane |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Kubernetes Cluster Name |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | Security group ids attached to the cluster control plane |
| <a name="output_region"></a> [region](#output\_region) | AWS region |
<!-- END_TF_DOCS -->