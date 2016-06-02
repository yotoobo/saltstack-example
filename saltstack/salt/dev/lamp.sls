lamp-pkg-install:
  pkg.installed:
    - names:
      - php
      - php-fpm
      - php-mysql
      - mysql

apache2-server:
  pkg.installed:
    - name: httpd
  file.managed:
    - name: /etc/httpd/conf/httpd.conf
    - source: salt://files/httpd.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      HOST: {{ pillar['apache']['HOST'] }}
      PORT: {{ pillar['apache']['PORT'] }}
    - require:
      - pkg: apache2-server
  service.running:
    - name: httpd
    - enable: True
    - reload: True
    - watch:
      - file: apache2-server

mysql-server:
  pkg.installed:
    - name: mysql-server
    - require_in:
      - file: mysql-server
  file.managed:
    - name: /etc/my.cnf
    - source: salt://files/my.cnf
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: mysqld
    - enable: True
