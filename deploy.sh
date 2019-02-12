#!/bin/sh

rm -rf .deploy_git

git clone --branch=master https://github.com/tpscash/tpscash.github.io .deploy_git

hexo clean
hexo g -d
