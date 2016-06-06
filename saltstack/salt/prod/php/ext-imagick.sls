include:
  - php.install

imagemagick-source-install:
  file.managed:
    - name: /usr/local/src/ImageMagick.tar.gz
    - source: salt://files/ImageMagick.tar.gz
    - user: root
    - group: root
  cmd.run:
    - name: cd /usr/local/src/ && tar zxf ImageMagick.tar.gz && cd ImageMagick-7.0.1-9 && ./configure --prefix=/usr/local/imagemagick && make && make install && echo '/usr/local/imagemagick/lib' > /etc/ld.so.conf.d/imagemagick.conf && ldconfig && ln -s /usr/local/imagemagick/bin/MagickWand-config /usr/local/bin/
    - unless: test -d /usr/local/imagemagick
    - require:
      - file: imagemagick-source-install

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
      - file: php-ext-imagick
      - cmd: php-source-install
