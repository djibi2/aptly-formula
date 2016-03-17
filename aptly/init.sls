aptly_repo:
  pkgrepo.managed:
    - humanname: Aptly PPA
    - name: deb http://repo.aptly.info/ squeeze main
    - dist: squeeze
    - file: /etc/apt/sources.list.d/aptly.list
    - key_url: https://www.aptly.info/pubkey.txt    
    - require_in:
      - pkg: aptly

aptly:
  pkg.installed:
    - name: aptly
    - refresh: True

# dependency for publishing
bzip2:
  pkg.installed

aptly_user:
  user.present:
    - name: aptly
    - shell: /bin/bash
    - home: {{ salt['pillar.get']('aptly:homedir', '/var/lib/aptly') }}
    - require:
      - pkg: aptly
