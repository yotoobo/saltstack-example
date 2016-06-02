ldconfig-local-lib:
  file.managed:
    - name: /etc/ld.so.conf.d/local.conf
    - source: salt://init/files/local.conf
    - user: root
    - group: root
    - mode: 644
    - unless: test -f /etc/ld.so.conf.d/local.conf
  cmd.run:
    - name: ldconfig
    - require:
      - file: ldconfig-local-lib
