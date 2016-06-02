php-libmysqlclient:
  pkg.installed:
    - names:
      - mysql-community-devel
  cmd.run:
    - name: ln -s /usr/lib64/mysql/libmysqlclient.so /usr/lib/
    - unless: test -f /usr/lib/libmysqlclient.so
    - require:
      - pkg: php-libmysqlclient

php-source-install:
  file.managed:
    - name: /usr/local/src/php-5.3.29.tar.gz
    - source: salt://files/php-5.3.29.tar.gz
    - user: root
    - group: root
    - mode: 644
  pkg.installed:
    - names:
      - libxml2-devel
      - libjpeg-turbo-devel
      - libpng-devel
      - freetype-devel
      - bzip2
      - bzip2-devel
      - libcurl-devel
      - t1lib-devel
      - libmcrypt-devel
      - openssl-devel
      - libxslt-devel
      - re2c
      - libtool-ltdl-devel
  cmd.run:
    - name: cd /usr/local/src/ && tar zxf php-5.3.29.tar.gz && cd php-5.3.29 && ./configure --prefix=/usr/local/php --with-config-file-path=/usr/local/php/etc --enable-fpm --enable-bcmath --enable-sockets --enable-shmop --enable-zip --enable-soap --enable-pcntl --enable-mbstring --with-gd --with-jpeg-dir --with-png-dir --enable-gd-native-ttf --with-freetype-dir --with-bz2 --with-xmlrpc --with-xsl --with-zlib --with-mhash --with-mcrypt --with-mysql --with-mysqli --with-curl --with-t1lib --with-gettext --with-openssl --disable-fileinfo && make && make install
    - unless: test -d /usr/local/php
    - require:
      - file: php-source-install
      - pkg: php-source-install
      - cmd: php-libmysqlclient

/usr/local/php/etc/php.ini:
  file.managed:
    - source: salt://php/php.ini
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: php-source-install

/usr/local/php/etc/php-fpm.conf:
  file.managed:
    - source: salt://php/php-fpm.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: php-source-install

php-ext-pdo-mysql:
  cmd.run:
    - name: cd /usr/local/src/php-5.3.29/ext/pdo_mysql/ && /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make && make install
    - unless: test -f /usr/local/php/lib/php/extensions/*/pdo_mysql.so
    - require:
      - file: /usr/local/php/etc/php.ini

php-ext-memcache:
  file.managed:
    - name: /usr/local/src/memcache-3.0.8.tgz
    - source: salt://files/memcache-3.0.8.tgz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src/ && tar zxf memcache-3.0.8.tgz && cd memcache-3.0.8 && /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make && make install
    - unless: test -f /usr/local/php/lib/php/extensions/*/memcache.so
    - require:
      - file: php-ext-memcache
      - cmd: php-source-install

php-ext-redis:
  file.managed:
    - name: /usr/local/src/redis-2.2.7.tgz
    - source: salt://files/redis-2.2.7.tgz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src/ && tar zxf redis-2.2.7.tgz && cd redis-2.2.7 && /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make && make install
    - unless: test -f /usr/local/php/lib/php/extensions/*/redis.so
    - require:
      - file: php-ext-redis
      - cmd: php-source-install

php-fpm:
  cmd.run:
    - name: cp /usr/local/src/php-5.3.29/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm && chmod 755 /etc/init.d/php-fpm && chkconfig --add php-fpm
    - unless: chkconfig |grep php-fpm
    - require:
      - cmd: php-source-install
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /usr/local/php/etc/php.ini
