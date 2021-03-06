#!/bin/bash

echo "--------------------------------------"
echo "      Starting openbox.sh             "
echo "--------------------------------------"


#Hosts
#echo "arch" >> /etc/hostname
#echo "127.0.0.1 localhost" >> /etc/hosts
#echo "::1       localhost" >> /etc/hosts
#echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts


echo "--------------------------------------"
echo "      Installing Graphics Driver(s)   "
echo "--------------------------------------"
#Graphics Drivers find and install
gpu_type=$(lspci)
if grep -E "NVIDIA|GeForce" <<< ${gpu_type}; then
    pacman -S nvidia nvidia-xconfig nvidia-utils --noconfirm --needed
elif lspci | grep 'VGA' | grep -E "Radeon|AMD"; then
    pacman -S xf86-video-amdgpu --noconfirm --needed
elif grep -E "Integrated Graphics Controller" <<< ${gpu_type}; then
    pacman -S libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa --needed --noconfirm
elif grep -E "Intel Corporation UHD" <<< ${gpu_type}; then
    pacman -S libva-intel-driver libvdpau-va-gl lib32-vulkan-intel vulkan-intel libva-intel-driver libva-utils lib32-mesa --needed --noconfirm
fi
#pacman -S --needed mesa


echo "--------------------------------------"
echo "      Installing Additional Packages  "
echo "--------------------------------------"
PKGS=(
	##DEVELOPMENT TOOLS
	'base-devel'		#base-devel 
	'linux-headers'		#linux-headers

	##SELECT DISPLAY SERVER
	##XORG			#Xorg
        'xorg-server'
        'xorg-xinit'

        'openbox'		#Window manager
        'obconf'		#Openbox Configuration Manager
        'arandr'		#Xrandr GUI

	##DISPLAY MANAGER
	'lightdm' 		#Lightdm
	'lightdm-gtk-greeter' 
	'lightdm-gtk-greeter-settings'


	##SELECT AUDIOSERVER
	##PIPEWIRE		#Pipewire
	'alsa-utils'
	'pavucontrol'
	'pipewire'
	'pipewire-alsa'
	'pipewire-pulse'
	'pipewire-jack'
	'playerctl'		#Keyboard controls for media
	##PULSEAUDIO		#Pulseaudio
	#'alsa-utils'
	#'pavucontrol'
	#'pulseaudio'
	
	##BLUETOOTH		#Bluetooth
	#'bluez' 
	#'bluez-utils'
	
	#'tlp'			#Laptop Power Saver
	#'cups'			#Printing
	'xterm' 		#Terminal
	'xfce4-terminal'	#Terminal
	'pcmanfm' 		#File Manager
	'firefox' 		#Browser

	'arc-gtk-theme'		#Theme
	'papirus-icon-theme'	#Icons
	'lxappearance-obconf'	#Theme manager
	'nitrogen'		#Wallpaper manager
	'dmenu'			#Launcher
	'ttf-dejavu'		#Font
	'ttf-liberation'	#Font
	'ttf-ubuntu-font-family' #Font
	'menumaker'		#Menu Configuration
	'picom'			#Compositor
	'git'			#Git
	
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --needed --noconfirm
done

#Other Packages
#dialog wpa_supplicant mtools dosfstools reflector  avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils  cups hplip  bash-completion openssh rsync reflector acpi acpi_call tlp  edk2-ovmf bridge-utils dnsmasq vde2 openbsd-netcat iptables-nft ipset 
#firewalld flatpak sof-firmware nss-mdns acpid ntfs-3g terminus-font virt-manager qemu qemu-arch-extra i3lock-color archlinux-wallpaper


echo "--------------------------------------"
echo "      Enabling Essential Services     "
echo "--------------------------------------"
systemctl enable NetworkManager
systemctl enable lightdm
#systemctl enable tlp
#systemctl enable bluetooth
#systemctl enable sshd
#systemctl enable cups.service #printer
#systemctl enable ntpd.service
#systemctl enable avahi-daemon
#systemctl enable reflector.timer
#systemctl enable fstrim.timer
#systemctl enable libvirtd
#systemctl enable firewalld
#systemctl enable acpid


echo "--------------------------------------"
echo "      openbox.sh is now complete      "
echo "--------------------------------------"
