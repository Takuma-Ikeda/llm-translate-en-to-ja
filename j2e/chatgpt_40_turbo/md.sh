#!/bin/bash

type="j2e"

source "./vars.sh"
source "./$type/vars.sh"

cat "$data_dir/$ja_file" | llm -m 4-turbo -s "$prompt_md" > "$data_dir/$en_file"
