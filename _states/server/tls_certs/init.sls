tls_certs:
  pkg.installed:
    - pkgs:
      - certbot
      - python3-certbot-dns-digitalocean
  user.present:
    - name: letsencrypt
    - shell: /sbin/nologin
    - home: /var/lib/letsencrypt
  file.managed:
    - name: /var/lib/letsencrypt/creds.ini
    - source: salt://{{ slspath }}/creds.ini
    - template: jinja
    - user: letsencrypt
    - group: letsencrypt
    - mode: 0400
  service.running:
    - name: certbot.timer
    - enable: True

tls_certs.letsencrypt_permissions:
  file.directory:
    - user: letsencrypt
    - group: letsencrypt
    - recurse:
      - user
      - group
    - names: 
      - /etc/letsencrypt:
        - dir_mode: 750
      - /var/log/letsencrypt:
        - dir_mode: 755

tls_certs.timer_override:
  file.managed:
    - name: /etc/systemd/system/certbot.timer.d/override.conf
    - source: salt://{{ slspath }}/override.conf
    - makedirs: True

{% for cert in [
  {
    "domain": "oefd.net",
    "aliases": ["www.oefd.net"],
  },
  {
    "domain": "dtkerr.ca",
    "aliases": ["www.dtkerr.ca"],
  },
  {
    "domain": "xnr.ca",
    "aliases": ["www.xnr.ca"],
  },
] %}
tls_certs.{{ cert.domain }}:
  cmd.run:
    - runas: letsencrypt
    - creates: /etc/letsencrypt/live/{{ cert.domain }}
    - name: |
        certbot certonly \
          --dns-digitalocean \
          --dns-digitalocean-credentials ~/creds.ini \
          -d {{ cert.domain }} \
          {% for alias in cert.aliases %} -d {{ alias }} {% endfor %} \
          --agree-tos -m certs@oefd.net
{% endfor %}
