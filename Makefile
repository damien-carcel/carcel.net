SHELL = bash

.PHONY: help
help:
	@echo "-----------------"
	@echo "- Main commands -"
	@echo "-----------------"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?#main# .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?#main# "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "----------------------"
	@echo "- Secondary commands -"
	@echo "----------------------"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

# Application dependencies

.PHONY: install
install: ## Install project dependencies
ifeq ($(wildcard yarn.lock),)
	@echo "Install the Node modules according to package.json"
	@yarn install
endif
	@echo "Install the Node modules according to yarn.lock"
	@yarn install --frozen-lockfile --check-files

.PHONY: upgrade
upgrade: ## Upgrades project dependencies to their latest version (works only if project dependencies were installed at least once)
	@yarn upgrade-interactive --latest
	@yarn upgrade

# Serve and build-prod

.PHONY: serve
serve: #main# Run the application using webpack-dev-server (hit CTRL+c to stop the server)
	@yarn serve

.PHONY: build
build: ## Build the production artifacts
	@yarn build

.PHONY: pull
pull: ## Pull all Docker images used in docker-compose.yaml
	@docker-compose pull

.PHONY: up
up: pull build #main# Serve the application in production-like mode through Docker
	@docker-compose up -d
	@xdg-open http://carcel.docker.localhost

.PHONY: down
down: #main# Stop and remove the Docker containers
	@docker-compose down -v

# Tests

.PHONY: tests
tests: install #main# Execute all the tests
	@echo ""
	@echo "|----------------------|"
	@echo "| Lint the stylesheets |"
	@echo "|----------------------|"
	@echo ""
	@make stylelint

.PHONY: stylelint
stylelint: ## Lint the LESS code
	@yarn run -s stylelint
