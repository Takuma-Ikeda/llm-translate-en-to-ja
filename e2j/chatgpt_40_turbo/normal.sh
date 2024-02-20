#!/bin/bash

type="e2j"

source "./vars.sh"
source "./$type/vars.sh"

cat "$data_dir/$en_file" | llm -m 4-turbo -s "$prompt" > "$data_dir/$ja_file"
