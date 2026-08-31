#!/bin/bash

sudo pacman -Sy
echo ""
echo "Packages that can be upgraded:"
pacman -Qu
echo ""

pkgs=$(pacman -Qu | wc -l)

if [ $pkgs -eq 0 ]; then
    echo "All packages are up to date."
else
    read -p 'Press ENTER to upgrade packages' foo
    echo ""
    sudo pacman -Syu --noconfirm
    echo ""
fi

orphans=$(pacman -Qdtq)

if [ -n "$orphans" ]; then
    echo "The following packages are orphaned and can be removed:"
    echo "$orphans"
    echo ""
    read -p 'Press ENTER to remove orphaned packages' foo
    echo ""
#    sudo pacman -Rns $orphans
    sudo pacman -Rns --noconfirm $orphans
else
    echo "No orphaned packages to remove."
fi

echo ""
echo "Updating Flatpak packages..."

sudo flatpak update -y

echo "Updating Brave packages..."

chmod +x /home/ice/Brave-Browser-Manager-main/launcher.sh
sh /home/ice/Brave-Browser-Manager-main/launcher.sh


