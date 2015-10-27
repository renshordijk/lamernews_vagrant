git-application-lamernews:
  git.latest:
    - name: https://github.com/renshordijk/lamernews.git
    - rev: master
    - target: /opt/lamernews
    - require:
      - pkg: git
