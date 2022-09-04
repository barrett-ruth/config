run() {
	echo
	echo "> $*"
	echo
	eval "$*"
}



before() {
run 'timedatectl set-ntp true'


# Partition disk
lsblk
vared -p 'Enter disk to partition: ' -c disk
run "cfdisk /dev/$disk"


# Format partitions
lsblk
vared -p 'Enter root partition suffix: ' -c root
vared -p 'Enter home partition suffix: ' -c home
vared -p 'Enter swap partition suffix: ' -c swap
vared -p 'Enter efi partition suffix: ' -c efi

run "mkfs.ext4 /dev/$disk$root"
run "mkfs.ext4 /dev/$disk$home"
run "mkswap /dev/$disk$swap"


# Mount partitions
run "mount /dev/$disk$root /mnt"
run "mount --mkdir /dev/$disk$home /mnt/home"
run "mount --mkdir /dev/$disk$efi /mnt/boot/efi"

# Enable swap volume
run "swapon /dev/$disk$swap"


run 'pacstrap /mnt base linux linux-firmware linux-headers man-db intel-ucode nvidia nvidia-utils xf86-video-intel iwd dhcpcd opendoas git zsh neovim grub efibootmgr os-prober ntfs-3g'


run 'genfstab -U /mnt >> /mnt/etc/fstab'


lsblk


echo
echo '**********************************************************************'
echo "run 'cd /; mv /root/dots /mnt; arch-chroot /mnt; zsh dots/install.zsh'"
echo '**********************************************************************'
echo
}



mid() {
vared -p 'Enter timezone: [Region/city]: ' -c timezone
run "ln -sf '/usr/share/zoneinfo/$timezone' /etc/localtime"


run 'hwclock --systohc'


# Set locales
run "sed -i '/^#en_US.UTF-8 UTF-8/ s|^#*||' /etc/locale.gen"
run "echo 'LANG=en_US.UTF-8' > /etc/locale.conf"


vared -p 'Enter hostname: ' -c hostname
run "echo $hostname > /etc/hostname"


run 'mv dots/misc/hosts /etc'
sed -i "s|{HOST}|$hostname|g" /etc/hosts


# Configure users
run 'passwd'
vared -p 'Enter username: ' -c username
run "useradd -m $username"
run "usermod -aG wheel,storage,power $username"
run "passwd $username"


run 'systemctl enable dhcpcd.service'
run 'systemctl enable iwd.service'


# Configure grub
sed -i '/^#GRUB_DISABLE_OS_PROBER=false/ s|^#*||' /etc/default/grub
sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT/ s|"$| ibt=off"|' /etc/default/grub
run 'grub-install --target=x86_64-efi --bootloader-id=grub --recheck'
run 'grub-mkconfig -o /boot/grub/grub.cfg'


# Relocate dots
run "mv dots /home/$username"


echo
echo '***************************************************************'
echo "run 'exit; umount -lR /mnt; reboot' and remove the flash drive."
echo '***************************************************************'
echo
}



post() {
    # Get last of packages
    run 'doas pacman -S gcc libxft libxinerama make pkgconf which'

    # opendoas
    sed -i "s|{USERNAME}|$username|g" dots/misc/doas.conf
    run 'doas mv dots/misc/doas.conf /etc'
    run 'ln -s /usr/bin/doas /usr/bin/sudo'

    # nvidia
    run 'chmod +x dots/misc/nvidia.shutdown'
    run 'doas mv dots/misc/nvidia.shutdown /usr/lib/systemd/system-shutdown'
    run 'doas mv dots/misc/nvidia.hook /etc/pacman.d/hooks'
    # todo: add nvidia modules and rebuild mkinitcpio

    doas sed -i '/^#HookDir/ s|^#*||' /etc/pacman.conf
    doas sed -i '/^#ParallelDownloads/ s|^#*||' /etc/pacman.conf

    run 'doas mv dots/misc/dash.hook /etc/pacman.d/hooks'
    run 'doaa mv dots/misc/zshenv /etc/zsh'

    # Rebuild grub config to recognize Windows Boot Manager
    run 'doas grub-mkconfig -o /boot/grub/grub.cfg'


    # Misc cleanup
    rm -rf .bash* .cache .lesshst

    # Individual program configs
    run 'mkdir -p .config .local/share/nvim .local/bin'
    for e in git nvim python rg sioyek templates tmux X11 yarn zsh; do
        run "mv dots/$e .config"
    done
    
    # neovim
    run 'mv .config/nvim/spell.encoding.add .local/share/nvim'
    run 'git clone https://github.com/savq/paq-nvim ~/.local/share/nvim/site/pack/paqs/start/paq-nvim'
    cd .config/nvim
    for e in 'init.lua' plugin after; do
        mv "$e" "t$e"
    done
    run 'nvim lua/paqs/paq.lua -c "so|PaqInstall|q"'
    for e in 'init.lua' plugin after; do
        mv "t$e" "$e"
    done
    cd
    
    # zsh
    chsh -s "$(which zsh)"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.config/zsh/zsh-syntax-highlighting
   

    # fzf
    git clone https://github.com/junegunn/fzf ~/.config/fzf
    cd .config/fzf
    ./install --xdg --no-update-rc --no-fish --no-bash --completion --key-bindings
    nvim -c '%s/\~\/\.ssh/\~\/\.config\/.ssh/g|wq' shell/completion.zsh
    cd
    
    run 'mv dots/fonts .local/share'
    run 'mv dots/scripts .local/bin'
    run 'git clone https://github.com/tmux-plugins/tmux-resurrect .config/tmux/tmux-resurrect'
    run 'ln -s .config/git .config/fd'

    # suckless programs
    mkdir dev; cd dev
    git clone https://github.com/barrett-ruth/sl.git; cd sl
    for e in dmenu dwm dwmb st; do
        cd "$e"
        TERMINFO=~/.local/share/terminfo LC_ALL= make install
        make clean
        cd ..
    done
    cd
    
    git clone https://github.com/barrett-ruth/wp.git


    run 'rm -rf dots'
}



vared -p 'before, mid, or post install? [b/m/p] ' -c installation_status
case "$installation_status" in
b)
	before
	;;
m)
	mid
	;;
p)
	post
	;;
esac
