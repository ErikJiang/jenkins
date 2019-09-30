PROJECTNAME=$(shell basename "$(PWD)")
IMAGE=wisecloud/jenkins:centos
VOLUME_PATH=/data/docker/jenkins

all: help

.PHONY: help run stop restart clear

## start    start jenkins server
run: stop
	docker pull ${IMAGE}
	mkdir -p ${VOLUME_PATH}
	docker run -d -u root --restart=always -p 88:8080 -p 50000:50000 -v ${VOLUME_PATH}:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --name=jenkins ${IMAGE}

## restart  restart jenkins server
restart:
	docker restart jenkins

## stop     stop jenkins server
stop:
	-docker rm -f jenkins

## clear    stop jenkins server & remove volume data (be careful!!!)
clear:
	-docker rm -f jenkins
	rm -rf ${VOLUME_PATH}

## help     print this help message and exit.
help: Makefile
	@echo "Choose a command run in "$(PROJECTNAME)":"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Valid target values are:"
	@echo ""
	@sed -n 's/^## //p' $<