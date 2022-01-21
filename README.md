# vim-tadasv-zet

This is my personal note taking plugin.

## Installation

Place this repository in your `~/.vim/pack/<whatever>/start/` directory.

Make sure your shell exports `ZET_DIR` environment variable. This variable must
point to a path for storing notes.

Run `vim -c ZSetup` to create root note and setup `ZET_DIR`.


## ZET\_DIR

Layout of `ZET_DIR`:

```
$ZET_DIR
|__ z
|   |__ 2022010603
|   |__ ...
|   
|__ z-root
```

All notes are stored in `z` subdirectory as plain text files. `z-root` contains a link
to the root note, e.g. `z/2022010603`.


## Commands

| Command | Description |
|---------|-------------|
| :ZMain  | Opens root note that's listed in `z-root` file |
| :ZRefs  | Opens a quickfix window with notes containing references to the note that's being edited. |
| :Zet    | Creates a new note. |
| :ZInsert | Creates a new link, and opens it in a new window. Reference to the new note will be added to the previous buffer. |

## Navigation

You can jump around notes with `gf` when cursor is over a note reference (`z/*`
file).

## Helper scripts

I have the following helper script called `zet` in path `PATH`.

```bash
#!/bin/bash
cd "$ZET_DIR"

case "$1" in
	find)
		shift;
		IFS=$'\n'
		select selection in $(grep -ri "$@" z/) ; do
			file=$(echo $selection | awk -F: '{ print $1 }')
			vim "$file"
		done
		;;
	z/*)
		exec vim "$1";
		;;
	*)
		exec vim -c ZMain
		;;
esac
```

This lets me quickly open main note with `zet`. I can also quickly search 
through notes with `zet find <some text>`.
