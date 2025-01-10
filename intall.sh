#!/bin/bash
START="n"
echo "Realy want to start?:"

read START 
if [[ $START="n" ]] || [[ $START="N" ]];
then
  exit 1
else
  pacstrap -K /mnt base base-devel linux linux-firmware sudo neovim networkmanager efibootmgr zsh git ntp
  genfstab -U -p /mnt >> /mnt/etc/fstab
  arch-chroot /mnt
  ln -sf /usr/share/zoneinfo/Europe/Moscow /etc/localtime
  hwclock --systohc
  timedatectl set-ntp true
  echo "ja_JP.UTF-8 UTF-8" >> /etc/locale.gen
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  echo "ru_RU.UTF-8 UTF-8" >> /etc/locale.gen
  locale-gen
  echo "nyarch" >> /etc/hostname
  mkinitcpio -P
  systemctl enable NetworkManager
  useradd -m -g users -G wheel -s /bin/zsh swrneko
  passwd swrneko
  passwd
  pacman -S grub
  mkdir /boot/efi
  echo "Need to edit visudo by 'EDITOR=nvim visudo'"
  echo "Need to mount boot drive to /boot/efi by command below"
  echo "mount /dev/sdxN /boot/efi"
  echo "After run script bootloader_install.sh"
  exit 0
fi
