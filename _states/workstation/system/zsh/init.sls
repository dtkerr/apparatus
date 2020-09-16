system.config.zsh:
  pkg.installed:
    - pkgs:
      - zsh
      - bash-completion
      - zsh-completions
  file.managed:
    - name: /etc/zsh/zshenv
    - source: salt://{{ slspath }}/zshenv
