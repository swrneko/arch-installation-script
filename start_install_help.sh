#!/bin/bash

echo "
mkfs.vfat -F32 /dev/sda1
mkswap /dev/sda2 -L 'swap'
swapon /dev/sda2
mkfs.btrfs /dev/sda3
mount /dev/sda3 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@home
umount -R /mnt 
mount -o subvol=@,compress=zstd /dev/sda3 /mnt
mkdir /mnt/home
mount -o subvol=@home,compress=zstd /dev/sda3 /mnt/home
mkfs.btrfs /dev/sdb1
mount /dev/sdb1 /mnt
btrfs su cr /mnt/@
mount /dev/sdb1 /mnt
subvol=@,compress=zstd /dev/sdb1 /mnt/home/Games
"
