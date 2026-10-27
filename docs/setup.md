# 🛠️ O Setup e Dotfiles

Esta página detalha os componentes fundamentais do sistema, os atalhos e a arquitetura de organização entre as máquinas.

---

## ⚙️ Componentes Principais

Essas são as engrenagens que fazem o sistema rodar de maneira rápida, fluida e personalizada:

| Componente | Ferramenta | Descrição / Função |
| :--- | :--- | :--- |
| **Sistema Operacional** | [Arch Linux](https://archlinux.org/) | Distribuição rolling release, leve, flexível e atualizada. |
| **Window Manager** | [Hyprland](https://hypr.land/) | Compositor Wayland dinâmico baseado em wlroots com suporte a animações fluidas. |
| **Barra de Status** | [Waybar](https://github.com/alexays/waybar) | Barra altamente customizável com módulos de som, bateria, workspaces e relógio.<br>*(Transicionando para o [Caelestia Shell](https://github.com/caelestia-dots/shell))* |
| **Lockscreen & Idle** | [Hyprlock](https://wiki.hypr.land/Hypr-Ecosystem/hyprlock/) & [Hypridle](https://wiki.hypr.land/Hypr-Ecosystem/hypridle/) | Bloqueio de tela moderno e gerenciamento de inatividade do sistema.<br>*(Transicionando para o [Caelestia Shell](https://github.com/caelestia-dots/shell))* |
| **Captura de Tela** | Grim + Slurp + Magick | Utilitários de captura com seleção de região e pós-processamento. |
| **Anotação de Prints** | [Satty](https://github.com/gabm/Satty) | Editor moderno e rápido para desenhar setas, destacar textos e salvar capturas. |
| **Launcher / Menu** | Rofi / Wofi | Acesso instantâneo a aplicativos e comandos do sistema. Ainda uso mesmo  após transicionar para o caelestia-shell que possui  launcher  próprio |

::: info 🔮 Transição para o Caelestia Shell
Atualmente estou em processo de transição da **Waybar** para o **[Caelestia Shell](https://github.com/caelestia-dots/shell)**, uma suíte de interface unificada para Hyprland escrita em Quickshell/QML com suporte a temas dinâmicos (Material You) e animações morphing.
:::

---

## 📂 Estrutura do Repositório

Para evitar conflitos entre computadores com especificações e necessidades distintas (múltiplos monitores no desktop vs economia de energia no laptop), as configurações são organizadas por perfil:

```text
📦 meus-dotfiles
 ┣ 📂 comum/                 # Configurações compartilhadas (todas as máquinas)
 ┣ 📂 desktop/               # Configurações de Desktop
 ┣ 📂 laptop/                # Configurações específicas para laptop
 ┣ 📜 install_desktop.sh     # Script instalador via symlinks para Desktop
 ┗ 📜 install_laptop.sh      # Script instalador via symlinks para Laptop
```

---

## 🚀 Como Aplicar as Configurações

O repositório conta com scripts automatizados de symlinks que fazem backup seguro das configurações existentes antes de vincular:

```bash
git clone https://github.com/quintinopaq/mydotfiles.git ~/mydotfiles
cd ~/mydotfiles

# Se estiver no Desktop:
./install_desktop.sh

# Se estiver no Laptop:
./install_laptop.sh
```

---

## 📸 Demonstração Visual

::: tip Monitores e Resolução
O layout do Hyprland suporta monitores com taxas de atualização elevadas (144Hz+) e múltiplos monitores em tempo real através do arquivo `monitors.conf`.
:::

<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1rem; margin-top: 1rem;">
  <div>
    <img src="/screenshots/caelestiafull.png" alt="Caelestia Shell Visão Completa" style="border-radius: 8px; width: 100%; border: 1px solid var(--vp-c-divider);" />
    <p style="text-align: center; font-size: 0.9rem; color: var(--vp-c-text-2); margin-top: 0.4rem;">Caelestia Shell (Visão Completa)</p>
  </div>
  <div>
    <img src="/screenshots/telacaelestia.png" alt="Caelestia Shell Desktop" style="border-radius: 8px; width: 100%; border: 1px solid var(--vp-c-divider);" />
    <p style="text-align: center; font-size: 0.9rem; color: var(--vp-c-text-2); margin-top: 0.4rem;">Caelestia Shell (Desktop & Widgets)</p>
  </div>
  <div>
    <img src="/screenshots/desktop.png" alt="Desktop Setup" style="border-radius: 8px; width: 100%; border: 1px solid var(--vp-c-divider);" />
    <p style="text-align: center; font-size: 0.9rem; color: var(--vp-c-text-2); margin-top: 0.4rem;">Arch Linux Desktop</p>
  </div>
  <div>
    <img src="/screenshots/desktopwindows.png" alt="Laptop Setup" style="border-radius: 8px; width: 100%; border: 1px solid var(--vp-c-divider);" />
    <p style="text-align: center; font-size: 0.9rem; color: var(--vp-c-text-2); margin-top: 0.4rem;">Ambiente Secundário / Laptop</p>
  </div>
</div>
