apacheconfig:
  file:
    - managed
    - name: /etc/apache2/sites-available/000-default.conf
    - source: salt://app/apacheconfig_app
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: apache2
  cmd:
    - run
    - name: (cd /opt/lamernews; bundler install) ; /usr/sbin/service apache2 restart
