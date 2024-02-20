#!/bin/bash

type="e2j"

source "./vars.sh"
source "./$type/vars.sh"

cat "$data_dir/$en_file" | llm -m gpt-3.5-turbo -s "$prompt" > "$data_dir/$ja_file"
