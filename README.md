<div align="center">

# ❄️ Meus Dotfiles

Um repositório pessoal para manter meu ambiente de desenvolvimento e uso diário sincronizado e organizado.

![Arch Linux](https://img.shields.io/badge/OS-Arch_Linux-1793d1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Hyprland](https://img.shields.io/badge/WM-Hyprland-00a7b5?style=for-the-badge&logo=linux&logoColor=white)
![C++](https://img.shields.io/badge/C++-00599C?style=for-the-badge&logo=c%2B%2B&logoColor=white)
![Bash](https://img.shields.io/badge/Scripts-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
[![Site Online](https://img.shields.io/badge/Site-GitHub_Pages-22c55e?style=for-the-badge&logo=githubpages&logoColor=white)](https://paqgamer.github.io/mydotfiles/)

<br>
<table>
  <tr>
    <td valign="top" width="50%">
      <img src="./screenshots/desktop.png" alt="Desktop Setup" width="100%">
      <p align="center">🖥️ Arch Linux (Desktop)</p>
    </td>
    <td valign="top" width="50%">
      <img src="./screenshots/desktopwindows.png" alt="Windows Setup" width="100%">
      <p align="center">🪟 Ambiente Secundário / Notebook</p>
    </td>
  </tr>
</table>

---

</div>

## 🛠️ O Setup

Essas são as engrenagens principais que fazem o sistema rodar:

- **Sistema Operacional:** [Arch Linux](https://archlinux.org/)
| [Tutorial De instalação](tutorial_arch.md)

- **Window Manager:** [Hyprland (Wayland)](https://hypr.land/)
- **Barra de Status:** [Waybar](https://github.com/alexays/waybar)
- **Lockscreen:** [Hyprlock](https://wiki.hypr.land/Hypr-Ecosystem/hyprlock/)
- **Captura de Tela:** Grim + Slurp + Magick
- **Edição Rápida:** Satty

## 📂 Estrutura do Repositório

Como eu utilizo máquinas com propósitos e hardwares diferentes, dividi os arquivos para evitar conflitos. Tudo é copiado seletivamente para a pasta `~/.config/`.

```text
📦 meus-dotfiles
 ┣ 📂 comum/                 # Funciona perfeitamente em qualquer máquina
 ┃ ┗ 📂 scripts/             # Scripts de captura de tela, utilitários, etc.
 ┣ 📂 desktop/               # Configurações de alta performance e múltiplos monitores
 ┃ ┗ 📜 hyprland.conf
 ┗ 📂 notebook/              # Configurações focadas em economia de bateria e rede móvel
   ┗ 📜 hyprland.conf
```

<br>

## 📦 A Megathread de Aplicativos (🚧EM CONSTRUÇÃO🚧)

**Índice Rápido:**

- [🖥️ Core System & Terminal](#core-system--terminal)
- [🛠️ Desenvolvimento & Engenharia](#desenvolvimento--engenharia)
- [🌐 Navegação, Comunicação & Downloads](#navegação-comunicação--downloads)
- [✍️ Escrita, Leitura & Produtividade](#escrita-leitura--produtividade)
- [🎬 Mídia & Entretenimento](#mídia--entretenimento)

---

Esta é a coletânea de ferramentas que utilizo no meu dia a dia no Arch Linux. A lista está dividida por categorias para facilitar a navegação.

### 🖥️ Core System & Terminal

| Categoria               | Ferramenta                                   | Por que uso?                                                                                                    |
| :---------------------- | :------------------------------------------- | :-------------------------------------------------------------------------------------------------------------- |
| Shell                   | [Zsh](https://www.zsh.org/)                  | _O bash é top, porém o zsh tem mais complementos como oh-my-zsh e o autocomplete é muito melhor_                |
| Terminal                | [Kitty](https://github.com/kovidgoyal/kitty) | _Leve, bonito e útil, minimalista mas poderoso_                                                                 |
| Gerenciador de Arquivos | [Dolphin](https://apps.kde.org/dolphin/)     | _Mesmo fora do ecosistema da KDE, é um dos melhores, porém se quiser outro recomendo thunar, pcmanfm, nemo etc_ |
|Tele de Logout/energia | [wlogout](https://github.com/ArtsyMacaw/wlogout) | _Para nao ter ficar desligando o pc com comando, é melhor ter um botãozinho para isso_  |

### 🛠️ Desenvolvimento & Engenharia

| Categoria        | Ferramenta                                   | Por que uso?                                                                                                                                                                             |
| :--------------- | :------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Editor de Código | [VSCodium](https://vscodium.com/)            | _Vscode, porém código aberto, sem telemetria da microsoft (mais leve) e com suporte total as extensões do vscode normal,_                                                                |
| Containers       | [Podman Desktop](https://podman-desktop.io/) | _O docker-desktop é muito ruim, o podman além de ter sua engine propria, tem o podmandesktop que consegue gerir outras ferramentas incluindo o docker (bem melhor que o docker-desktop)_ |

### 🌐 Navegação, Comunicação & Downloads

| Categoria           | Ferramenta                                                                   | Por que uso?                                                                                                                                                                                                                                                       |
| :--------------------| :-----------------------------------------------------------------------------| :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Navegador Web       | [Floorp](https://floorp.app/)                                                | _Gosto do firefox, porém uso floorp por ter "workspaces", que dividem o fluxo de trabalho, estudo, pesquisa etc, tem extensões pra isso eu acho, mas gostei do floorp_                                                                                             |
| Central Social      | [Ferdium](https://ferdium.org/) [ElecWhat](https://github.com/piec/elecwhat) | _Aqui consegue juntar whatsapp, discord, trello etc em um app só, é como se tivesse rodando o site, mas de forma organizada e mais intuitiva que simplesmente abrir no navegador, e elecwhat é melhor para apenas whatsapp por suportar ligações no modo web beta_ |
| Gestor de Downloads | [AB-Download Manager](https://abdownloadmanager.com/)                        | _Melhor que baixar no navegador, leve, e se integra no navegador com uma extensao, então é só clicar baixar no navegador que vai direto pro popup do AB-DM_                                                                                                        |

### ✍️ Escrita, Leitura & Produtividade

| Categoria           | Ferramenta                                                                            | Por que uso?                                                                                                                                                                                                                              |
| :--------------------| :--------------------------------------------------------------------------------------| :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Escrita Criativa    | [novelWriter](https://novelwriter.io/)                                                | _Muito completo e organizado, focado em escrita de livros e projetos complexos, nao para anotações simples etc_                                                                                                                           |
| Leitura & E-books   | [Calibre](https://calibre-ebook.com/)                                                 | _Faz tudo no que diz respeito a livros e documentos variados, lê, converte, edita metadados etc. Além de organização de biblioteca digital, o que torna possível configuração de bibliotecas remotas e compartilhadas entre dispositivos_ |
| Suíte de Escritório | [LibreOffice](https://www.libreoffice.org/) / [Google Docs](https://docs.google.com/) | _Libreoffice porque é código aberto e faz tudo, ou quase, que o da microsoft. Googledocs, por mais que não seja aberto, e provavelmente espione até a alma, é util pro dia a dia e colaboração simultânea_                                |

### 🎬 Mídia & Entretenimento

| Categoria       | Ferramenta                       | Por que uso?                                                                                                                                                         |
| :----------------| :---------------------------------| :---------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Player de Vídeo | [VLC](https://www.videolan.org/) | _Tem melhores pra cada uso, tem mais leves, mais robustos etc, mas o VLC segue invicto abrindo tudo que preciso e rodando em todos os sistemas que conheço_  |
| Player de Vídeo | [Mpv](https://www.mpv.io/)       | _Mpv é um player leve e multiplataforma de código aberto com uma interface gráfica extremamente minimalista. Recomendado para máquinas com baixo poder de performance_ |
  
### Conversão de arquivos:
| Categoria                     | Ferramenta                    | Por que                                                                                                                                     |
| :--------------| :------------------------------| :----------------|
| Canivevte suíço de documentos | [Pandoc](https://pandoc.org/) | _Pandoc-cli, converte, exporta e refatora documentos de múltiplos formatos, com suporte total à edição de metadados_                          |
| Faz  tudo em vídeos           | [ffmpeg](https://ffmpeg.org)  | _ffmpeg, converte vídeos para todos os  formatos que conheço, com capacidade avançada de manipulação  de mídia, como cortes, compressão etc_ |
