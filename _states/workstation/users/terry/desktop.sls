desktop:
  pkg.installed:
    - pkgs:
      # desktop functionality
      - blueman
      - gtk2
      - light
      - nm-connection-editor
      - pavucontrol
      - rofi
      - sway
      - swaylock
      - waybar
      - wl-clipboard
      - xorg-server-xwayland

      # applications
      - alacritty
      # - firefox-developer-edition
      #   I'm actually using the fedora wayland patch
      # - aerc # this is an aur package for now
      - dante
      - w3m

      # fonts
      - noto-fonts
      - noto-fonts-cjk
      - noto-fonts-emoji
      - otf-font-awesome
      - ttf-bitstream-vera
      - ttf-fira-mono
      - ttf-fira-sans
      - ttf-ibm-plex
      - ttf-liberation
      - ttf-nerd-fonts-symbols-mono
      - ttf-roboto

users.terry.desktop.top_level_dotfiles:
  file.managed:
    - user: terry
    - group: terry
    - names:
      - /home/terry/.gitconfig:
        - source: salt://{{ slspath }}/gitconfig
      - /home/terry/.editorconfig:
        - source: salt://{{ slspath }}/editorconfig

users.terry.desktop.top_level_dotdirs:
  file.recurse:
    - user: terry
    - group: terry
    - template: jinja
    - names:
      - /home/terry/.config:
        - source: salt://{{ slspath }}/config
      - /home/terry/.gnupg:
        - dir_mode: 0700
        - source: salt://{{ slspath }}/gnupg

users.terry.desktop.aerc_accounts:
  file.managed:
    - name: /home/terry/.config/aerc/accounts.conf
    - user: terry
    - group: terry
    - template: jinja
    - mode: 600
