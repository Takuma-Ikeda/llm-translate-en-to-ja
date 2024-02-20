#!/bin/bash

type="j2e"

source "./$type/vars.sh"

# ./ja 初期化
mkdir -p "$ja_dir"

if [ ! -f "$ja_dir/$ja_file" ]; then
    echo "$ja_dir/$ja_file が存在しません。空ファイルだけ作成し、処理を終了します。"
    touch "$ja_dir/$ja_file"
    exit 1
fi

# ./en 初期化
mkdir -p "$en_dir"

[ -f "$en_dir/$en_file" ] && rm "$en_dir/$en_file"
[ ! -f "$en_dir/$en_file" ] && touch "$en_dir/$en_file"

if [ -f "$ja_dir/$ja_file" ] && [ ! -s "$ja_dir/$ja_file" ]; then
    echo "$ja_dir/$ja_file に日本語文が書かれていないため、処理を終了します"
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
    "./$type/chatgpt_35_turbo.sh"
elif [ "$REPLY" = '2' ]; then
    echo "GPT-4 Turbo で翻訳開始"
    "./$type/chatgpt_40_turbo.sh"
fi

# 日本語削除
truncate -s 0 "$ja_dir/$ja_file"
echo "$ja_dir/$ja_file の日本語文は初期化されました"

# Mac のクリップボードに英語翻訳をコピー
cat "$en_dir/$en_file" | pbcopy
echo "Mac のクリップボードに英語翻訳がコピーされました"
