#!/usr/bin/env bash

# Install all language servers to ~/.local/share/nvim/bun

BUN_PREFIX="$HOME/.local/share/nvim/bun"
BUN_BIN="$BUN_PREFIX/bin"

use_bun(){
    if ! command -v bun &> /dev/null
    then
        echo "Bun could not be found, please install Bun first."
        exit
    fi
    # Check if BUN_BIN is in PATH
    if ! echo "$PATH" | grep -q "$BUN_BIN"; then
        echo "Warning: $BUN_BIN is not in your PATH."
        echo "Add this line to your shell profile (e.g., ~/.bashrc or ~/.zshrc):"
        echo "export PATH=\"$BUN_BIN:\$PATH\""
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
    if ! bun pm ls --global --prefix "$BUN_PREFIX" | grep -w "$package_name" &>/dev/null
    then
        echo "Installing $package_name with Bun at $BUN_PREFIX..."
        bun add -g "$package_name" --prefix "$BUN_PREFIX" &
        loader_pid=$!
        show_loader "$loader_pid"
        wait "$loader_pid"
        if bun pm ls --global --prefix "$BUN_PREFIX" | grep -w "$package_name" &>/dev/null; then
            echo "$package_name installed with Bun."
            # Special case: typescript-language-server needs typescript
            if [ "$package_name" = "typescript-language-server" ]; then
                if ! bun pm ls --global --prefix "$BUN_PREFIX" | grep -w "typescript" &>/dev/null; then
                    echo "Also installing typescript with Bun for typescript-language-server..."
                    bun add -g typescript --prefix "$BUN_PREFIX" &
                    loader_pid=$!
                    show_loader "$loader_pid"
                    wait "$loader_pid"
                    if bun pm ls --global --prefix "$BUN_PREFIX" | grep -w "typescript" &>/dev/null; then
                        echo "typescript installed with Bun."
                    else
                        echo "Error: typescript failed to install with Bun."
                        echo "Trying pacman for typescript..."
                        sudo pacman -S --noconfirm typescript
                        if pacman -Q typescript &>/dev/null; then
                            echo "typescript installed with pacman."
                        else
                            echo "Error: typescript failed to install with Bun and pacman."
                        fi
                    fi
                fi
            fi
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
        # Always check typescript if typescript-language-server is already installed
        if [ "$package_name" = "typescript-language-server" ]; then
            if ! bun pm ls --global --prefix "$BUN_PREFIX" | grep -w "typescript" &>/dev/null; then
                echo "typescript-language-server is installed, but typescript is missing. Installing typescript..."
                bun add -g typescript --prefix "$BUN_PREFIX" &
                loader_pid=$!
                show_loader "$loader_pid"
                wait "$loader_pid"
                if bun pm ls --global --prefix "$BUN_PREFIX" | grep -w "typescript" &>/dev/null; then
                    echo "typescript installed with Bun."
                else
                    echo "Error: typescript failed to install with Bun."
                    echo "Trying pacman for typescript..."
                    sudo pacman -S --noconfirm typescript
                    if pacman -Q typescript &>/dev/null; then
                        echo "typescript installed with pacman."
                    else
                        echo "Error: typescript failed to install with Bun and pacman."
                    fi
                fi
            fi
        fi
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