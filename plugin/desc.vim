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

" Wed 9-Mar-22 03:15 PM ~ JO : 
"   Needs tidying up, but works for now
" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
" Write Single Line Comment Style
	function! s:writeiab(l,r) abort
	" Redefine Left Comment Char
		let [l,r] = [a:l,a:r]
		if exists('g:desc_dateformat')
			let datestr = strftime(get(g:, 'desc_dateformat'))
		else
			" Default YYYY-mm-dd
			let datestr = strftime("%Y-%m-%d")
		endif
		" 3 = List, 1 = Str
		if type(g:desc_author) == 3
			for i in g:desc_author
			" Get Keyword and Signature
				let keyword = get(i, 0, "NONE") 
				let signature = get(i, 1, "NONE")
				if len(r) != 0
					" Right and Left Char Comments
					exec 'autocmd FileType * iab' keyword . " " l \ 
								. "<cr> File:       " . expand('%:t')
							\ . "<cr> Tag Added:  " . datestr
							\ . "<cr> Author:     " . signature
							\ . "<cr> Desciption:DESCRIPTION<cr><esc>0i" . r 
							\ . "<esc>/DESCRIPTION<cr>cw"
				else 
					" Single Line Comments
					exec 'autocmd FileType * iab' keyword . " " l 
												\." File:       " . expand('%:t')
							\ . "<cr>".l." Tag Added:  " . datestr
							\ . "<cr>".l." Author:     " . signature
							\ . "<cr>".l." Desciption:"
				endif 
			endfor
		elseif exists("g:desc_author") && type(g:desc_author) == 1
		" If Str
			let author = get(g:, "desc_author")
			if len(r) != 0
				" Right and Left Char Comments
				exec 'autocmd FileType * iab' "desc " l \ 
							. "<cr> File:       " . expand('%:t')
						\ . "<cr> Tag Added:  " . datestr
						\ . "<cr> Author:     " . author
						\ . "<cr> Desciption:DESCRIPTION<cr><esc>0i" . r 
						\ . "<esc>/DESCRIPTION<cr>cw"
			else 
				" Single Line Comments
				exec 'autocmd FileType * iab' "desc " l 
 											\." File:       " . expand('%:t')
						\ . "<cr>".l." Tag Added:  " . datestr
						\ . "<cr>".l." Author:     " . author
						\ . "<cr>".l." Desciption:"
			endif 
		else 
			if len(r) != 0
				" Right and Left Char Comments
				exec 'autocmd FileType * iab' "desc " l \ 
							. "<cr> File:       " . expand('%:t')
						\ . "<cr> Tag Added:  " . datestr
						\ . "<cr> Desciption:DESCRIPTION<cr><esc>0i" . r 
						\ . "<esc>/DESCRIPTION<cr>cw"
			else 
				" Single Line Comments
				exec 'autocmd FileType * iab' "desc " l 
 											\." File:       " . expand('%:t')
						\ . "<cr>".l." Tag Added:  " . datestr
						\ . "<cr>".l." Desciption:"
			endif 
		endif 
	endfunction
" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

" Author from a config file, eventually
" Update curtime to override with a BufSave?

" Get Comment Char, Call Accordingly
	let [l,r] = s:comments()
	call s:writeiab(l,r)
