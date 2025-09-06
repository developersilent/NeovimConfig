#!/usr/bin/env bash

BUN_PREFIX="$HOME/.local/share/nvim/bun"
BUN_BIN="$BUN_PREFIX/bin"
LST_FILE="$HOME/.config/nvim/land-server.lst"

remove_bun_package() {
    local package_name=$1
    if bun pm ls --global --prefix "$BUN_PREFIX" | grep -w "$package_name" &>/dev/null; then
        echo "Removing $package_name from Bun ($BUN_PREFIX)..."
        bun remove -g "$package_name" --prefix "$BUN_PREFIX"
    else
        echo "$package_name not found in Bun ($BUN_PREFIX)."
    fi
}

remove_pacman_package() {
    local package_name=$1
    if pacman -Q "$package_name" &>/dev/null; then
        echo "Removing $package_name with pacman..."
        sudo pacman -Rs --noconfirm "$package_name"
    else
        echo "$package_name not found in pacman."
    fi
}

main() {
    while IFS= read -r package || [ -n "$package" ]; do
        [[ -z "$package" || "$package" =~ ^# ]] && continue
        remove_bun_package "$package"
        remove_pacman_package "$package"
    done < "$LST_FILE"
    # Remove Bun prefix directory if empty
    if [ -d "$BUN_PREFIX" ] && [ -z "$(ls -A "$BUN_PREFIX")" ]; then
        echo "Removing empty Bun prefix directory: $BUN_PREFIX"
        rm -rf "$BUN_PREFIX"
    fi
}

main "$@"
