git-application-lamernews:
  git.latest:
    - name: https://github.com/renshordijk/lamernews.git
    - rev: master
    - target: /opt/lamernews
    - require:
      - pkg: git

lamernews-run:
  cmd.run:
    - name: /usr/bin/ruby /opt/lamernews/app.rb -o 0.0.0.0 > /dev/null 2>&1 &
    - user: ruby
    - group: ruby
