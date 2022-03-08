"  File:       desc.vim
"  Author:     Julian Orchard [hello@julianorchard.co.uk]
"  Tag Added:  2022-02-15
"  Desciption: Add a short comment block to files (this!)


" Method inspired by commentary.vim 
" https://github.com/tpope/vim-commentary
	function! s:comments() abort
		return split(get(b:, 'commentary_format', 
					\ &commentstring), '%s', 1)
	endfunction


" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
" Write Block Comment Style
	function! s:block(l,r) abort
		let [l,r] = [a:l, a:r]
			iab <expr> desc l . 
				\   "<cr>File:       " . filename 
				\ . "<cr>Author:     " . author
				\ . "<cr>Tag Added:  " . datestr
				\ . "<cr>Desciption:DESCRIPTION<cr><esc>0i" . r 
				\ . "<esc>/DESCRIPTION<cr>cw"
	endfunction
" Write Single Line Comment Style
	function! s:line(l) abort
		let [l] = [a:l]
			iab <expr> desc l." File:       " . filename 
			     \ . "<cr>".l." Author:     " . author
			     \ . "<cr>".l." Tag Added:  " . datestr
			     \ . "<cr>".l." Desciption:"
	endfunction
" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
" Write Block Comment Style
	function! s:noauthblock(l,r) abort
		let [l,r] = [a:l, a:r]
			iab <expr> desc l . 
				\   "<cr>File:       " . filename 
				\ . "<cr>Tag Added:  " . datestr
				\ . "<cr>Desciption:DESCRIPTION<cr><esc>0i" . r 
				\ . "<esc>/DESCRIPTION<cr>cw"
	endfunction
" Write Single Line Comment Style
	function! s:noauthline(l) abort
		let [l] = [a:l]
			iab <expr> desc l." File:       " . filename 
			     \ . "<cr>".l." Tag Added:  " . datestr
			     \ . "<cr>".l." Desciption:"
	endfunction
" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

" Author from a config file, eventually
" Update curtime to override with a BufSave?
	let filename = expand('%:t')
	let s:noauth = 0
" Author
	if exists('g:desc_author') 
		let author = get(g:, 'desc_author')
	else 
		"default
		let s:noauth = 1
	endif
" Date Format
	if exists('g:desc_dateformat')
		let datestr = strftime(get(g:, 'desc_dateformat'))
	else
		"default
		let datestr = strftime("%Y-%m-%d")
	endif

	let author = get(desc_shortcut, 0, "")
	let shortcut = get(desc_shortcut, 1, "")
	echo author
	echo shortcut

	let [l,r] = s:comments()
	if len(r) != 0 && s:noauth==0
		call s:block(l,r)
	elseif len(r) == 0 && s:noauth==0 
		call s:line(l)
	elseif len(r) != 0 
		call s:noauthblock(l,r)
	else 
		call s:noauthline(l)
	endif
