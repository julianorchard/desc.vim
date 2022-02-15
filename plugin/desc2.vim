
" This is basically how tpope does 
" it in commentary.vim, very slightly 
" ammended for our (lesser) purpose!
	function! s:comments() abort
		return split(get(b:, 'commentary_format', 
						\substitute(
							\substitute(
								\substitute(
								\ &commentstring, '^$', '%s', ''), 
						\'\S\zs%s',' %s', ''),
					\'%s\ze\S', '%s ', '')), '%s', 1)
	endfunction

" Block Comment Style
	function! s:block(l,r) abort
		iab <expr> desc a:l . 
			\   "<cr>File:       " . filename 
			\ . "<cr>Author:     " . author
			\	. "<cr>Tag Added:  " . curtime
			\ . "<cr>Desciption:DESCRIPTION<cr><esc>0i" . a:r 
			\ . "<esc>/DESCRIPTION<cr>cw"
	endfunction

" Single Line Comment Style
	function! s:line(l) abort
		iab <expr> desc a:l." File:       " . filename 
				\ . "<cr>".a:l." Author:     " . author
				\ . "<cr>".a:l." Tag Added:  " . curtime
				\ . "<cr>".a:l." Desciption:"
	endfunction

	let [l,r] = s:comments()
	if len(r) != 0 
		call s:block(l,r)
	else 
		call s:line(l)
	endif

