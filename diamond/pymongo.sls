pymongo:
  pkg.installed:
{% if salt['grains.get']('os') == 'RedHat' %}
    - sources:
      - python26-bson: salt://diamond/files/python26-bson-1.9-8.x86_64.rpm
      - pymongo26: salt://diamond/files/pymongo26-1.9-8.x86_64.rpm
    - skip_verify: true
{% else %}
    - name: python-pymongo
{% endif %}
    - require_in:
      - service: diamond
    - watch_in:
      - service: diamond
