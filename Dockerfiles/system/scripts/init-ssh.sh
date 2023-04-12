#!/bin/bash
mkdir -p /run/sshd
nohup /usr/sbin/sshd -D $SSHD_OPTS > /dev/null 2>&1 &