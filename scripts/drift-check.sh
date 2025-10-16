#!/bin/bash
set -e

# drift-check.sh: Check Terraform infrastructure drift for a given environment.
# Usage: ./drift-check.sh <environment>
# Example: ./drift-check.sh dev

ENVIRONMENT=$1

if [[ -z "$ENVIRONMENT" ]]; then
  echo "Error: No environment specified."
  echo "Usage: $0 <environment>"
  exit 1
fi

WORKDIR="$(dirname "$0")/../environments/$ENVIRONMENT"

echo "🔍 Checking drift for '$ENVIRONMENT' environment..."

# Initialize Terraform in the specified environment
cd "$WORKDIR"
terraform init -backend-config=backend.conf -input=false

# Generate a plan and capture the exit code:
# 0 = No changes, 1 = Error, 2 = Drift detected
terraform plan -detailed-exitcode -out=drift-$ENVIRONMENT.plan -input=false
EXIT_CODE=$?

if [[ $EXIT_CODE -eq 0 ]]; then
  echo "✅ No drift detected in '$ENVIRONMENT'."
  exit 0
elif [[ $EXIT_CODE -eq 2 ]]; then
  echo "⚠️  Drift detected in '$ENVIRONMENT'!"
  # Optionally, create a GitHub issue or send notification here:
  # gh issue create --title "Drift detected: $ENVIRONMENT" --body "Drift has been detected in the $ENVIRONMENT environment. Please remedy." --label drift
  exit 2
else
  echo "❌ Error checking drift. Exit code: $EXIT_CODE"
  exit $EXIT_CODE
fi
