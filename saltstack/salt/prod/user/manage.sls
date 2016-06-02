work:
  user.present:
    - fullname: Work
    - unless: grep work /etc/passwd
    - shell: /bin/bash
    - home: /home/work
    - uid: 1000
    - gid: 1000
    - groups:
      - wheel
    - require:
      - cmd: work
  cmd.run:
    - name: groupadd -g 1000 work
    - unless: grep work /etc/groups

rsync_work_key:
  file.managed:
    - name: /home/work/.ssh/authorized_keys
    - source: salt://files/authorized_keys
    - user: work
    - group: work
    - mode: 600
    - require:
      - cmd: rsync_work_key
  cmd.run:
    - name: mkdir /home/work/.ssh && chown work.work /home/work/.ssh && chmod 700 /home/work/.ssh
