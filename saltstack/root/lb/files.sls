keepalived:
  pkg:
    - installed
  file:
    - managed
    - name: /etc/keepalived/keepalived.conf
    - source: salt://lb/keepalived.conf_{{ grains['fqdn'] }}
    - user: root
    - group: root
    - mode: 640
    - require:
      - pkg: keepalived
  cmd:
    - run
    - name: /etc/init.d/keepalived stop ; /etc/init.d/keepalived start

haproxy:
  pkg:
    - installed
  file:
    - managed
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://lb/haproxy.cfg_lb
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - context:
      ip: {{ grains['ip_interfaces']['eth1'][0] }}
    - require:
      - pkg: haproxy
  cmd:
    - run
    - name: /etc/init.d/haproxy restart
