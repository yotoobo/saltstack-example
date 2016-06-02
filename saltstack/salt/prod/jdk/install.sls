jdk-config:
  file.append:
    - name: /etc/profile
    - text:
      - JAVA_HOME="/usr/local/jdk/default"
      - CLASS_PATH="$JAVA_HOME/lib:$JAVA_HOME/jre/lib"
      - PATH=".:$PATH:$JAVA_HOME/bin"
      - export JAVA_HOME PATH
    - require:
      - cmd: jdk-bin-install
jdk-bin-install:
  file.managed:
    - name: /usr/local/src/jdk-7u80-linux-x64.tar.gz
    - source: salt://files/jdk-7u80-linux-x64.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: mkdir /usr/local/jdk/ && cd /usr/local/src/ && tar zxf jdk-7u80-linux-x64.tar.gz && mv jdk1.7.0_80 /usr/local/jdk/ && ln -s /usr/local/jdk/jdk1.7.0_80 /usr/local/jdk/default
    - unless: test -d /usr/local/jdk/jdk1.7.0_80
    - require:
      - file: jdk-bin-install
