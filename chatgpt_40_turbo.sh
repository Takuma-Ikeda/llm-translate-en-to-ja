#!/bin/bash

source ./vars.sh

cat "$en_dir/$en_file" | llm -m 4-turbo -s "この英語の文章を日本語に翻訳してください。翻訳する際、日本語の句読点や読点のあとに改行を入れて見やすくして下さい。" > "$ja_dir/$ja_file"
