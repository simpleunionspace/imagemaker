#!/bin/bash

if [ "$(grep '^ID=' /etc/os-release)" != "ID=\"ubuntu\"" ]; then
    exit 0
fi

apt -y install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
