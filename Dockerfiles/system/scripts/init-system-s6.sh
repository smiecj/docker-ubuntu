#!/bin/bash
set -eux pipefail

# install s6
## https://github.com/just-containers/s6-overlay#installation

arch="x86_64"

system_arch=`uname -p`
if [[ "aarch64" == "$system_arch" ]]; then
    arch="arm"
fi

pushd /tmp

curl -LO ${github_url}/just-containers/s6-overlay/releases/download/${s6_version}/s6-overlay-${arch}.tar.xz

curl -LO ${github_url}/just-containers/s6-overlay/releases/download/${s6_version}/s6-overlay-noarch.tar.xz

curl -LO ${github_url}/just-containers/s6-overlay/releases/download/${s6_version}/s6-overlay-symlinks-arch.tar.xz

curl -LO ${github_url}/just-containers/s6-overlay/releases/download/${s6_version}/s6-overlay-symlinks-noarch.tar.xz

curl -LO ${github_url}/just-containers/s6-overlay/releases/download/${s6_version}/syslogd-overlay-noarch.tar.xz

tar -C / -Jxpf s6-overlay-noarch.tar.xz

tar -C / -Jxpf s6-overlay-${arch}.tar.xz

tar -C / -Jxpf s6-overlay-symlinks-arch.tar.xz

tar -C / -Jxpf s6-overlay-symlinks-noarch.tar.xz

tar -C / -Jxpf syslogd-overlay-noarch.tar.xz

rm s6-overlay*.tar.xz
rm syslogd-overlay-noarch.tar.xz

popd