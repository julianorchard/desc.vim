# desc.vim (descriptions)

Tag files with descriptions, date, author, and more! Type `desc` to get
started. Output roughly looks like this by default: 

```
<!--
File:       README.md
Author:     julianorchard <hello@julianorchard.co.uk>
Tag Added:  2022-03-11
Desciption: This is an example description.
-->
```

By default, it pulls your Git user.name and user.email global variables to use
as the Author part of the tag, but this can be [customized](#Customization).

Additionally, you can [change the
keyword](#change-keyword--multi-signature-support) that triggers the description to be
inserted, and you can add multiple signatures in this way too. 

Method for attaining the comment character is heavily influenced by [vim-commentary](https://github.com/tpope/vim-commentary).

## Installation

Using a vim plugin manager (my favourite being [vim-plug](https://github.com/junegunn/vim-plug)). 

1. Add `Plug 'julianorchard/desc.vim'` to your `.vimrc` file
2. Run `:PlugInstall` 

## Customization

There are some important customizations that can be made, especially if you're
not using Git.

### Your Details/Signature

Add a line in your `.vimrc` file like this:

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
