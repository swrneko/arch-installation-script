#!/bin/bash
grub-install
grub-mkconfig -o /boot/grub/grub.cfg
pacman -S ly
systemctl enable ly
echo "Now you need to 'exit' and 'umount -R /mnt'. After it you can reboot."
