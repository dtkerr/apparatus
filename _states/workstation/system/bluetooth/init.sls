system.bluetooth:
  pkg.installed:
    - pkgs:
      - bluez
  file.managed:
    - name: /etc/bluetooth/main.conf
    - source: salt://{{ slspath }}/main.conf
  # bluetooth is currently messing with my wifi...
  # service.running:
  #   - name: bluetooth.service
  #   - enable: True
  #   - watch:
  #     - pkg: system.bluetooth
  #     - file: /etc/bluetooth/main.conf
