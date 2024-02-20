#!/bin/bash

type="e2j"

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

# ./en 初期化
mkdir -p "$data_dir"

if [ ! -f "$data_dir/$en_file" ]; then
    echo "$data_dir/$en_file が存在しません。空ファイルだけ作成し、処理を終了します。"
    touch "$data_dir/$en_file"
    exit 1
fi

# ./ja 初期化
mkdir -p "$data_dir"

[ -f "$data_dir/$ja_file" ] && rm "$data_dir/$ja_file"
[ ! -f "$data_dir/$ja_file" ] && touch "$data_dir/$ja_file"

if [ -f "$data_dir/$en_file" ] && [ ! -s "$data_dir/$en_file" ]; then
    echo "$data_dir/$en_file に英文が書かれていないため、処理を終了します"
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

# 英文削除
truncate -s 0 "$data_dir/$en_file"
echo "$data_dir/$en_file の英文は初期化されました"

# Mac のクリップボードに日本語翻訳をコピー
cat "$data_dir/$ja_file" | pbcopy
echo "Mac のクリップボードに日本語翻訳がコピーされました"
