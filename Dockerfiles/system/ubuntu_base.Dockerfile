ARG UBUNTU_VERSION
FROM ubuntu:${UBUNTU_VERSION}

# bash
SHELL ["/bin/bash", "-c"]

# default env
ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN=true

ARG ROOT_PWD=root!centos123
ARG TARGETARCH
ARG sources_list_file
ARG github_url
ARG s6_version
ARG shell_tools_version
# NET: for init scripts
ARG NET

COPY ./repo/sources*.list /tmp/
COPY ./scripts/init-*.sh /tmp/

# sources update
## install ca-certificates for other repo: https://askubuntu.com/a/1145374
RUN apt update && \
    apt -y install ca-certificates && \
    apt -y install gnupg2 && \
    sources_list_file_prefix=`echo ${sources_list_file} | sed 's#.list##g'` && \
    if [ -f /tmp/${sources_list_file_prefix}_${TARGETARCH}.list ]; then\
    sources_list_file=${sources_list_file_prefix}_${TARGETARCH}.list;\
    fi && \
    if [ "arm64" == "${TARGETARCH}" ]; then\
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5EDB1B62EC4926EA;\
    fi && \
    cp /tmp/${sources_list_file} /etc/apt/sources.list && \
    apt update && \

## remove some pkg to fix pkgProblemResolver error
    dependencies="perl libfile-spec-perl" && \
    for dep in ${dependencies[@]}; \
    do \
        echo "[test] to remove current dep: ${dep}"; \
        apt -y remove ${dep}; \
    done && \

## some dev tools
    dependencies="git openssh-server build-essential make cmake python3-pip lsof net-tools vim lrzsz zip unzip bzip2 git wget curl sudo passwd expect jq telnet net-tools rsync logrotate gettext" && \
    for dep in ${dependencies[@]}; \
    do \
        echo "[test] to install current dep: ${dep}"; \
        apt -y install ${dep}; \
    done && \
### git config
    git config --global pull.rebase false && \

## zsh
    bash /tmp/init-system-zsh.sh && \
## vim support utf-8
    echo "set encoding=utf-8 fileencodings=ucs-bom,utf-8,cp936" >> ~/.vimrc && \
## set login password
    echo root:${ROOT_PWD} | chpasswd && \
## history
    echo "export HISTCONTROL=ignoredups" >> /etc/profile && \
## timezone
    cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \

## s6
    bash /tmp/init-system-s6.sh && \
### check s6 is install success
    ls -l /init && \

## init scripts
    cp /tmp/init-system.sh /init-system && \
    cp /tmp/init-ssh.sh /init-ssh && \
    cp /tmp/init-service.sh /init-service && \
    chmod +x /init-* && \

## remove tmp files
    rm /tmp/sources*.list && \
    rm /tmp/init-*.sh

ENTRYPOINT ["/init-system"]