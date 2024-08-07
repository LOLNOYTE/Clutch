#!/usr/bin/env bash

echo "Enter Password to be used"
read PASS

echo "Enter Username"
read USER

loadkeys it
loadkeys us

lsblk
echo "Enter partition to be used"
read LINUX
mkfs.ext4 ${LINUX}
mount ${LINUX} /mnt

pacstrap /mnt base iwd linux linux-firmware sof-firmware base-devel grub efibootmgr nano networkmanager
genfstab /mnt
genfstab /mnt > /mnt/etc/fstab
arch-chroot /mnt ln -sf /usr/share/zoneinfo/Asia/Dubai /etc/localtime
arch-chroot /mnt hwclock --systohc

arch-chroot /mnt sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
arch-chroot /mnt locale-gen
arch-chroot /mnt echo "LANG=en_US.UTF-8" >> /etc/locale.conf
arch-chroot /mnt echo "KEYMAP=us" >> /etc/vconsole.conf
arch-chroot /mnt echo "Arch" >> /etc/hostname

arch-chroot /mnt passwd
arch-chroot /mnt useradd -m -G wheel -s /bin/bash ${USER}
arch-chroot /mnt passwd ${USER}

arch-chroot /mnt sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
arch-chroot /mnt su ${USER}
arch-chroot /mnt sudo pacman -Syu --noconfirm

arch-chroot /mnt systemctl enable NetworkManager
arch-chroot /mnt systemctl enable iwd
arch-chroot /mnt grub-install --target=i386-pc /dev/sda
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg
arch-chroot /mnt sudo pacman -S plasma sddm konsole firefox dolphin
exit



umount -a
reboot



