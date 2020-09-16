webserver:
  pkg.installed:
    - pkgs:
      - nginx-light
  file.recurse:
    - name: /etc/nginx
    - source: salt://{{ slspath }}/config
    - clean: True
  service.running:
    - name: nginx.service
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nginx

webserver.deploy_bot:
  pkg.installed:
    - pkgs:
      - rsync
  user.present:
    - name: www-data
    - shell: /bin/sh
  file.directory:
    - name: /srv/http
    - user: www-data
    - group: www-data
  ssh_auth.present:
    - user: www-data
    - source: salt://{{ slspath }}/id_www-data.pub
