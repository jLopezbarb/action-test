
#!/bin/bash
set -e
echo $2
GITHUB_TOKEN=$2
VERSION=$1
if [ -z "$VERSION" ]; then
        echo "missing version"
        exit 1
fi

repo="action-test"
git fetch --all
git checkout master
git config user.name "jlopezbarb"
git config user.email "jlopezbarb@gmail.com"
sed -iE 's_FROM\ okteto\/okteto\:latest_FROM\ okteto\/okteto\:'$VERSION'_' Dockerfile
sed -iE 's_FROM\ okteto\/okteto\:[[:digit:]]*\.[[:digit:]]*\.[[:digit:]]*_FROM\ okteto\/okteto\:'$VERSION'_' Dockerfile
echo "Start sequence"
git add .
echo "Added"
error=0
git commit -m "release 1.1.0" || error=1
if [ $error -ne 1 ];then
  echo "commited"
  git push origin master
  git --no-pager log -1
fi
ghr -t ${GITHUB_TOKEN} -replace 1.2.7
ghr -t ${GITHUB_TOKEN} -replace latest
rm -rf $repoPath
