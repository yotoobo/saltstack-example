yum-base-163:
  cmd.run:
    - name: mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
    - unless: test -f /etc/yum.repos.d/CentOS-Base.repo.backup
  file.managed:
    - name: /etc/yum.repos.d/CentOS-Base.repo
    - source: salt://init/files/CentOS6-Base-163.repo
    - user: root
    - group: root
    - require:
      - cmd: yum-base-163

yum-epel-install:
  cmd.run:
    - name: yum -y install epel-release
    - unless: rpm -qa|grep epel-release

pkg-mysql-community-install:
  cmd.run:
    - name: rpm -ivh http://repo.mysql.com//mysql57-community-release-el6-8.noarch.rpm
    - unless: rpm -qa|grep mysql57

yum-mysql-community-repo:
  file.managed:
    - name: /etc/yum.repos.d/mysql-community.repo
    - source: salt://init/files/mysql-community.repo
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: pkg-mysql-community-install

yum-makecache:
  cmd.run:
    - name: yum clean all && yum makecache
    - require:
      - file: yum-base-163
      - cmd: yum-epel-install
