"  File:       desc.vim
"  Author:     Julian Orchard [hello@julianorchard.co.uk]
"  Tag Added:  2022-02-15
"  Desciption: Add a short comment block to files (this!)

if exists("g:loaded_desc") || v:version < 700
	finish
endif
let g:loaded_desc = 1

	function! s:Iab() abort 
		if len(r) != 0
			" Right and Left Char Comments
			exec 'autocmd FileType * iab' keyword . " " l  
					\ . "<cr> File:       " . expand('%:t')
					\ . "<cr>Tag Added:  " . datestr
					\ . "<cr>Author:     " . signature
					\ . "<cr>Desciption:DESCRIPTION<cr><esc>0i" . r 
					\ . "<esc>/DESCRIPTION<cr>cw"
		else 
			" Single Line Comments
			exec 'autocmd FileType * iab' keyword . " " l 
											\." File:       " . expand('%:t')
					\ . "<cr>".l." Tag Added:  " . datestr
					\ . "<cr>".l." Author:     " . signature
					\ . "<cr>".l." Desciption:"
		endif 
	endfunction 

" Write Single Line Comment Style
	function! s:Main() abort
		echo "Changed Comment Type, For File " . expand('%:t')

	" Method changed slightly from vim-commentary
	" https://github.com/tpope/vim-commentary
		let [l,r] = split(get(b:, 'commentary_format', 
			\substitute(&commentstring, '^$', '%s', '')), '%s', 1)

	" Check if desc_dateformat, otherwise use Default (below)
		if exists('g:desc_dateformat')
			let datestr = strftime(get(g:, 'desc_dateformat'))
		else
		" Default = YYYY-mm-dd
			let datestr = strftime("%Y-%m-%d")
		endif
		echo datestr

		" 3 = List, 1 = Str
		if type(g:desc_author) == 3
			for i in g:desc_author
			" Get Keyword and Signature
				let keyword = get(i, 0, "NONE") 
				let signature = get(i, 1, "NONE")
				if len(r) != 0

					exec 'autocmd FileType * una' keyword

					echo "Array, Left and Right Char"

					" Right and Left Char Comments
					exec 'autocmd FileType * iab' keyword . " " l  
					    \ . "<cr> File:       " . expand('%:t')
							\ . "<cr>Tag Added:  " . datestr
							\ . "<cr>Author:     " . signature
							\ . "<cr>Desciption:DESCRIPTION<cr><esc>0i" . r 
							\ . "<esc>/DESCRIPTION<cr>cw"
				else 

				exec 'autocmd FileType * una' keyword
				echo "Array, Left Only"

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
				una desc

				" Right and Left Char Comments

				echo "String, Left and Right Char"

				exec 'autocmd FileType * iab' "desc " l 
				    \ . "<cr> File:       " . expand('%:t')
						\  . "<cr>Tag Added:  " . datestr
						\  . "<cr>Author:     " . author
						\  . "<cr>Desciption:DESCRIPTION<cr><esc>0i" . r 
						\ . "<esc>/DESCRIPTION<cr>cw"
			else 

						una desc
				echo "String, Left Only"

				" Single Line Comments
				exec 'autocmd FileType * iab' "desc " l 
 				               \." File:       " . expand('%:t')
						\ . "<cr>".l." Tag Added:  " . datestr
						\ . "<cr>".l." Author:     " . author
						\ . "<cr>".l." Desciption:"
			endif 
		else 

			echo "Shouldn't be this one..."
			if len(r) != 0
				una desc
				" Right and Left Char Comments
				exec 'autocmd FileType * iab' "desc " l \ 
							. "<cr> File:       " . expand('%:t')
						\ . "<cr>Tag Added:  " . datestr
						\ . "<cr>Desciption:DESCRIPTION<cr><esc>0i" . r 
						\ . "<esc>/DESCRIPTION<cr>cw"
			else 
				una desc
			" Single Line Comments
				exec 'autocmd FileType * iab' "desc " l 
 											\." File:       " . expand('%:t')
						\ . "<cr>".l." Tag Added:  " . datestr
						\ . "<cr>".l." Desciption:"
			endif 
		endif 
	endfunction

" Call Main Function on AutoCmd 
	augroup DESCMAIN
		autocmd!
"	autocmd FileType,BufEnter,BufRead * echo expand('%:t')
		"BufReadPre  FileType,BufReadPre,FileReadPre
		autocmd BufNew,BufRead * call s:Main()
	augroup END
