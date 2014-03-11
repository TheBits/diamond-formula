diamond:
  pkg:
    - installed
    {% if grains['os'] == 'RedHat' %}
    - sources:
      - diamond: salt://diamond/files/diamond-3.4.210-1.noarch.rpm
    - skip_verify: True
    {% endif %}
  service:
    - running
    - enable: true
    - require:
      - pkg: diamond
      - file: /etc/diamond/diamond.conf
      - file: /etc/diamond/collectors
      - file: /etc/logrotate.d/diamond
    - watch:
      - file: /etc/diamond/diamond.conf
      - file: /etc/diamond/collectors

/etc/diamond/diamond.conf:
  file.managed:
    - source: salt://diamond/files/diamond.conf
    - template: jinja
    - mode: 644

/etc/diamond:
  file.directory:
    - dir_mode: 755
    - file_mode: 644

/etc/diamond/collectors:
  file.directory:
    - dir_mode: 755
    - file_mode: 644
    - recurse:
      - mode

{% for name in salt['pillar.get']('diamond:collectors', ['Interrupt', 'Network', 'UDP', 'TCP']) %}
{% include 'diamond/collector.sls' %}
{% endfor %}

/etc/logrotate.d/diamond:
  file.managed:
    - source: salt://diamond/files/logrotate
    - mode: 644

{% if grains['os'] == 'Ubuntu' %}
python-pysnmp4:
  pkg.installed

diamond-ppa:
  pkgrepo.managed:
    - ppa: nikicat/diamond
    - require_in:
      - pkg: diamond
{% endif %}
