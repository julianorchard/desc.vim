# desc.vim (descriptions)

Tag files with descriptions, date, author, and more! Type `desc` to get
started. Output roughly looks like this by default: 

```
<!-- 
File:       test.html
Tag Added:  2022-02-16
Desciption: Example of a file description.
-->
```

Method for attaining the comment character is heavily influenced by [vim-commentary](https://github.com/tpope/vim-commentary).

## Installation

Using a vim plugin manager (my favourite being [vim-plug](https://github.com/junegunn/vim-plug)). 

1. Add `Plug 'julianorchard/desc.vim'` to your `.vimrc` file
2. Run `:PlugInstall` 

## Customisation

There are some vital (and not so vital) customisations that need to be made!
Most vital is...

### Your Details/Signature

You'll want to use your own name as the Author (I assume). To do so, add a line
in your `.vimrc` file like this:

```
	let g:desc_author = "Example <example@email.com>"
```

This will give you something like this: 

```
<!--
File:       README.md
Author:     Example <example@email.com>
Tag Added:  2022-03-09
Desciption: Another example description.
-->
```

### Change Keyword / Multi-Signature Support

Change the keyword that triggers the description adding by converting the
variable you just definied to a list. This will look like this: 

```
" Use 'descrip' instead of 'desc' at trigger
	let g:desc_author = [["descrip", "Example <example@email.com>"]]
```

To add multiple descriptions, just keep adding to the list, like so: 

```
	let g:desc_author = [["desc",    "Example <example@email.com>"],
	                    \["descrip", "Another Example <another@email.com>"]]
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
