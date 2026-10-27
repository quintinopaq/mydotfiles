#!/usr/bin/env bash
# ==============================================================================
#  install_symlinks.sh - Sincronizador de Dotfiles via Symlinks
# ==============================================================================
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo "🔗 Sincronizando dotfiles de: $DOTFILES_DIR"

mkdir -p "$HOME/.config"

# Função utilitária para link seguro com backup
link_target() {
    local src="$1"
    local dest="$2"

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

# 1. Kitty
link_target "$DOTFILES_DIR/comum/kitty" "$HOME/.config/kitty"

# 2. Fastfetch
link_target "$DOTFILES_DIR/comum/fastfetch" "$HOME/.config/fastfetch"

# 3. Starship
link_target "$DOTFILES_DIR/comum/starship/starship.toml" "$HOME/.config/starship.toml"

# 4. Zsh
link_target "$DOTFILES_DIR/comum/zsh/.zshrc" "$HOME/.zshrc"

# 5. Hyprland (arquivo lua)
link_target "$DOTFILES_DIR/comum/hypr/hyprland.lua" "$HOME/.config/hypr/hyprland.lua"

echo ""
echo "✨ Todos os symlinks foram criados com sucesso!"
if [ -d "$BACKUP_DIR" ]; then
    echo "📁 Backups dos arquivos anteriores salvos em: $BACKUP_DIR"
fi
