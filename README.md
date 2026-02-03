# AWS EKS Cluster with Terraform Cloud & GitHub Actions

This project demonstrates how to deploy an Amazon EKS cluster using Terraform, with state managed by Terraform Cloud and CI/CD automated by GitHub Actions.

## Subdirectories

- `terraform/`: Contains the Terraform configuration files.
  - `modules/vpc`: VPC module configuration.
  - `modules/eks`: EKS module configuration.
- `.github/workflows/`: Contains the GitHub Actions workflow definition.

## Prerequisites

1.  **AWS Account**: You need an AWS account with permissions to create VPCs, EKS clusters, and IAM roles.
2.  **Terraform Cloud Account**: A free account at [app.terraform.io](https://app.terraform.io).
3.  **GitHub Repository**: This code should be pushed to a GitHub repository.

## Setup Instructions

### 1. Terraform Cloud Setup

1.  Log in to Terraform Cloud.
2.  Create a new **Organization** (if you don't have one).
3.  Create a new **Workspace**:
    - Choose "API-driven workflow" or "CLI-driven workflow".
    - Name it `aws-eks-poc` (must match the name in `terraform/backend.tf`).
4.  **Configure Variables** in the Workspace:
    - Go to the "Variables" tab.
    - Add the following **Environment Variables** (mark them as sensitive):
        - `AWS_ACCESS_KEY_ID`: Your AWS Access Key.
        - `AWS_SECRET_ACCESS_KEY`: Your AWS Secret Key.
    - (Optional) Add Terraform Variables if you want to override defaults (e.g., `aws_region`).

### 2. Configure Local Terraform Backend
Update `terraform/backend.tf` with your actual organization name:

```hcl
terraform {
  backend "remote" {
    organization = "YOUR_ACTUAL_ORG_NAME_HERE" # <--- UPDATE THIS

    workspaces {
      name = "aws-eks-poc"
    }
  }
}
```

### 3. GitHub Actions Setup

1.  Generate a **Terraform Cloud API Token**:
    - Go to User Settings -> Tokens -> Create an API token.
2.  Add the token to your GitHub Repository Secrets:
    - Go to your Repo -> Settings -> Secrets and variables -> Actions.
    - Click "New repository secret".
    - Name: `TF_API_TOKEN`
    - Value: Paste your Terraform Cloud API Token.

## Usage

1.  **Push changes**:
    - Pushing to any branch will trigger `terraform fmt` and `terraform validate`.
    - Opening a **Pull Request** to `main` will trigger `terraform plan` and comment the plan on the PR.
2.  **Deploy**:
    - Merging the PR to `main` (or pushing directly to `main`) will trigger `terraform apply` to deploy the infrastructure.
3.  **Destroy**:
    - To destroy, you can queue a destroy plan manually in Terraform Cloud UI.

## Modules

- **VPC**: Creates a new VPC with public/private subnets.
- **EKS**: Deploys the EKS Control Plane and a Managed Node Group.
