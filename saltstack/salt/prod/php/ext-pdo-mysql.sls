include:
  - php.install

php-ext-pdo-mysql:
  cmd.run:
    - name: cd /usr/local/src/php-5.3.29/ext/pdo_mysql/ && /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make && make install && echo 'extension=pdo_mysql.so' >> /usr/local/php/etc/php.ini
    - unless: test -f /usr/local/php/lib/php/extensions/*/pdo_mysql.so
    - require:
      - file: /usr/local/php/etc/php.ini
      - cmd: php-source-install
