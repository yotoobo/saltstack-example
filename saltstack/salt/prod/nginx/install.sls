include:
  - pcre.install

nginx-source-install:
  pkg.installed:
    - names:
      - zlib-devel
      - openssl-devel
  file.managed:
    - name: /usr/local/src/tengine-2.1.2.tar.gz
    - source: salt://files/tengine-2.1.2.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src && tar zxf tengine-2.1.2.tar.gz && cd tengine-2.1.2 && ./configure --prefix=/usr/local/nginx && make && make install
    - unless: test -d /usr/local/nginx
    - require:
      - file: nginx-source-install
      - cmd: pcre-source-install
      - pkg: nginx-source-install

nginx-init:
  file.managed:
    - name: /etc/init.d/nginx
    - source: salt://nginx/nginx
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: chkconfig --add nginx
    - unless: chkconfig |grep nginx
    - require:
      - file: nginx-init
      - cmd: nginx-source-install

nginx-conf:
  file.managed:
    - name: /usr/local/nginx/conf/nginx.conf
    - source: salt://nginx/nginx.conf
    - user: root
    - group: root
    - mode: 644

nginx-service:
  file.directory:
    - name: /usr/local/nginx/conf/vhost
    - require:
      - cmd: nginx-source-install
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - cmd: nginx-init
    - watch:
      - file: /usr/local/nginx/conf/nginx.conf
