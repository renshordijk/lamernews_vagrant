routes:
  network.routes:
    - name: eth1
    - routes:
      - name: loadbalancer_route
        ipaddr: 10.10.1.0
        netmask: 255.255.255.0
        gateway: 10.10.2.100
