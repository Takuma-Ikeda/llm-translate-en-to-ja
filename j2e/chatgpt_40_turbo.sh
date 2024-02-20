#!/bin/bash

type="j2e"

source "./$type/vars.sh"

cat "$ja_dir/$ja_file" | llm -m 4-turbo -s "$prompt" > "$en_dir/$en_file"
