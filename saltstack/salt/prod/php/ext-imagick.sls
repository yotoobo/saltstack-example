imagick-pkg-install:
  pkg.installed:
    - names:
      - ImageMagick-devel

php-ext-imagick:
  file.managed:
    - name: /usr/local/src/imagick-3.4.2.tgz
    - source: salt://files/imagick-3.4.2.tgz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src/ && tar zxf imagick-3.4.2.tgz && cd imagick-3.4.2 && /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make && make install && echo 'extension=imagick.so' >> /usr/local/php/etc/php.ini
    - unless: test -f /usr/local/php/lib/php/extensions/*/imagick.so
    - require:
      - pkg: imagick-pkg-install
      - file: php-ext-imagick
