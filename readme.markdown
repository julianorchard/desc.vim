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

Inspired by [commentary](https://github.com/tpope/vim-commentary).

## Installation

Using a vim plugin manager (my favourite being [vim-plug](https://github.com/junegunn/vim-plug)). 

1. Add `Plug 'julianorchard/desc.vim'` to your `.vimrc` file
2. Run `:PlugInstall` 

## Customisation

There are some vital (and not so vital) customisations that need to be made!
Most vital is...

### Your Details

You'll want to use your own name as the Author (I assume). To do so, add a line
in your `.vimrc` file like this:

```
	let g:desc_author = "Your Name [example@email.com]"
```

### Custom Date/Time

Similarly, you can change the type of date/time shown in the file
description;

```
" This prints the date like Wed 16 Feb 2022
	let g:desc_dateformat = "%a %d %b %Y"
```

The default for this is `%Y-%m-%d`, or yyyy-mm-dd.

### Custom Filetypes

Just like in [vim-commentary](https://github.com/tpope/vim-commentary), you can
add your own filetypes by adding lines like this to your `.vimrc`: 

```
autocmd FileType apache setlocal commentstring=#\ %s
```

## Help / Contribute

This is currently under some development. If you want help or have anything
to contribute, please get in [contact](mailto:hello@julianorchard.co.uk).
