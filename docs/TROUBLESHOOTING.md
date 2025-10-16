# TROUBLESHOOTING.md

## Common Errors & Resolutions

### 1. `Error: Reference to undeclared input variable`
- **Cause**: Module or root usage of a variable not defined in `variables.tf`.
- **Resolution**: Add a `variable "<name>" {}` block to the appropriate `variables.tf`. Ensure names match exactly.

### 2. `Error: Unsupported argument`
- **Cause**: Passing an argument into a module that isn’t declared.
- **Resolution**: Declare the corresponding `variable` in the module’s `variables.tf`, or remove the argument.

### 3. `Error: Duplicate resource` or `Invalid character`
- **Cause**: Typos or duplicate definitions in `.tf` files (e.g., `mian.tf` vs `main.tf`).
- **Resolution**: Rename files correctly, remove stray characters (e.g., `…`), and ensure unique resource names.

### 4. S3 Backend Region Mismatch (StatusCode: 301)
- **Cause**: `backend.conf` region does not match the S3 bucket’s actual region.
- **Resolution**: Update `region` in `backend.conf` to the bucket’s region. Verify with:
  ```bash
  aws s3api get-bucket-location --bucket <bucket-name>
  ```

### 5. Deprecated S3 Backend Parameter Warning
- **Message**: `The parameter "dynamodb_table" is deprecated. Use parameter "use_lockfile" instead.`
- **Resolution**: Continue using `dynamodb_table` (still supported) or switch to `use_lockfile`:
  ```hcl
  backend "s3" {
    bucket         = "..."
    key            = "..."
    region         = "..."
    use_lockfile   = true
  }
  ```

### 6. AWS Provider Version Mismatch
- **Cause**: Lock file version doesn’t match `required_providers` constraint.
- **Resolution**: Either update `version` in `provider.tf` to match the lock file (e.g., `~> 6.0`) or run:
  ```bash
  terraform init -upgrade
  ```

### 7. Invalid Credentials / 403 `InvalidClientTokenId`
- **Cause**: Incorrect or expired AWS credentials.
- **Resolution**:
  - Run `aws configure` to set correct Access Key and Secret.
  - Set environment variables: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
  - Verify with:
    ```bash
    aws sts get-caller-identity
    ```

### 8. Terraform Prompting for `common_tags`
- **Cause**: Declared as a required variable without default or input.
- **Resolution**: Remove `common_tags` from `variables.tf` in root modules and use `local.common_tags` instead.

### 9. Module Initialization Errors
- **Cause**: Missing module directories or incorrect `source` paths.
- **Resolution**: Verify folder structure matches module `source` references, e.g., `source = "../../modules/vpc"`.

## 10. Common AWS Issues

- IAM permission denied errors require policy review and adjustments.  
- Network restrictions affecting access to S3 or DynamoDB should be addressed.  

## 11. CI/CD Pipeline Failures

- Validate presence and correctness of all required secrets and environment variables.  
- Confirm working directories in pipeline steps are correct.  
- Ensure `terraform init` successfully completes before any validate or apply commands.

## 12. Revert and Recovery

- Backups of state files should be maintained.  
- Restore previous state file versions if needed.  
- Use `terraform state` commands for advanced state file manipulation.

## 12. Support & Reporting

- Check AWS CloudTrail and CloudWatch logs for errors.  
- Open issues in this repository with detailed logs and error messages for help.

## Debugging Tips
- Always check syntax with:
```bash
  terraform fmt -check
  terraform validate
```
- Inspect plan output for hints:
 ```bash
  terraform plan -out=tfplan
  terraform show -json tfplan | jq .
  ```
- Use verbose logging:
 ```bash
  TF_LOG=DEBUG terraform apply
  ```

## Support Channels
- Review module code in `modules/`
- Check environment configs in `environments/`
- Consult Terraform documentation: https://developer.hashicorp.com/terraform/docs
