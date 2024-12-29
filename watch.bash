#! /usr/bin/env bash
# nix-shell -i bash -p inotify-tools 
inotifywait -r -m ./src-pure ./src-tauri -e create -e moved_to |
    while read path action file; do
        # echo "The file'$file' appeared in directory '$path' via '$action'"
        # do something with the file
        echo "$path"
        cd "$path" || exit; spago bundle --outfile ../src/main.js
        cd ".." || exit; pnpm tauri dev
    done
