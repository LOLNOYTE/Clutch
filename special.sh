#!/usr/bin/env bash

echo "Enter Password to be used"
read PASS

echo "Enter Username"
read USER

loadkeys it
loadkeys us
iwctl
device list
station wlan0 connect AmbrinAbbas
exit

lsblk
echo "Enter partition to be used"
read LINUX
mkfs.ext4 ${LINUX}
mount ${LINUX} /mnt

pacstrap /mnt base iwd linux linux-firmware sof-firmware base-devel grub efibootmgr nano networkmanager
genfstab /mnt
genfstab /mnt > /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Asia/Dubai /etc/localtime
hwclock --systohc

sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "Arch" >> /etc/hostname

passwd
useradd -m -G wheel -s /bin/bash ${USER}
passwd ${USER}

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
su ${USER}
sudo pacman -Syu --noconfirm
exit

systemctl enable NetworkManager
systemctl enable iwd
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
sudo pacman -S plasma sddm konsole firefox dolphin
exit



umount -a
reboot



