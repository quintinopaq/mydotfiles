# 📦 Pacotes Necessários - Arch Linux

Comando completo para instalar todos os pacotes oficiais necessários para rodar as configurações (`Hyprland Lua`, `Kitty`, `Starship`, `Fastfetch`, utilitários de mídia, volume, brilho e ferramentas de sistema):

```bash
sudo pacman -S --needed \
    hyprland \
    hypridle \
    hyprlock \
    hyprpolkitagent \
    hyprsunset \
    kitty \
    starship \
    fastfetch \
    zsh \
    zoxide \
    ttf-firacode-nerd \
    brightnessctl \
    playerctl \
    wireplumber \
    grim \
    slurp \
    satty \
    copyq \
    waypaper \
    rofi \
    dolphin
```

---

## 🔌 Plugins do Zsh (Oh My Zsh)

Se utilizar o **Oh My Zsh**, clone os plugins configurados no `.zshrc`:

```bash
# Sugestões de histórico automáticas
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Realce de sintaxe em tempo real
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

---

## 🌟 Pacotes Adicionais (AUR)

Programas opcionais chamados pelos atalhos e autostart do Hyprland:

```bash
paru -S --needed \
    caelestia-shell-git \
    zen-browser-bin \
    smile
```
