include:
  - php.install

php-ext-redis:
  file.managed:
    - name: /usr/local/src/redis-2.2.7.tgz
    - source: salt://files/redis-2.2.7.tgz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src/ && tar zxf redis-2.2.7.tgz && cd redis-2.2.7 && /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make && make install && echo 'extension=redis.so' >> /usr/local/php/etc/php.ini
    - unless: test -f /usr/local/php/lib/php/extensions/*/redis.so
    - require:
      - file: php-ext-redis
      - cmd: php-source-install
