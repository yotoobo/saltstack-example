nginx-conf:
  file.managed:
    - name: /usr/local/nginx/conf/nginx.conf
    - source: salt://nlb/nginx.conf
    - user: root
    - group: root
    - mode: 644

/usr/local/nginx/conf/vhost:
  file.recurse:
    - source: salt://nlb/vhost
    - dir_mode: 755
    - file_mode: 644

nginx-service:
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - file: /usr/local/nginx/conf/vhost
    - watch:
      - file: /usr/local/nginx/conf/vhost

