import git
import os
import subprocess

repo = git.Repo(".")
commit = repo.head.commit

print(commit)

diff = repo.git.diff('HEAD~1..HEAD', name_only=True)
if 'Dockerfile' not in diff:
   print("Changing Ports in necessary files.")
   subprocess.call("./git.sh", shell=True)
   subprocess.call("git add .", shell=True)
   subprocess.call("git config --global user.email 'ratulbasak93@gmail.com'", shell=True)
   subprocess.call("git config --global user.name 'ratulbasak93'", shell=True)
   subprocess.call("git commit -m 'updated repo'", shell=True)
   subprocess.call("git push origin master", shell=True)
   subprocess.call("zip -r dotnet-api.zip ./*", shell=True)
   subprocess.call("python s3_upload.py codebase-build dotnet-api.zip dotnet-api.zip", shell=True)

else:
    print("Do Nothing! Dockerfile found in last commit")

