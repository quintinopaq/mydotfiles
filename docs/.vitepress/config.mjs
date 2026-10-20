import { defineConfig } from 'vitepress'

export default defineConfig({
  lang: 'pt-BR',
  title: 'Meus Dotfiles',
  description: 'Configurações e Dotfiles para Arch Linux e Hyprland por paqgamer',
  base: '/mydotfiles/',
  head: [
    ['link', { rel: 'icon', type: 'image/png', href: '/screenshots/desktop.png' }],
    ['meta', { name: 'theme-color', content: '#1793d1' }]
  ],
  themeConfig: {
    siteTitle: '❄️ Meus Dotfiles',
    nav: [
      { text: 'Início', link: '/' },
      { text: 'Setup & Dotfiles', link: '/setup' },
      { text: 'Tutorial Arch', link: '/tutorial-arch' },
      { text: 'Megathread de Apps', link: '/apps' }
    ],
    sidebar: [
      {
        text: '⚙️ Configuração',
        items: [
          { text: 'Setup & Estrutura', link: '/setup' },
          { text: 'Megathread de Apps', link: '/apps' }
        ]
      },
      {
        text: '🐧 Guia Arch Linux',
        items: [
          { text: 'Instalação do Arch Linux', link: '/tutorial-arch' }
        ]
      }
    ],
    search: {
      provider: 'local',
      options: {
        locales: {
          root: {
            translations: {
              button: {
                buttonText: 'Buscar na documentação',
                buttonAriaLabel: 'Buscar na documentação'
              },
              modal: {
                noResultsText: 'Nenhum resultado encontrado para',
                resetButtonTitle: 'Limpar busca',
                footer: {
                  selectText: 'para selecionar',
                  navigateText: 'para navegar',
                  closeText: 'para fechar'
                }
              }
            }
          }
        }
      }
    },
    socialLinks: [
      { icon: 'github', link: 'https://github.com/paqgamer/mydotfiles' }
    ],
    footer: {
      message: 'Ambiente Arch Linux & Hyprland configurado com foco em agilidade e minimalismo.',
      copyright: 'Copyright © 2026 paqgamer'
    },
    docFooter: {
      prev: 'Página anterior',
      next: 'Próxima página'
    },
    outline: {
      level: [2, 3],
      label: 'Nesta página'
    },
    editLink: {
      pattern: 'https://github.com/paqgamer/mydotfiles/edit/main/docs/:path',
      text: 'Sugerir alteração no GitHub'
    },
    lastUpdated: {
      text: 'Última atualização'
    }
  }
})
