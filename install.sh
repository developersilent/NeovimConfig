#!/usr/bin/env bash

# Install all language servers

use_bun(){
    if ! command -v bun &> /dev/null
    then
        echo "Bun could not be found, please install Bun first."
        exit
    fi
}

show_loader() {
    local pid=$1
    local spin='-\|/'
    local i=0
    while kill -0 "$pid" 2>/dev/null; do
        i=$(( (i+1) %4 ))
        printf "\rInstalling... ${spin:$i:1}"
        sleep 0.1
    done
    printf "\rInstallation complete!   \n"
}

install_bun_package(){
    local package_name=$1
    if ! bun pm ls --global | grep -w "$package_name" &>/dev/null
    then
        echo "Installing $package_name with Bun..."
        bun add -g "$package_name" &
        loader_pid=$!
        show_loader "$loader_pid"
        wait "$loader_pid"
        if bun pm ls --global | grep -w "$package_name" &>/dev/null; then
            echo "$package_name installed with Bun."
            return
        fi
        echo "Bun failed to install $package_name, trying pacman..."
        sudo pacman -S --noconfirm "$package_name"
        if pacman -Q "$package_name" &>/dev/null; then
            echo "$package_name installed with pacman."
        else
            echo "Error: $package_name failed to install with Bun and pacman."
        fi
    else
        echo "$package_name is already installed."
    fi
}

main() {
    use_bun
    local lst_file="/home/user101/.config/nvim/land-server.lst"
    while IFS= read -r package || [ -n "$package" ]; do
        # Skip empty lines and comments
        [[ -z "$package" || "$package" =~ ^# ]] && continue
        install_bun_package "$package"
    done < "$lst_file"
}

main "$@"