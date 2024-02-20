#!/bin/bash

source ./vars.sh

# ./en 初期化
mkdir -p "$en_dir"

if [ ! -f "$en_dir/$en_file" ]; then
    echo "$en_dir/$en_file が存在しません。空ファイルだけ作成し、処理を終了します。"
    touch "$en_dir/$en_file"
    exit 1
fi

# ./ja 初期化
mkdir -p "$ja_dir"

[ -f "$ja_dir/$ja_file" ] && rm "$ja_dir/$ja_file"
[ ! -f "$ja_dir/$ja_file" ] && touch "$ja_dir/$ja_file"

if [ -f "$en_dir/$en_file" ] && [ ! -s "$en_dir/$en_file" ]; then
    echo "$en_dir/$en_file に英文が書かれていないため、処理を終了します"
    exit 1
fi

# 学習モデル選択肢
select version in "GPT-3.5 Turbo" "GPT-4 Turbo";
do
    if [ -z "$version" ]; then
        continue
    else
        break
    fi
done

if [ "$REPLY" = '1' ]; then
    echo "GPT-3.5 Turbo で翻訳開始"
    ./chatgpt_35_turbo.sh
elif [ "$REPLY" = '2' ]; then
    echo "GPT-4 Turbo で翻訳開始"
    ./chatgpt_40_turbo.sh
fi

# 英文削除
truncate -s 0 "$en_dir/$en_file"
echo "$en_dir/$en_file の英文は初期化されました"

# Mac のクリップボードに日本語翻訳をコピー
cat "$ja_dir/$ja_file" | pbcopy
echo "Mac のクリップボードに日本語翻訳がコピーされました"
