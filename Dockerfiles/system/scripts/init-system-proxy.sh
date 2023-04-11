#!/bin/bash
set -euxo pipefail

proxy_host_array="host.docker.internal 172.26.16.1 172.17.0.1"
proxy_port_array="7890 8118"

## set container proxy
for proxy_host in ${proxy_host_array[@]}
do
    for proxy_port in ${proxy_port_array[@]}
    do
        telnet_output=`timeout 1 telnet $proxy_host $proxy_port 2>&1` || true
        telnet_refused_msg=`echo $telnet_output | grep "Connection refused" || true`
        telnet_host_unknown_msg=`echo $telnet_output | grep "Unknown host" || true`
        if [ -n "$telnet_output" ] && [ -z "$telnet_refused_msg" ] && [ -z "$telnet_host_unknown_msg" ]; then
            echo "export http_proxy=http://$proxy_host:$proxy_port" >> /etc/profile
            echo "export https_proxy=http://$proxy_host:$proxy_port" >> /etc/profile
            break
        fi
    done
    current_proxy=`cat /etc/profile | grep http_proxy || true`
    if [ -n "$current_proxy" ]; then
        break
    fi
done
