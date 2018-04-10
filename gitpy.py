import git
import os
import subprocess

repo = git.Repo(".")
commit = repo.head.commit

print(commit)

diff = repo.git.diff('HEAD~1..HEAD', name_only=True)
if 'Dockerfile' not in diff:
   subprocess.call("./git.sh", shell=True)
