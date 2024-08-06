#!/usr/bin/env bash

echo "Please enter your Username"
read USER 

echo "Please enter your Full Name"
read NAME 

echo "Please enter your Password"
read PASSWORD 

echo "--------------------------------------"
echo "-- INSTALLING Base Arch Linux --"
echo "--------------------------------------"
pacstrap /mnt base base-devel linux linux-firmware sof-firmware base-devel grub efibootmgr nano networkmanager iwd

# fstab
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
ln -sf /usr/share/zoneinfo/Asia/Dubai /etc/localtime
hwclock --systohc
echo "-------------------------------------------------"
echo "Setup Language to US and set locale"
echo "-------------------------------------------------"
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=us" >> /etc/vconsole.conf
echo "Arch" >> /etc/hostname


echo ${1234} ${1234} | passwd 
useradd -m -G wheel -s /bin/bash ${NAME}
echo ${1234} ${1234} | passwd ${NAME}
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
su ${NAME}
sudo pacman -Syu --noconfirm
exit

systemctl enable NetworkManager
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

sudo pacman -S plasma sddm konsole firefox
sudo systemctl enable sddm 

exit 
umount -a
reboot















