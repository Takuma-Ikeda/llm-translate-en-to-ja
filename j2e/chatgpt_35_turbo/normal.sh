#!/bin/bash

type="j2e"

source "./vars.sh"
source "./$type/vars.sh"

cat "$data_dir/$ja_file" | llm -m gpt-3.5-turbo -s "$prompt" > "$data_dir/$en_file"
