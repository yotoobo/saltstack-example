/etc/security/limits.conf:
  file.append:
    - text:
      - '*    soft    nofile    65535'
      - '*    hard    nofile    65535'
    - unless: grep nofile limits.conf|grep -v '^#'
