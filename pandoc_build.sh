#!/bin/bash

SETTING_FILE=pandoc_config.yaml

# --------------------------------
#  ビルド処理
#  バグなどでオプション付与が必要な場合に備えて
#  出力形式ごとに初期を記載する
# --------------------------------

# html
if [ "$1" == "html" ]; then
    pandoc -d $SETTING_FILE -d conf/$1.yaml
    exit 0
fi

# epub
if [ "$1" == "epub" ]; then
    pandoc -d $SETTING_FILE -d conf/$1.yaml
    exit 0
fi

# latex
if [ "$1" == "latex" ]; then
    pandoc -d $SETTING_FILE -d conf/$1.yaml
    exit 0
fi

# pdf
if [ "$1" == "pdf" ]; then
    pandoc -d $SETTING_FILE -d conf/$1.yaml
    exit 0
fi

# 処理終了
echo "Invalid argument: $1"
exit 1
