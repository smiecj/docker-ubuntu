#!/bin/bash

ps -ef | grep "/usr/sbin/xrdp" | grep -v grep | awk '{print $2}' | xargs -I {} bash -c "sudo kill -9 {}"
ps -ef | grep "/usr/sbin/xrdp-sesman" | grep -v grep | awk '{print $2}' | xargs -I {} bash -c "sudo kill -9 {}"