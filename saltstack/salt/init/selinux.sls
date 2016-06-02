/etc/selinux/config:
  cmd.run:
    - name: sed -i 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config && setenforce 0
    - unless: grep 'SELINUX=disabled' /etc/selinux/config
