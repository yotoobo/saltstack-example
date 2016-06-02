/etc/profile:
  file.append:
    - text:
      - export HISTTIMEFORMAT="%F %T `whoami` "
    - unless: grep 'HISTTIMEFORMAT' /etc/profile
