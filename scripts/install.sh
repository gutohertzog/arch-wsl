#!/bin/bash

# apenas um script simples para instalar os cacarecos do sistema
# ainda será melhorado

# primeiro é preciso instalar o pacote básico do Arch Linux, sem qualquer
# interface, depois basta seguir a ordem do script

# instala os pacotes do Gnome
sudo pacman -S baobab gdm gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-clocks gnome-color-manager gnome-contacts gnome-control-center gnome-disk-utility gnome-font-viewer gnome-keyring gnome-logs gnome-menus gnome-remote-desktop gnome-session gnome-settings-daemon gnome-shell gnome-shell-extensions gnome-system-monitor gnome-tweaks gnome-user-share gnome-weather gvfs gvfs-afc gvfs-dnssd gvfs-google gvfs-onedrive gvfs-smb gvfs-wsdd loupe nautilus sushi tecla tracker3-miners xdg-desktop-portal-gnome xdg-user-dirs-gtk

# instala pacotes da nvidia
sudo pacman -S nvidia nvidia-utils nvidia-settings

# instala pacotes suplementares
sudo pacman -S git p7zip fzf ripgrep zsh zoxide neofetch curl nm-connection-editor

# instala extensões do zsh
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab $ZSH_CUSTOM/plugins/fzf-tab

# instala os programas que serão usados
sudo pacman -S firefox kitty gvim code-oss keepassxc remmina pavucontrol

# instala extensões do code-oss
code-oss --install-extension vscodevim.vim
code-oss --install-extension vscode-icons-team.vscode-icons
code-oss --install-extension oderwat.indent-rainbow
code-oss --install-extension tomoki1207.vscode-pdf
code-oss --install-extension s-nlf-fh.glassit

# instala as fontes
sudo pacman -S ttf-cascadia-code-nerd ttf-cascadia-mono-nerd

# instala o gerenciador de pacotes aur
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd

# cursor oreo instala trocentos pacotes do GO, então ele é copiado e
# descompactado direto do meu repositório
rm -rf $HOME/.icons > /dev/null 2>&1
mkdir $HOME/.icons/
cp -r $HOME/arch-gnome/dotfiles/.icons/defaults $HOME/.icons/ > /dev/null 2>&1
for f in $HOME/arch-gnome/dotfiles/.icons/*.tar.gz; do tar xfv "$f" -C $HOME/.icons/; done

# clones para instalar os temas do sistema
mkdir -p $HOME/GitHub
cd $HOME/GitHub
# tema do grub
git clone https://github.com/vinceliuice/grub2-themes
# temas do sistema
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme
# sudo ./install.sh -t whitesur -i color -s 1080p -b
git clone https://github.com/vinceliuice/Orchis-theme
git clone https://github.com/EliverLara/Nordic
# ícones do sistema
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
git clone https://github.com/bikass/kora
cd kora
mv kora* $HOME/.local/share/icons
# papel de parede
git clone https://github.com/saint-13/Linux_Dynamic_Wallpapers

# carrega as configurações para o gnome
dconf load / < ~/arch-gnome/dotfiles/config/dconf/user-settings.conf

# https://github.com/StevenBlack/hosts
curl -o $HOME/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts
sudo mv /etc/hosts /etc/hosts.bak
sudo mv $HOME/hosts /etc/
sudo systemctl restart NetworkManager.service
