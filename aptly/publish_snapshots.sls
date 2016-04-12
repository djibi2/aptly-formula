include:
  - aptly.snapshot_mirrors

{% for mirror, opts in salt['pillar.get']('aptly:mirrors').items() %}
  {% set snapshot_name    = 'aptly_' + mirror  %}
  {% set distribution = mirror %}
publish_{{ snapshot_name }}_{{ distribution }}_repo:
  cmd.run:
    # NOTE: You may have to run this command manually the first time. The next
    # version of aptly is supposed to have a -batch option to pass -no-tty to
    # the gpg calls.
    - name: aptly -batch=true publish snapshot -distribution="{{ distribution }}" "{{snapshot_name}}"
    - user: aptly
    - env:
      - HOME: {{ salt['pillar.get']('aptly:homedir', '/var/lib/aptly') }}
    # unless is 2014.7 only, on 2014.1 it doesn't run and you just get an error
    # saying the repo has already been published
    #- unless: aptly -batch=true publish update  {{ distribution }}
{% endfor %}
