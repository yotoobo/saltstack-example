nginx-conf:
  file.managed:
    - name: /usr/local/nginx/conf/nginx.conf
    - source: salt://nlb/nginx.conf
    - user: root
    - group: root
    - mode: 644

nginx-service:
  file.directory:
    - name: /usr/local/nginx/conf/vhost
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - watch:
      - file: /usr/local/nginx/conf/nginx.conf
