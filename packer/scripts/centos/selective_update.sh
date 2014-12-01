#!/bin/sh

yum -y update kernel openssh

echo "Rebooting the machine..."
reboot
sleep 60