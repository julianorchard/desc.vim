# desc.vim (descriptions)

Tag files with descriptions, date, author, and more! Type `desc` to get
started. Output roughly looks like this by default: 

```
<!-- 
	File:       test.html
	Author:     Julian Orchard [hello@julianorchard.co.uk]
	Tag Added:  2022-02-16
	Desciption: Example of a file description.
-->
```

And, as an example of a single line comment style block of description...

```
# File:       test.sh
# Author:     Julian Orchard [hello@julianorchard.co.uk]
# Tag Added:  2022-02-16
# Desciption: Another example, this time using line comments.
```

This is mainly me having a go at making one of my ideas into a vim plugin, as
nicely as I can make one! Functionality is heavily inspired by
[commentary.vim](https://github.com/tpope/vim-commentary). Please support
[Tpope](https://github.com/tpope) and his amazing work!

## Installation

- using a vim plugin manager (my favourite is [vim-plug]()): 
- manual installation (needs testing): 

```
mkdir -p ~/.vim/pack/julianorchard/start
cd ~/.vim/pack/julianorchard/start
git clone https://github.com/julianorchard/desc.vim
vim -u NONE -c "helptags desc.vim/doc" -c q
```

- or (not ideally...), simply `source` the file in your `.vimrc` (it is a
very, very small plugin)

## FAQ

Similarly to [commentary](https://github.com/tpope/vim-commentary), you can
add your own filetypes by adding lines like this to your `.vimrc`: 

```
autocmd FileType apache setlocal commentstring=#\ %s
```
