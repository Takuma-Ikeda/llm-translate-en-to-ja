#!/bin/bash

type="j2e"

source "./vars.sh"
source "./$type/vars.sh"

is_markdown=false

while getopts ":m" opt; do
    case $opt in
        m)
        is_markdown=true
        ;;
        \?)
        echo "Invalid option: -$OPTARG" >&2
        ;;
        :)
        echo "Option -$OPTARG requires an argument." >&2
        ;;
    esac
done

# ./ja 初期化
mkdir -p "$data_dir"

if [ ! -f "$data_dir/$ja_file" ]; then
    echo "$data_dir/$ja_file が存在しません。空ファイルだけ作成し、処理を終了します。"
    touch "$data_dir/$ja_file"
    exit 1
fi

# ./en 初期化
mkdir -p "$data_dir"

[ -f "$data_dir/$en_file" ] && rm "$data_dir/$en_file"
[ ! -f "$data_dir/$en_file" ] && touch "$data_dir/$en_file"

if [ -f "$data_dir/$ja_file" ] && [ ! -s "$data_dir/$ja_file" ]; then
    echo "$data_dir/$ja_file に日本語文が書かれていないため、処理を終了します"
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
    if $is_markdown; then
        echo "GPT-3.5 Turbo で翻訳開始 [Markdown Summary]"
        "./$type/$cg35_dir/md.sh"
    else
        echo "GPT-3.5 Turbo で翻訳開始"
        "./$type/$cg35_dir/normal.sh"
    fi
elif [ "$REPLY" = '2' ]; then
    if $is_markdown; then
        echo "GPT-4 Turbo で翻訳開始 [Markdown Summary]"
        "./$type/$cg40_dir/md.sh"
    else
        echo "GPT-4 Turbo で翻訳開始"
        "./$type/$cg40_dir/normal.sh"
    fi
fi

# 日本語削除
truncate -s 0 "$data_dir/$ja_file"
echo "$data_dir/$ja_file の日本語文は初期化されました"

# Mac のクリップボードに英語翻訳をコピー
cat "$data_dir/$en_file" | pbcopy
echo "Mac のクリップボードに英語翻訳がコピーされました"
