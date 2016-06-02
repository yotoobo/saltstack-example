include:
  - init.install

jemalloc-source-install:
  file.managed:
    - name: /usr/local/src/jemalloc-4.2.0.tar.bz2
    - source: salt://files/jemalloc-4.2.0.tar.bz2
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src/ && tar jxf jemalloc-4.2.0.tar.bz2  #&& cd jemalloc-4.2.0 && ./configure --prefix=/usr/local/jemalloc && make && make install
    - unless: test -d /usr/local/jemalloc
    - require:
      - file: jemalloc-source-install
      - pkg: pkg-install
