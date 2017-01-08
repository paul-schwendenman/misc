#!/bin/bash

nano -w /etc/default/grub
grub-install /dev/sda
grub-install --recheck /dev/sda

yes | sudo apt-get install --reinstall libdebian-installer4
sudo os-prober
sudo update-grub
