.PHONY:	backup help

help: ## Show this help
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

all: backup parsing copy ## Run all Tasks

backup: ## Run intersight_backup.py script
	@echo "#--------- Taking Backup ---------#"
	@python3 ./intersight_backup.py

parsing: ## Run parse_intersight_objects.py script
	@echo "#--------- Parse Json ---------#"
	@python3 ./parse_intersight_objects.py

copy: ## Copy intersight.auto.tfvars.json to restore dir
	@echo "#--------- Copy Var file to restore dir ---------#"
	@cp intersight.auto.tfvars.json ../restore/