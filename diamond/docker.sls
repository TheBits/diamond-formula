include:
  - diamond

{% set name = "MemoryDocker" %}
{% include "diamond/collector.sls" %}

python-pip:
  pkg:
    - installed

docker-py:
  pip.installed:
    - require:
      - pkg: python-pip

diamond-user:
  user.present:
    - name: diamond
    - groups:
      - docker
    - watch_in:
      - service: diamond
