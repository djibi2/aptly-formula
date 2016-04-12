# Set up our Aptly mirrors

include:
  - aptly
  - aptly.aptly_config

{% for mirror, opts in salt['pillar.get']('aptly:mirrors').items() %}
  {% set homedir = salt['pillar.get']('aptly:homedir', '/var/lib/aptly') %}
  {% set keyring = salt['pillar.get']('aptly:keyring', 'trustedkeys.gpg') %}
  
  
  {% set timestamp = salt['cmd.run']('date "+%d_%b_%Y_%s"') %}
  #{%- set name    = salt['pillar.get']('aplty:snapshot_name', timestamp ) %}
  {% set mirror_name    = mirror + '_' + timestamp %}
                                #aptly snapshot create <name> from mirror <mirror-name>
  {% set snapshot_mirror_cmd = "aptly snapshot create" %}

snapshot_{{ mirror }}_mirror:
  cmd.run:
    - name: {{ snapshot_mirror_cmd }} {{ mirror_name }} from mirror {{ mirror }}
    - user: aptly
    - env:
      - HOME: {{ homedir }}
  #  - require:
  #    - sls: aptly.create_mirrors

{% endfor %}
