#!/bin/bash

pushd /tmp

curl -LO ${github_url}/smiecj/shell-tools/archive/refs/tags/v1.0.tar.gz
tar -xzvf v1.0.tar.gz
rm v1.0.tar.gz
pushd shell-tools-1.0
make zsh
popd

rm -r shell-tools-1.0
popd