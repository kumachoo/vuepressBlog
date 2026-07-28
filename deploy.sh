#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 进入构建目录前保存当前仓库地址，避免推送到已经迁移的旧账号。
REPOSITORY_URL="$(git config --get remote.origin.url)"

# 生成静态文件
npm run docs:build

# 进入生成的文件夹
cd docs/.vuepress/dist

# 如果是发布到自定义域名
# echo 'www.example.com' > CNAME

git init
git add -A
git commit -m 'deploy'

# 如果发布到 https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git master

# 如果发布到 https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:<USERNAME>/<REPO>.git master:gh-pages
git push -f "$REPOSITORY_URL" master:gh-pages


cd -
