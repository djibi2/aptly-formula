#include:
  #- aptly.create_mirrors

{% for mirror, opts in salt['pillar.get']('aptly:mirrors').items() %}
  {% set snapshot_name    = 'aptly_' + mirror  %}
  {% set published_name = mirror %}
drop_{{ published_name }}_repo:
  cmd.run:
    - name: aptly publish drop "{{published_name}}"
    - user: aptly
    - env:
      - HOME: {{ salt['pillar.get']('aptly:homedir', '/var/lib/aptly') }}
drop_{{ snapshot_name }}_repo:
  cmd.run:
    - name: aptly snapshot drop "{{snapshot_name}}"
    - user: aptly
    - env:
      - HOME: {{ salt['pillar.get']('aptly:homedir', '/var/lib/aptly') }}

{% endfor %}
