redis-server:
  pkg:
    - installed
  file:
    - managed
    - name: /etc/redis/redis.conf
    - source: salt://db/redis.conf_{{ grains['fqdn'] }}
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: redis-server
  cmd:
    - run
    - name: /usr/sbin/service redis-server restart

redis-sentinel:
  file:
    - managed
    - name: /etc/redis/sentinel.conf
    - source: salt://db/sentinel.conf_db
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: redis-server

redis-initd:
  file:
    - managed
    - name: /etc/init.d/redis-sentinel
    - source: salt://db/redis-sentinel_db
    - user: root
    - group: root
    - mode: 755
    - require:
      - pkg: redis-server
  cmd:
    - run
    - name: update-rc.d redis-sentinel defaults ; sleep 5 ; /usr/sbin/service redis-sentinel start
