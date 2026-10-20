# 🐧 Tutorial de Instalação do Arch Linux

> Guia prático, direto e completamente manual — sem scripts mágicos ou instaladores prontos.

![Arch Linux](https://img.shields.io/badge/OS-Arch_Linux-1793d1?style=for-the-badge&logo=arch-linux&logoColor=white)

---

## 1. Primeiros Passos: Preparando o Terreno

::: warning ⚠️ ATENÇÃO
Se você nunca instalou o Arch Linux antes, **leia atentamente cada instrução**. Comandos de particionamento e formatação manipulam diretamente o disco e apagarão todos os dados da unidade selecionada.
:::

### Criando a Mídia de Instalação

1. **Backup:** Tenha em mãos um pendrive de no mínimo **8 GB**. Faça backup prévio de todos os arquivos contidos nele, pois a unidade será formatada.
2. **Ventoy:** Baixe e utilize o [Ventoy](https://www.ventoy.net) para criar um pendrive de boot múltiplo simplesmente copiando imagens ISO para dentro dele.
3. **Imagem do Arch Linux:** Baixe a ISO oficial mais recente em [archlinux.org/download](https://archlinux.org/download/) e copie para a partição do Ventoy.

::: tip 💡 Dica Opcional (GParted Live)
Se sobrar espaço no pendrive, copie também a ISO do [GParted Live](https://gparted.org/download.php). Você pode dar boot nele primeiro para criar e formatar as partições em uma interface gráfica simples antes de iniciar a instalação do Arch.
:::

---

## 2. Inicializando pelo Pendrive

Antes de ligar pelo pendrive, entre nas configurações da BIOS/UEFI da sua máquina e **desative o Secure Boot**. A mídia live padrão do Arch Linux não possui assinatura de inicialização segura ativa.

### Passo a Passo do Boot:

1. **Conecte o pendrive** em uma porta USB (preferencialmente traseira, direto na placa-mãe).
2. **Reinicie o computador** pressionando repetidamente a tecla de **Boot Menu**:

| Fabricante / Modelo | Tecla de Boot Menu |
| :--- | :--- |
| Gigabyte, MSI, Dell | `F12` |
| HP (Desktops e Notebooks) | `F9` ou `ESC` |
| ASUS | `ESC` ou `F8` |
| Acer | `F12` ou `F2` |
| Lenovo, Samsung | `F10` ou `F2` |

3. **Selecione a opção UEFI:**
   - ✅ **Escolha:** A opção com prefixo `UEFI:` (ex: `UEFI: Kingston DataTraveler 3.0`).
   - ❌ **Evite:** A opção Legacy/MBR sem o prefixo UEFI.

4. **Inicie o ambiente live:** Selecione *"Arch Linux install medium (x86_64, UEFI)"* e aperte `Enter`.

Após carregar, o terminal de boas-vindas estará disponível:

```bash
root@archiso ~ #
```

---

## 3. Preparando o Ambiente e Conexão

### 3.1 Conexão com a Internet

Se estiver conectado via cabo de rede (Ethernet), teste a conexão com:

```bash
ping -c 4 archlinux.org
```

Se receber respostas com tempo em milissegundos (`ms`), sua conexão está ativa.

#### Conectando via Wi-Fi (`iwctl`):

1. Descubra o nome do adaptador Wi-Fi:
   ```bash
   iwctl device list
   ```
   *(Geralmente listado como `wlan0`, `wlp2s0` ou similar)*

2. Escaneie as redes próximas (substitua `wlp2s0` pelo seu adaptador):
   ```bash
   iwctl station wlp2s0 scan
   iwctl station wlp2s0 get-networks
   ```

3. Conecte-se à sua rede:
   ```bash
   iwctl station wlp2s0 connect "NomeDaSuaRede"
   ```
   *Digite a senha do Wi-Fi e pressione `Enter`.*

4. Saia do iwctl e valide a conexão:
   ```bash
   exit
   ping -c 4 archlinux.org
   ```

### 3.2 Sincronização do Relógio (NTP)

Ative a sincronização automática de data/hora:

```bash
timedatectl set-ntp true
timedatectl status
```

---

## 4. Particionamento e Formatação do Disco

::: danger 🚨 CUIDADO
Todos os comandos desta seção alteram permanentemente o disco selecionado.
:::

Verifique os discos conectados com:

```bash
lsblk
```

Geralmente o disco principal será `sda`, `sdb` (SATA) ou `nvme0n1` (NVMe M.2).

### Particionando com `cfdisk`

Substitua `sdX` pelo identificador do seu disco (ex: `sda` ou `nvme0n1`):

```bash
cfdisk /dev/sdX
```

1. **Rótulo do disco:** Escolha **`gpt`**.
2. **Partição de Boot (EFI):**
   - Selecione `Free space` -> **New** -> tamanho `512M`.
   - Em **Type**, selecione **EFI System**.
3. **Partição Swap (Opcional):**
   - `Free space` -> **New** -> tamanho `4G` a `8G`.
   - Em **Type**, selecione **Linux swap**.
4. **Partição Raiz (Root):**
   - `Free space` -> **New** -> restante do espaço livre.
   - **Type** permanece **Linux filesystem**.
5. **Gravar:** Selecione **Write**, digite `yes` e saia em **Quit**.

### Formatando as Partições

Substitua `sdX` pelas partições criadas (ex: `sda1`, `sda2`, `sda3` ou `nvme0n1p1`, `nvme0n1p2`, `nvme0n1p3`):

```bash
# 1. Boot (FAT32)
mkfs.fat -F 32 /dev/sdX1

# 2. Swap (se criada)
mkswap /dev/sdX2
swapon /dev/sdX2

# 3. Raiz (ext4)
mkfs.ext4 /dev/sdX3
```

### Montando as Partições

```bash
mount /dev/sdX3 /mnt
mount --mkdir /dev/sdX1 /mnt/boot
```

Confira se `/mnt` e `/mnt/boot` aparecem corretamente com `lsblk`.

---

## 5. Instalando o Sistema Base

Execute o `pacstrap` para baixar os pacotes do kernel, firmware e utilitários essenciais:

```bash
pacstrap -K /mnt base curl wget linux linux-firmware grub efibootmgr \
  intel-ucode amd-ucode base-devel networkmanager iwd vim nano micro \
  sudo bash-completion man-db man-pages ntfs-3g exfatprogs sof-firmware \
  alsa-utils openssh htop unzip bind pipewire wireplumber pipewire-alsa \
  pipewire-pulse pipewire-jack
```

### Gerando o Fstab

Gere a tabela de partições persistente:

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

---

## 6. Configurando o Novo Sistema (`chroot`)

Entre no sistema recém-instalado:

```bash
arch-chroot /mnt
```

### Fuso Horário e Relógio

```bash
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc
```

### Idioma e Localização

Edite `/etc/locale.gen` descomentando as linhas `pt_BR.UTF-8 UTF-8` e `en_US.UTF-8 UTF-8`:

```bash
micro /etc/locale.gen
```

Gere os locales e defina o idioma padrão:

```bash
locale-gen
echo "LANG=pt_BR.UTF-8" > /etc/locale.conf
```

### Nome da Máquina (Hostname)

```bash
echo "meu-arch" > /etc/hostname
```

### Senha do Root e Criação de Usuário

Defina a senha do superusuário:

```bash
passwd
```

Crie o usuário comum com acesso ao grupo `wheel`:

```bash
useradd -m -G wheel -s /bin/bash seu_usuario
passwd seu_usuario
```

Dê permissões de sudo ao grupo `wheel`:

```bash
EDITOR=micro visudo
```
*Localize a linha `# %wheel ALL=(ALL:ALL) ALL` e remova o `#` inicial. Salve e saia.*

---

## 7. Instalando o Bootloader

### Opção A: GRUB (Recomendado)

```bash
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

### Opção B: systemd-boot (Alternativa Minimalista)

```bash
bootctl install
```

Configure `/boot/loader/loader.conf`:
```ini
default  arch.conf
timeout  3
editor   no
```

Crie a entrada `/boot/loader/entries/arch.conf` (substitua `sdX3` pela sua partição root e `intel-ucode` ou `amd-ucode` conforme seu processador):
```ini
title   Arch Linux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options root=/dev/sdX3 rw quiet
```

### Ativando a Rede e Finalizando

Ative o NetworkManager para ter internet após reiniciar:

```bash
systemctl enable NetworkManager
```

Saia do chroot, desmonte os discos e reinicie:

```bash
exit
umount -R /mnt
reboot
```
*(Remova o pendrive durante a reinicialização).*

---

## 8. Pós-Instalação: Ambiente Gráfico e AUR Helper

Faça login com o usuário criado e configure a interface gráfica e o AUR helper:

### Gerenciador de Pacotes do AUR (`paru`)

```bash
sudo pacman -S --needed base-devel git
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

A partir de agora, use `paru` diretamente para atualizar o sistema e instalar programas do repositório oficial ou do AUR!

### Ambientes Recomendados

- **Hyprland:** Veja nossos arquivos em [Setup & Dotfiles](/setup).
- **KDE Plasma:** `sudo pacman -S plasma-desktop dolphin kitty`
