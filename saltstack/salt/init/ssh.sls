sshd-config:
  cmd.run:
    - name: sed -i 's/^#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config && service sshd restart
    - onlyif: grep '^#UseDNS yes' /etc/ssh/sshd_config
