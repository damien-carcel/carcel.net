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

# Environment Variables

IO ?=

# Application dependencies

yarn.lock: package.json
	@yarn install

node_modules: yarn.lock
	@yarn install --frozen-lockfile --check-files

.PHONY: install
install: node_modules ## Install project dependencies

.PHONY: upgrade
upgrade: ## Upgrades project dependencies to their latest version (works only if project dependencies were installed at least once)
	@yarn upgrade-interactive --latest
	@yarn upgrade

# Serve and build-prod

.PHONY: serve
serve: node_modules #main# Run the application using Vue CLI development server (hit CTRL+c to stop the server)
	@yarn serve

.PHONY: build
build: node_modules #main# Build the production artifacts
	@yarn build

# Tests

.PHONY: tests
tests: node_modules #main# Execute all the tests
	@echo ""
	@echo "|----------------------|"
	@echo "| Lint the stylesheets |"
	@echo "|----------------------|"
	@echo ""
	@make stylelint
	@echo ""
	@echo "|--------------------------|"
	@echo "| Lint the TypeScript code |"
	@echo "|--------------------------|"
	@echo ""
	@make eslint IO=--no-fix
	@echo ""
	@echo "|-------------------|"
	@echo "| Check type errors |"
	@echo "|-------------------|"
	@echo ""
	@make type-check
	@echo ""
	@echo "|----------------|"
	@echo "| Run unit tests |"
	@echo "|----------------|"
	@echo ""
	@make unit
	@echo ""
	@echo "|----------------------|"
	@echo "| Run end-to-end tests |"
	@echo "|----------------------|"
	@echo ""
	@make end-to-end IO="--headless"

.PHONY: stylelint
stylelint: ## Lint the LESS code
	@yarn run -s stylelint

.PHONY: eslint
eslint: ## Lint and fix the TypeScript code — use "make eslint IO=--no-fix" to only show errors
	@yarn run -s lint

.PHONY: type-check
type-check: ## Look for type errors
	@yarn run type-check

.PHONY: unit
unit: ## Run unit tests — use "make unit IO=path/to/test" to run a specific test
	@JEST_JUNIT_OUTPUT_DIR="tests/reports" JEST_JUNIT_OUTPUT_NAME="unit.xml" yarn run test:unit ${IO}

.PHONY: end-to-end
end-to-end: ## Run end to end tests — use "make end-to-end IO='--headless'" for headless mode and "make end-to-end IO='--headless -s path/to/test'" to run a specific test (works only in headless mode)
	@MOCHA_FILE="tests/reports/e2e.xml" yarn run test:e2e ${IO}
