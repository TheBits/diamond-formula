diamond:
  pkg.latest:
    - refresh: True
    - require:
      - pkgrepo: diamond
  service.running:
    - require:
      - pkg: diamond
      - file: /etc/diamond/diamond.conf
      - file: /etc/diamond/collectors
    - watch:
      - file: /etc/diamond/diamond.conf
      - file: /etc/diamond/collectors
  pkgrepo.managed:
    - ppa: nikicat/diamond

/etc/diamond/diamond.conf:
  file.managed:
    - source: salt://diamond/files/diamond.conf
    - template: jinja
    - mode: 644

/etc/diamond/collectors:
  file.recurse:
    - source: salt://diamond/files/collectors
    - clean: True
