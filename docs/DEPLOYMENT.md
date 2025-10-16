# DEPLOYMENT.md

## Prerequisites

- Terraform ≥ 1.0
- AWS CLI configured with appropriate credentials
- GitHub repository access
- `jq` CLI (optional, for parsing outputs)

## Deployment Steps by Environment

### 1. Bootstrap Infrastructure

```bash
cd bootstrap
terraform init
terraform apply -auto-approve
```  
This creates the S3 state bucket and DynamoDB lock table.

### 2. Development Environment

```bash
cd environments/dev
terraform init -backend-config=backend.conf
terraform validate
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars -auto-approve
```  

### 3. Staging Environment

```bash
cd environments/staging
terraform init -backend-config=backend.conf
terraform validate
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars -auto-approve
```  

### 4. Production Environment

```bash
cd environments/prod
terraform init -backend-config=backend.conf
terraform validate
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars -auto-approve
```  

## CI/CD Integration

- **Pull Requests** trigger formatting, validation, and plan via `terraform-check.yml`.
- **Merges to Main** run `terraform-apply.yml` to apply changes to production.

## Rollback Strategy

1. Identify the last successful commit in GitHub.
2. Revert to that commit:
```bash
git revert <commit-hash>
git push origin main
```
3. Workflow will re-run and restore infrastructure to the previous state.

## Cleanup

To destroy all resources:

```bash
# Destroy production
cd environments/prod
terraform destroy -var-file=terraform.tfvars -auto-approve

# Destroy staging
dld environments/staging
terraform destroy -var-file=terraform.tfvars -auto-approve

# Destroy dev
cd environments/dev
terraform destroy -var-file=terraform.tfvars -auto-approve

# Destroy bootstrap
cd ../../bootstrap
terraform destroy -auto-approve
```