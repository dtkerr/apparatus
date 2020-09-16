users.skel:
  file.recurse:
    - clean: True
    - name: /etc/skel
    - source: salt://{{ slspath }}/skel

include:
  - {{ slspath }}/terry
