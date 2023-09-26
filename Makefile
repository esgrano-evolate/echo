.DEFAULT_GOAL := help

# Variables
AWS_PROFILE := $(AWS_PROFILE)
ACCOUNT_ID ?= $(shell aws sts get-caller-identity | jq -r .Account)
REGION ?= eu-north-1

APPLICATION ?= hello
ECR_URL := $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com
DOCKER_IMAGE ?= $(ECR_URL)/$(APPLICATION)

# Commands
AWS = aws
VENV = venv
PYTHON = $(VENV)/bin/python
PIP = $(VENV)/bin/pip --disable-pip-version-check
FLAKE8 = $(VENV)/bin/flake8
DOCKER = docker

# Targets
$(PIP):
	@python3 -m venv $(VENV) || true

$(FLAKE8): $(PIP)
	@$(PIP) install -q flake8==4.0.1

## lint: Lint Python code.
lint: $(FLAKE8)
	$(call blue, " Linting lambda...")
	@$(FLAKE8) --ignore=W605,E501 hello.py

## build: Build the docker image in service
build: lint
	$(call blue,"# Running docker build...")
	@docker build -t $(DOCKER_IMAGE) .

## login.ecr: Login to ECR
login.ecr:
	$(AWS) ecr get-login-password --region $(REGION) | \
		docker login --username AWS --password-stdin $(ACCOUNT_ID).dkr.ecr.$(REGION).amazonaws.com

## push: Push an image to ECR
push:
	$(DOCKER) push $(DOCKER_IMAGE)

## create-repo: Create the ECR repository
create-repo:
	$(AWS) ecr create-repository --region $(REGION) \
		--repository-name $(APPLICATION)

## help: prints this help message
.PHONY: help
help: Makefile
	@echo
	$(call blue, " Choose a command run:")

	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo

# -- Helper Functions --
define blue
	@tput setaf 4
	@echo $1
	@tput sgr0
endef
