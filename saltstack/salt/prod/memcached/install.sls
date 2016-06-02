libevent-source-install:
  file.managed:
    - name: /usr/local/src/libevent-2.0.22-stable.tar.gz
    - source: salt://files/libevent-2.0.22-stable.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src/ && tar zxf libevent-2.0.22-stable.tar.gz && cd libevent-2.0.22-stable && ./configure && make && make install
    - require:
      - file: libevent-source-install

memcache-source-install:
  file.managed:
    - name: /usr/local/src/memcached-1.4.25.tar.gz
    - source: salt://files/memcached-1.4.25.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src/ && tar xf memcached-1.4.25.tar.gz && cd memcached-1.4.25 && ./configure --prefix=/usr/local/memcached --with-libevent=/usr/local/ && make && make install
    - require:
      - cmd: libevent-source-install
