ruby-initd:
  file:
    - managed
    - name: /etc/init.d/ruby
    - source: salt://app/ruby-initd_app
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: ruby2.1
  cmd:
    - run
    - name: update-rc.d ruby defaults ; sleep 5 ; /usr/sbin/service ruby start
