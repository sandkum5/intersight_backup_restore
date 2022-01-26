.PHONY: help

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: plan apply destroy rm ## Run terraform plan, apply, destory, and remove state files

plan: ## Terraform Plan
	@echo "#------ Terraform Plan ------#"
	@terraform plan

apply: ## Terraform Apply
	@echo "#------ Create Resource ------#"
	@terraform apply -auto-approve

destroy: ## Terraform Destroy
	@echo "#------ Destory Resource ------#"
	@terraform destroy -auto-approve

rm: ## Remove terraform tfstate files
	@echo "#------ Remove tf state files ------#"
	@rm terraform.tfstate terraform.tfstate.backup