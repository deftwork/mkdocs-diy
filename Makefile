SNAME ?= mkdocs-diy
RNAME ?= elswork/$(SNAME)
VER ?= `cat VERSION`
BASE ?= alpine
BASENAME ?= python:$(BASE)
#RUTA ?= $(CURDIR)
RUTA ?= /home/pirate/docker/www/cv-eloy.deft.work
SITE ?= 
TO ?= /src
TARGET_PLATFORM ?= linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/386,linux/arm/v7,linux/arm/v6
# linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/arm/v7,linux/arm/v6
NO_CACHE ?= 
# NO_CACHE ?= --no-cache

# HELP
# This will output the help for each task

.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# DOCKER TASKS

# Build image

debug: ## Debug the container
	docker build -t $(RNAME):debug \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(VER) .
build: ## Build the container
	mkdir -p builds
	docker build $(NO_CACHE) -t $(RNAME):$(VER) -t $(RNAME):latest \
	--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(VER) \
	. > builds/$(VER)_`date +"%Y%m%d_%H%M%S"`.txt
bootstrap: ## Start multicompiler
	docker buildx inspect --bootstrap
debugx: ## Buildx in Debug mode
	docker buildx build \
	--platform ${TARGET_PLATFORM} \
	-t $(RNAME):debug --pull \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(VER) .
buildx: ## Buildx the container
	docker buildx build $(NO_CACHE) \
	--platform ${TARGET_PLATFORM} \
	-t $(RNAME):$(VER) -t $(RNAME):latest --pull --push \
	--build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
	--build-arg VCS_REF=`git rev-parse --short HEAD` \
	--build-arg BASEIMAGE=$(BASENAME) \
	--build-arg VERSION=$(VER) .
upgrade: ## Upgrade local version
	docker pull $(RNAME):latest
serve: ## Preview and live modify with auto-reloading $(RUTA)/$(SITE)
	docker run -it --rm -v $(RUTA)/$(SITE):/mkdocs -p 7777:7777 $(RNAME) mkdocs serve -a 0.0.0.0:7777
mkbuild: ## Generate website static files
	docker run -it --rm -v $(RUTA)/$(SITE):/mkdocs -p 7777:7777 $(RNAME) mkdocs build
mkbuildx: ## Generate website static files
	docker run --rm -it -v $(RUTA)/$(SITE):/docs squidfunk/mkdocs-material build	
mkhelp: ## MkDocs commands help
	docker run -it --rm  $(RNAME) mkdocs -h
helpserve: ## MkDocs serve command help
	docker run -it --rm $(RNAME) mkdocs serve -h
version: ## Display MkDocs version
	docker run -it --rm $(RNAME):debug mkdocs -V
browse: ## Start browserleft
	docker run -d \
	--name chrome2 \
	-e "ENABLE_DEBUGGER=false" \
	-e "DISABLE_AUTO_SET_DOWNLOAD_BEHAVIOR=true" \
	-e "DEFAULT_BLOCK_ADS=true" \
	-p 3000:3000 \
	browserless/chrome:latest
screenshot: ## Start screenshot
	docker run -d \
	--name screenshot2 \
	-e "REMOTE_BROWSER=ws://172.17.0.1:3000" \
	-p 5001:5000 \
	statically/screenshot:latest
wget: ## Wget PDFs
	wget https://localhost:5001/screenshot/pdf/cv-eloy.deft.work
getpdf: browse screenshot wget
kill: ## Stop containers
	docker stop AAA