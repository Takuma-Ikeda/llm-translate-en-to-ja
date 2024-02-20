#!/bin/bash

source ./vars.sh

cat "$en_dir/$en_file" | llm -m 4-turbo -s "$prompt" > "$ja_dir/$ja_file"
