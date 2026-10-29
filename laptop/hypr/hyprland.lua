-- =============================================================================
-- ARQUIVO DE CONFIGURAÇÃO DO HYPRLAND (LUA OTIMIZADO)
-- =============================================================================

-- 1. MONITORES
require("monitors")
hl.monitor({
    output = "",
    mode = "highres",
    position = "auto",
    scale = 1.0,
})

-- 2. PROGRAMAS PADRÃO
local terminal = "kitty"
local menu = "rofi -show drun -show-icons -theme ~/.config/rofi/launchers/type-1/style-9.rasi"
local fileManager = "dolphin"

-- 3. EXECUÇÃO AUTOMÁTICA (Equivalente ao antigo exec-once)
hl.on("hyprland.start", function()
    -- Atualiza variáveis de ambiente do Wayland para D-Bus e Systemd primeiro
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    -- hl.exec_cmd("waybar")
    hl.exec_cmd("caelestia shell")
    hl.exec_cmd("waypaper --restore")
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("copyq --start-server")
    hl.exec_cmd("hyprpm reload -n")
end)

hl.permission({
    binary = "/usr/(bin|local/bin)/hyprpm",
    type   = "plugin",
    mode   = "allow",
})

hl.device({
    name = "synaptics-tm3096-006",
    sensitivity = 0.2
})

-- Mouse Logitech (Número negativo para ficar mais lento)
hl.device({
    name = "logitech-wireless-receiver-mouse",
    sensitivity = 0
})

-- 4. ENTRADA, APARÊNCIA E REGRAS DE LAYOUT
hl.config({
    input = {
        kb_layout = "us,br",
        kb_variant = "intl,abnt2",
        numlock_by_default = true,
        follow_mouse = 1,
        -- Define a tecla Menu (acionada por Fn + Ctrl Dir) como Compose:
        kb_options = "grp:shifts_toggle,compose:menu",
        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
            drag_lock = true,
        },
    },

    general = {
        gaps_in = 0,
        gaps_out = 2,
        border_size = 3,
        col = {
            active_border = { 
                colors = { "rgba(42cceeee)", "rgba(ff2a2aee)", "rgba(101b3bee)" }, 
                angle = 45 
            },
            inactive_border = "rgba(101b3b88)",
        },
        layout = "dwindle",
        allow_tearing = false,
    },
    decoration = {
        rounding = 5,
        blur = {
            enabled = false,
        },
        shadow = {
            enabled = false,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
})

-- 5. ANIMAÇÕES (Curvas e Regras)
hl.curve("linear", { type = "bezier", points = { { 0.0, 0.0 }, { 1.0, 1.0 } } })
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.15 } } })
hl.curve("slideBounce", { type = "bezier", points = { { 0.2, 0.9 }, { 0.1, 1.05 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "myBezier"})
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "linear", style = "loop" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "slideBounce", style = "slide"})

-- 6. VARIÁVEIS DE AMBIENTE
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

-- 7. TECLAS DE ATALHO PRINCIPAIS
local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("caelestia shell lock lock"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + Tab", function()
    if hl.plugin and hl.plugin.scrolloverview then
        hl.plugin.scrolloverview.overview("toggle")
    end
end)
hl.bind(mainMod .. " + G", function()
    if hl.plugin and hl.plugin.overview then
        hl.plugin.overview.toggle()
    end
end)

hl.bind("CTRL + ALT + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("zen-browser"))
hl.bind(mainMod .. " + A", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Mover o foco
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspaces
hl.bind(mainMod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mainMod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mainMod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mainMod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mainMod .. " + 5", hl.dsp.focus({ workspace = 5 }))

-- Mover janelas para Workspaces
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mainMod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mainMod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mainMod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))

-- Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- 8. CONTROLES MULTIMÍDIA E SCREENSHOTS
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })

hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | satty --filename - --fullscreen"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd("grim - | satty --filename - --fullscreen"))

-- =============================================================================
-- CONTROLE DE BRILHO adicional 
-- =============================================================================

-- Reduz o brilho extra em passos de 1% (Segure SHIFT + Tecla diminuir brilho)
hl.bind("SHIFT + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 1%-"), { repeating = true })

-- Aumenta o brilho extra em passos de 1% (Segure SHIFT + Tecla aumentar brilho)
hl.bind("SHIFT + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 1%+"), { repeating = true })

-- Atalho de emergência para resetar a tela ao normal (SUPER + SHIFT + B)
hl.bind("SUPER + SHIFT + B", hl.dsp.exec_cmd("hyprctl hyprsunset identity"))

-- =============================================================================
-- REGRAS DE JANELAS E OUTROS ATALHOS
-- =============================================================================

hl.window_rule({
    name = "copyq-floating",
    match = { class = "^(com.github.hluk.copyq)$" },
    float = true,
    center = true,
    size = "850 500",
    pin = true,
    border_size = 10,
})

hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("copyq show"))

-- Janelas flutuantes utilitárias e Picture-in-Picture
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "float-pavucontrol",
    match = { class = "^(pavucontrol)$" },
    float = true,
})

hl.window_rule({
    name = "float-nm-connection-editor",
    match = { class = "^(nm-connection-editor)$" },
    float = true,
})

hl.window_rule({
    name = "float-xdg-portals",
    match = { class = "^(xdg-desktop-portal-.*)$" },
    float = true,
})

hl.window_rule({
    name = "pip-window",
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    pin = true,
})

