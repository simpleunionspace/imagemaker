#!/bin/bash

rm -rf /media
rm -rf /mnt
rm -rf /srv
rm -rf /tmp/*
rm -rf /home
rm -rf /*.log
rm -rf /etc/X11
rm -rf /var/cache/*
rm -rf /var/log/*

rm -rf /etc/localtime
ln -s /usr/share/zoneinfo/UTC /etc/localtime
