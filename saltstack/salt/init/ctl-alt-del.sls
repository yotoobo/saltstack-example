disable-ctl-alt-del:
  cmd.run:
    - name: sed -i 's/^exec/#exec/' /etc/init/control-alt-delete.conf
    - onlyif: grep '^exec' /etc/init/control-alt-delete.conf
