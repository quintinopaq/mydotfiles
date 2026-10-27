#!/usr/bin/env bash
# ==============================================================================
#  install_desktop.sh - Sincronizador de Dotfiles para Desktop (PC)
# ==============================================================================
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo "🖥️  Instalando Dotfiles - Perfil Desktop"
echo "📂 Diretório de origem: $DOTFILES_DIR"

mkdir -p "$HOME/.config"

# Função utilitária para link seguro com backup
link_target() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ]; then
        echo "  ⚠ Origem não encontrada: $src (pulando)"
        return 0
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        # Se já é o symlink correto, não faz nada
        if [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
            echo "  ✔ Já vinculado: $dest -> $src"
            return 0
        fi
        mkdir -p "$BACKUP_DIR"
        echo "  📦 Fazendo backup de $dest -> $BACKUP_DIR/"
        mv "$dest" "$BACKUP_DIR/"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "  🚀 Vinculado: $dest -> $src"
}

echo ""
echo "📦 1. Vinculando configurações comuns..."
# Terminal Kitty
link_target "$DOTFILES_DIR/comum/kitty" "$HOME/.config/kitty"

# Fastfetch
link_target "$DOTFILES_DIR/comum/fastfetch" "$HOME/.config/fastfetch"

# Prompt Starship
link_target "$DOTFILES_DIR/comum/starship/starship.toml" "$HOME/.config/starship.toml"

# Shell Zsh
link_target "$DOTFILES_DIR/comum/zsh/.zshrc" "$HOME/.zshrc"

# Hyprlock (Bloqueio de tela)
if [ -f "$DOTFILES_DIR/comum/hypr/hyprlock.conf" ]; then
    link_target "$DOTFILES_DIR/comum/hypr/hyprlock.conf" "$HOME/.config/hypr/hyprlock.conf"
fi

echo ""
echo "🖥️  2. Vinculando configurações específicas do Desktop..."
# Hyprland do Desktop
link_target "$DOTFILES_DIR/desktop/hypr/hyprland.lua" "$HOME/.config/hypr/hyprland.lua"

echo ""
echo "✨ Instalação do Desktop concluída com sucesso!"
if [ -d "$BACKUP_DIR" ]; then
    echo "📁 Backups dos arquivos anteriores salvos em: $BACKUP_DIR"
fi
