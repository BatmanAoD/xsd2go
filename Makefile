GO=GO111MODULE=on go
GOBUILD=$(GO) build

all: build

build:
	$(GOBUILD) ./cli/gocomply_xsd2go

.PHONY: pkger vendor
pkger:
ifeq ("$(wildcard $(GOPATH)/bin/pkger)","")
	go get -u -v github.com/markbates/pkger/cmd/pkger
endif

ci-update-bundled-deps: pkger
	pkger -o pkg/template

vendor:
	$(GO) mod tidy
	$(GO) mod vendor
	$(GO) mod verify
