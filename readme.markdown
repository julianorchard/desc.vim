# desc.vim (descriptions)

Tag files with descriptions, date, author, and more! Type `desc` to get
started. 

Heavily inspired by
[commentary.vim](https://github.com/tpope/vim-commentary). Please support
Tpope and his amazing work!

## Installation

- using a vim plugin manager (my favourite is [vim-plug]()): 
- manual installation (needs testing): 

```
mkdir -p ~/.vim/pack/julianorchard/start
cd ~/.vim/pack/julianorchard/start
git clone https://github.com/julianorchard/desc.vim
vim -u NONE -c "helptags desc.vim/doc" -c q
```

- or (not ideally...), simply `source` the file in your `.vimrc`

## FAQ

Similarly to [commentary](https://github.com/tpope/vim-commentary), you can
add your own filetypes by adding lines like this to your `.vimrc`: 

```
autocmd FileType apache setlocal commentstring=#\ %s
```
