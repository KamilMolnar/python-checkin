#!/usr/bin/env bash

#ensure git command is present
#command -v git || exit 0
#fetch file content from git server
#(script.sh from script branch)


#option 1 curl <url> | bash

#option 2 - store to variable/file and execute

which git > /dev/null 2> /dev/null || {
	echo "command git not present, exitting..."
	exit 0
}
#make temp dir, clone git repo under name 'myrepodir'
tmpdir="$(mktemp -d tmpdir.XXXXXXX)"
cd "$tmpdir"
git clone 'git@github.com:KamilMolnar/python-checkin.git' myrepodir
cd myrepodir

#switch to branch script
git branch -a
git checkout script
#clone git repo and, switch to branch script and run the script
ls -la
pwd
./script.sh


echo "end of bash script."

echo "executing python.py"

command -v python3 >/dev/null 2>&1 || {
	echo "command python3 not found, exitting..."
	exit 0
}

./python.py

current_branch="$(git branch | grep \* | awk '{print $2}')"

echo "your current branch is $current_branch"



