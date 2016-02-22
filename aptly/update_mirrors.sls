# Set up our Aptly mirrors

include:
  - aptly
  - aptly.aptly_config

{% for mirror, opts in salt['pillar.get']('aptly:mirrors').items() %}
  {%- set homedir = salt['pillar.get']('aptly:homedir', '/var/lib/aptly') -%}
  {%- set keyring = salt['pillar.get']('aptly:keyring', 'trustedkeys.gpg') -%}

  {%- set update_mirror_cmd = "aptly mirror update"  " ~ mirror ~ " -%}

update_{{ mirror }}_mirror:
  cmd.run:
    - name: {{ update_mirror_cmd }}
    - user: aptly
    - env:
      - HOME: {{ homedir }}
    - require:
      - sls: aptly.create_mirrors

{% endfor %}
