#! /bin/sh
repoName=$1

while [ -z "$repoName"]
do
    echo 'Provide a repo name'
    read -r -p $'Repository name:' repoName
done

mkdir $repoName
cd $repoName

echo "# $repoName" >> README.md
git init
git add .
git commit -m "First commit"

curl -u sjimster https://api.github.com/user/repos -d '{"name": "'"$repoName"'", "private":false}'

GIT_URL=$(curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/repos/sjimster/"$repoName" | jq -r '.clone_url')

git branch -M main
git remote add origin $GIT_URL
git push -u origin main