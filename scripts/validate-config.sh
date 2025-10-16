#!/bin/bash
set -e

echo "🔍 Validating Terraform configurations..."

# Validate each environment
for env in dev staging prod; do
  echo "Validating $env environment..."
  cd "environments/$env"
  terraform init -backend=false
  terraform validate
  terraform fmt -check
  cd ../..
done

# Validate modules
for module in modules/*/; do
  echo "Validating $(basename "$module") module..."
  cd "$module"
  terraform init -backend=false
  terraform validate
  terraform fmt -check
  cd ../..
done

echo "✅ All configurations are valid!"
