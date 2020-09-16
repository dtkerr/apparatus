system.config.sudoers:
  file.managed:
    - name: /etc/sudoers.d/wheel-sudoers
    - source: salt://{{ slspath }}/wheel-sudoers
    - mode: 0400
