system.config.xdg:
  file.managed:
    - name: /etc/profile.d/xdg.sh
    - source: salt://{{ slspath }}/xdg.sh
    - mode: 0755
