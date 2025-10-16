# Terraform IaC Framework

[![Build Status](https://github.com/AshokNaidu-Code/terraform-iac-framework/actions/workflows/terraform-ci.yml/badge.svg)](https://github.com/AshokNaidu-Code/terraform-iac-framework/actions/workflows/terraform-ci.yml)  
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Overview

This Terraform Infrastructure as Code Framework demonstrates enterprise-grade patterns and advanced DevOps practices for managing AWS infrastructure consistently across environments.

It features reusable modules, robust remote state management, automated drift detection, and a complete CI/CD pipeline with testing.

## Key Features

- **Modular Terraform Templates**: VPC, EC2, RDS, and Security Groups  
- **Remote State Management**: S3 backend with DynamoDB locking prevents state corruption  
- **Automated Drift Detection**: CI/CD workflow checks drift daily and reports inconsistencies  
- **Multi-Environment Support**: Dev, Staging, and Production environments with separate configs  
- **Input Validation**: Terraform validation blocks enforce configuration correctness  
- **Testing with Terratest**: Unit and integration tests for infrastructure reliability  
- **CI/CD Pipelines**: Automated validation, planning, application, and coverage tests

## Architecture Overview




flowchart LR
  subgraph State Management
    S3[S3 Bucket for Terraform State]
    DDB[DynamoDB Lock Table]
  end

  subgraph Modules
    VPC[VPC Module]
    EC2[EC2 Module]
    RDS[RDS Module]
    SG[Security Groups Module]
  end

  subgraph Environments
    DEV[Dev Environment]
    STG[Staging Environment]
    PROD[Production Environment]
  end

  subgraph CI_CD
    Validate[Validate & Plan]
    Apply[Apply Changes]
    Drift[Drift Detection]
  end

  State Management --> Environments
  Modules --> Environments
  Environments --> CI_CD

└── .gitignore


## Getting Started

### Prerequisites

- Terraform v1.0 or later  
- AWS CLI configured with appropriate credentials  
- GitHub repository access and secrets set for AWS credentials  

### Bootstrap Remote State

 ```bash

cd bootstrap
terraform init
terraform apply -auto-approve
```
This sets up the S3 bucket and DynamoDB table for remote state locking.

### Deploy Environments

Choose your environment directory and run:
 ```bash
cd environments/dev
terraform init -backend-config=backend.conf
terraform validate
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars -auto-approve
```
Repeat for `staging` and `prod` by changing directories.

### CI/CD Integration

- Pull Requests trigger formatting and validation checks  
- Merges to main trigger automated Terraform apply  
- Scheduled daily jobs run drift detection and report anomalies

## Testing

The repository includes Terratest Go tests for modules under `tests/unit`. Run locally with:
 ```bash
cd tests/unit
go test -v
 ```
 Or rely on the GitHub Actions pipeline for automated testing.

## CI/CD Integration
`terraform-check.yml`: Checks formatting, validation, and planning on pull requests.

`terraform-apply.yml`: Applies vetted changes on merges to main.

`drift-detection.yml`: Runs drift checks on a schedule and reports via GitHub issues.

## Contributing

Please fork the repo, create feature branches, commit your changes, and open pull requests against `main`. Ensure all CI checks pass before requesting reviews.

## License

This project is licensed under the MIT License - see [LICENSE](LICENSE) for details.
