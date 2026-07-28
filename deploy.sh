#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 进入构建目录前保存当前仓库地址，避免推送到已经迁移的旧账号。
REPOSITORY_URL="$(git config --get remote.origin.url)"
COMMIT_AUTHOR_NAME="$(git config --get user.name)"
COMMIT_AUTHOR_EMAIL="$(git config --get user.email)"

if [ -z "$COMMIT_AUTHOR_NAME" ] || [ -z "$COMMIT_AUTHOR_EMAIL" ]; then
  echo "请先配置当前仓库的 git user.name 和 user.email"
  exit 1
fi

# 生成静态文件
npm run docs:build

# 进入生成的文件夹
cd docs/.vuepress/dist

# 如果是发布到自定义域名
# echo 'www.example.com' > CNAME

git init
git add -A
git \
  -c user.name="$COMMIT_AUTHOR_NAME" \
  -c user.email="$COMMIT_AUTHOR_EMAIL" \
  commit -m 'deploy'

# 如果发布到 https://<USERNAME>.github.io
# git push -f git@github.com:<USERNAME>/<USERNAME>.github.io.git master

# 如果发布到 https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:<USERNAME>/<REPO>.git master:gh-pages
git push -f "$REPOSITORY_URL" master:gh-pages


cd -
