#!/bin/bash

if [ "$(grep '^ID=' /etc/os-release)" != "ID=\"centos\"" ]; then
    exit 0
fi

yum -y install epel-release
