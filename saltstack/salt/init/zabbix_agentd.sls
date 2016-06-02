zabbix-agentd:
  pkg.installed:
    - name: zabbix22-agent
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf
    - source: salt://init/files/zabbix_agentd.conf
    - template: jinja
    - defaults:
      Zabbix_Server: 10.10.1.2
    - require:
      - pkg: zabbix-agentd
  service.running:
    - name: zabbix-agentd
    - enable: True
    - watch:
      - file: zabbix-agentd
