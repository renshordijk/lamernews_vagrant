/etc/keepalived/keepalived.conf:
  file.managed:
    - source: salt://lb/keepalived.conf_{{ grains['fqdn'] }}
    - user: root
    - group: root
    - mode: 640
