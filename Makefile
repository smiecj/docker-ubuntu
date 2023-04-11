ROOT := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
include $(ROOT)/Makefile.vars
include $(ROOT)/Makefile.vars.repo
export

hello:
	@echo "hello docker ubuntu!"
	@if [[ "${REPO}" != "" ]]; then echo "repo: ${REPO}"; fi
	@echo "ubuntu base image: ${IMAGE_BASE}"

build_base:
	bash ${build_script} ${cmd} ${platform} ./Dockerfiles/system/ubuntu_base.Dockerfile ${IMAGE_BASE} ./Dockerfiles/system

run_base:
	docker run -d -it --hostname test_ubuntu --name dev_ubuntu ${IMAGE_BASE}