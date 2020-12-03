users.terry.account:
  pkg.installed:
    - pkgs:
      - bash-completion
      - zsh-completions
      - zsh-syntax-highlighting
      - zsh-history-substring-search
      - lua
      - lua-filesystem
      - lua-penlight
      - nodejs
      - npm
      - pipewire
      - xdg-desktop-portal
      - xdg-desktop-portal-wlr
      - libnotify
      - mako
  user.present:
    - name: terry
    - fullname: Terry Kerr
    - shell: /bin/zsh
    - groups:
      - lp
      - wheel
      - rfkill
    - optional_groups:
      - docker
      - wireshark
    - remove_groups: False
    - password: '{{ pillar.users.terry.password }}'

users.terry.editor:
  pkg.installed:
    - pkgs:
      - neovim
      - python-pynvim
      - fzf
      - ctags
  cmd.script:
    - source: https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh
    - args: ~/.cache/dein
    - runas: terry
    - creates: /home/terry/.cache/dein

include:
  - {{ slspath }}/desktop
