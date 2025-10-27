# 23-October-2025
# Local Terraform tests

# Mac command prompt
PS1='%1~ $ '

# Login to Azure
az login --tenant pietronromanolive.onmicrosoft.com 
	
# Set a specific Subscription
az account set -s 8f45e7ec-8404-4723-aa20-fc58a7c4c120

# CD into the target terraform folder

cd modules/aca-basic

# Init
terraform init

# Plan and save the infra changes into tfplan file
terraform plan -out tfplan

## show the tfplan file
terraform show -json tfplan
terraform show -json tfplan >> tfplan.json
cat tfplan.json | jq -r '(.resource_changes[] | [.change.actions[], .type, .name]) | @tsv'
	
	
# Apply
terraform apply tfplan
	
# Destroy: 
terraform destroy
