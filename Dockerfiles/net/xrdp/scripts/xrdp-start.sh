#!/bin/bash
rm /var/run/xrdp/xrdp.pid
rm /var/run/xrdp/xrdp-sesman.pid
/usr/sbin/xrdp $XRDP_OPTIONS
/usr/sbin/xrdp-sesman $SESMAN_OPTIONS