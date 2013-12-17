diamond:
  pkg.latest:
    - refresh: True
    - require:
      - pkgrepo: diamond
  service.running:
    - require:
      - pkg: diamond
      - file: /etc/diamond/diamond.conf
    - watch:
      - file: /etc/diamond/diamond.conf
  pkgrepo.managed:
    - ppa: nils-nm/ppa-diamond

/etc/diamond/diamond.conf:
  file.managed:
    - source: salt://diamond/files/diamond.conf
    - template: jinja
