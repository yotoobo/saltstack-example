include:
  - init.install

pcre-source-install:
  file.managed:
    - name: /usr/local/src/pcre-8.38.tar.gz
    - source: salt://files/pcre-8.38.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src/ && tar zxf pcre-8.38.tar.gz && cd pcre-8.38 && ./configure && make && make install && ldconfig
    - unless: test -f /usr/local/bin/pcre-config
    - require:
      - file: pcre-source-install
      - pkg: pkg-install
