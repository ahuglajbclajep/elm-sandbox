#!/bin/bash -ex

if [ $# -lt 2 ]; then
  echo 'コミットメッセージとプロジェクトの指定が必要です'
  exit 1
fi

for dir in ${@:2}; do
  cd $dir
  elm-app build
  cd ..
done

if [ `git branch --list gh-pages` ]; then
  git checkout gh-pages
  git rm -rq --ignore-unmatch ${@:2}
else
  git checkout --orphan gh-pages
  git rm -rfq .
  echo 'elm-stuff' > .gitignore
fi

for dir in ${@:2}; do
  mv $dir/build/* $dir
done
git add -A
git commit -m "$1"
