prelude:
  pkg.uptodate:
    - refresh: True
  file.managed:
    - name: /etc/motd
      source: salt://{{ slspath }}/motd
