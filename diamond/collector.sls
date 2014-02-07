/etc/diamond/collectors/{{ name }}Collector.conf:
  file.managed:
    - source: salt://diamond/files/collector.conf
    - template: jinja
    - context:
      - name: {{ name }}
    - file_mode: 644
    - watch_in:
      - service: diamond
