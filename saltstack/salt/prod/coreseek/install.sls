coreseek-mmseg-install:
  pkg.installed:
    - names:
      - gcc
      - gcc-c++
      - automake
      - autoconf
      - libtool
      - mysql-community-devel
  file.managed:
    - name: /usr/local/src/coreseek-4.1-beta.tar.gz
    - source: salt://files/coreseek-4.1-beta.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src && tar zxf coreseek-4.1-beta.tar.gz && cd coreseek-4.1-beta/mmseg-3.2.14/ && ./bootstrap && ./configure --prefix=/usr/local/mmseg3 && make && make install
    - unless: test -d /usr/local/mmseg3
    - require:
      - file: coreseek-mmseg-install
      - pkg: coreseek-mmseg-install

libiconv-install:
  file.managed:
    - name: /usr/local/src/libiconv-1.14.tar.gz
    - source: salt://files/libiconv-1.14.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src && tar zxf libiconv-1.14.tar.gz && cd libiconv-1.14 && ./configure && make && make install && ldconfig
    - unless: test -f /usr/local/lib/libiconv.so
    - require:
      - file: libiconv-install

coreseek-source-install:
  cmd.run:
    - name: cd /usr/local/src/coreseek-4.1-beta/csft-4.1/ && sh buildconf.sh && ./configure --prefix=/usr/local/coreseek --with-mmseg --with-mmseg-includes=/usr/local/mmseg3/include/mmseg/ --with-mmseg-libs=/usr/local/mmseg3/lib/ --with-mysql LIBS=-liconv && make && make install
    - unless: test -d /usr/local/coreseek
    - require:
      - cmd: coreseek-mmseg-install
