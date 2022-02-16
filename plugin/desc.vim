
"  File:       desc.vim
"  Author:     Julian Orchard [hello@julianorchard.co.uk]
"  Tag Added:  2022-02-15
"  Desciption: Add a short comment block to files (this!)


" Method taken from the very clean 
" commentary.vim plugin! https://github.com/tpope/vim-commentary
	function! s:comments() abort
		return split(get(b:, 'commentary_format', substitute(substitute(substitute(
			\ &commentstring, '^$', '%s', ''), '\S\zs%s',' %s', ''), '%s\ze\S', '%s ', '')), '%s', 1)
	endfunction

" Write Block Comment Style
	function! s:block(l,r) abort
		let [l,r] = [a:l, a:r]
			iab <expr> desc l . 
				\   "<cr>File:       " . filename 
				\ . "<cr>Author:     " . author
				\	. "<cr>Tag Added:  " . curtime
				\ . "<cr>Desciption:DESCRIPTION<cr><esc>0i" . r 
				\ . "<esc>/DESCRIPTION<cr>cw"
	endfunction

" Write Single Line Comment Style
	function! s:line(l,r) abort
		let [l,r] = [a:l, a:r]
			iab <expr> desc l." File:       " . filename 
			     \ . "<cr>".l." Author:     " . author
			     \ . "<cr>".l." Tag Added:  " . curtime
			     \ . "<cr>".l." Desciption:"
	endfunction

" Author from a config file, eventually
" Update curtime to override with a BufSave?
	let filename = expand('%:t')
	let author  = "Julian Orchard [hello@julianorchard.co.uk]"
	let curtime = strftime("%Y-%m-%d")

	let [l,r] = s:comments()
	if len(r) != 0 
		call s:block(l,r)
	else 
		call s:line(l,r)
	endif

