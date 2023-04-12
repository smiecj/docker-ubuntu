#!/bin/bash

pushd /tmp

pkg="v${shell_tools_version}.tar.gz"
curl -LO ${github_url}/smiecj/shell-tools/archive/refs/tags/${pkg}
tar -xzvf ${pkg}
rm ${pkg}
pushd shell-tools-${shell_tools_version}
NET=${NET} make zsh
popd

rm -r shell-tools-${shell_tools_version}
popd