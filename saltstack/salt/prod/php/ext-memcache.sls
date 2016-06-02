include:
  - php.install

php-ext-memcache:
  file.managed:
    - name: /usr/local/src/memcache-3.0.8.tgz
    - source: salt://files/memcache-3.0.8.tgz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src/ && tar zxf memcache-3.0.8.tgz && cd memcache-3.0.8 && /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make && make install && echo 'extension=memcache.so' >> /usr/local/php/etc/php.ini
    - unless: test -f /usr/local/php/lib/php/extensions/*/memcache.so
    - require:
      - file: php-ext-memcache
      - cmd: php-source-install
