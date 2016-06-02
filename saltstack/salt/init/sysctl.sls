vm.swappiness:
  sysctl.present:
    - value: 0

net.core.netdev_max_backlog:
  sysctl.present:
    - value: 32768
net.core.somaxconn:
  sysctl.present:
    - value: 32768
net.core.wmem_default:
  sysctl.present:
    - value: 8388608
net.core.rmem_default:
  sysctl.present:
    - value: 8388608
net.core.rmem_max:
  sysctl.present:
    - value: 16777216
net.core.wmem_max:
  sysctl.present:
    - value: 16777216

net.ipv4.tcp_max_syn_backlog:
  sysctl.present:
    - value: 65535
net.ipv4.tcp_timestamps:
  sysctl.present:
    - value: 0
net.ipv4.tcp_synack_retries:
  sysctl.present:
    - value: 2
net.ipv4.tcp_syn_retries:
  sysctl.present:
    - value: 2
net.ipv4.tcp_tw_recycle:
  sysctl.present:
    - value: 1
net.ipv4.tcp_tw_reuse:
  sysctl.present:
    - value: 1
net.ipv4.tcp_fin_timeout:
  sysctl.present:
    - value: 30
net.ipv4.tcp_mem:
  sysctl.present:
    - value: 94500000 915000000 927000000
net.ipv4.tcp_max_orphans:
  sysctl.present:
    - value: 3276800
net.ipv4.ip_local_port_range:
  sysctl.present:
    - value: 1024 65535

