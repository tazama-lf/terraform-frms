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
