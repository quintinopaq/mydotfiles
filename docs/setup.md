# 🛠️ O Setup e Dotfiles

Esta página detalha os componentes fundamentais do sistema, os atalhos e a arquitetura de organização entre as máquinas.

---

## ⚙️ Componentes Principais

Essas são as engrenagens que fazem o sistema rodar de maneira rápida, fluida e personalizada:

| Componente | Ferramenta | Descrição / Função |
| :--- | :--- | :--- |
| **Sistema Operacional** | [Arch Linux](https://archlinux.org/) | Distribuição rolling release, leve, flexível e atualizada. |
| **Window Manager** | [Hyprland](https://hypr.land/) | Compositor Wayland dinâmico baseado em wlroots com suporte a animações fluidas. |
| **Barra de Status** | [Waybar](https://github.com/alexays/waybar) | Barra altamente customizável com módulos de som, bateria, workspaces e relógio. |
| **Lockscreen & Idle** | [Hyprlock](https://wiki.hypr.land/Hypr-Ecosystem/hyprlock/) & [Hypridle](https://wiki.hypr.land/Hypr-Ecosystem/hypridle/) | Bloqueio de tela moderno e gerenciamento de inatividade do sistema. |
| **Captura de Tela** | Grim + Slurp + Magick | Utilitários de captura com seleção de região e pós-processamento. |
| **Anotação de Prints** | [Satty](https://github.com/gabm/Satty) | Editor moderno e rápido para desenhar setas, destacar textos e salvar capturas. |
| **Launcher / Menu** | Rofi / Wofi | Acesso instantâneo a aplicativos e comandos do sistema. |

---

## 📂 Estrutura do Repositório

Para evitar conflitos entre computadores com especificações e necessidades distintas (múltiplos monitores no desktop vs economia de energia no notebook), as configurações são organizadas por perfil:

```text
📦 meus-dotfiles
 ┣ 📂 comum/                 # Configurações compartilhadas (todas as máquinas)
 ┃ ┣ 📂 hypr/                # hyprland.conf base, hyprlock.conf, hypridle.conf
 ┃ ┣ 📂 waybar/              # Configurações e estilos da Waybar
 ┃ ┗ 📂 scripts/             # Scripts utilitários (ex: capturaf.sh)
 ┣ 📂 notebook/              # Configurações específicas para notebook
 ┃ ┣ 📂 hypr/                # Otimizações de tela única e economia de energia
 ┃ ┗ 📂 waybar/              # Módulos com exibição de bateria e brilho
 ┗ 📂 screenshots/           # Fotos e capturas de tela dos setups
```

---

## 🚀 Como Aplicar as Configurações

As configurações são projetadas para serem copiadas ou criadas com links simbólicos (*symlinks*) na pasta de configurações do usuário (`~/.config/`):

### 1. Clonando o Repositório

```bash
git clone https://github.com/paqgamer/mydotfiles.git ~/mydotfiles
cd ~/mydotfiles
```

### 2. Configurações Compartilhadas (`comum/`)

Copie os arquivos comuns para a pasta de configurações do seu usuário:

```bash
cp -r comum/hypr ~/.config/
cp -r comum/waybar ~/.config/
```

### 3. Ajustes para Notebook (se aplicável)

Se estiver usando em um notebook, sobreponha as configurações correspondentes:

```bash
cp -r notebook/hypr/* ~/.config/hypr/
cp -r notebook/waybar/* ~/.config/waybar/
```

---

## 📸 Demonstração Visual

::: tip Monitores e Resolução
O layout do Hyprland suporta monitores com taxas de atualização elevadas (144Hz+) e múltiplos monitores em tempo real através do arquivo `monitors.conf`.
:::

<div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 1rem; margin-top: 1rem;">
  <div>
    <img src="/screenshots/desktop.png" alt="Desktop Setup" style="border-radius: 8px; width: 100%; border: 1px solid var(--vp-c-divider);" />
    <p style="text-align: center; font-size: 0.9rem; color: var(--vp-c-text-2); margin-top: 0.4rem;">Arch Linux Desktop</p>
  </div>
  <div>
    <img src="/screenshots/desktopwindows.png" alt="Notebook Setup" style="border-radius: 8px; width: 100%; border: 1px solid var(--vp-c-divider);" />
    <p style="text-align: center; font-size: 0.9rem; color: var(--vp-c-text-2); margin-top: 0.4rem;">Ambiente Secundário / Notebook</p>
  </div>
</div>
