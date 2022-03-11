"  File:       desc.vim
"  Author:     Julian Orchard <hello@julianorchard.co.uk>
"  Tag Added:  2022-02-15
"  Desciption: Add a short comment block to files (this!)

	if exists("g:loaded_desc") || v:version < 700
		finish
	endif
	let g:loaded_desc = 1

"  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+- 
" SETIAB
	function! s:SetIAB(l, r, keyword, signature, datestr) abort 
		let [l,r] = [a:l,a:r]
		let keyword = a:keyword
		let signature = a:signature
		let datestr = a:datestr
"	echo l . " and " . r . " and " . keyword . " and " . signature . " and " . datestr
		if len(r) != 0
			" Right and Left Char Comments
			if signature != ""
				" With Signature
				exec 'autocmd InsertEnter * iab' keyword . " " l  
						\ . "<cr> File:       " . expand('%:t')
						\ . "<cr>Author:     " . signature
						\ . "<cr>Tag Added:  " . datestr
						\ . "<cr>Desciption:DESCRIPTION<cr><esc>0i" . r 
						\ . "<esc>?DESCRIPTION<cr>cw"
			else 
				" Without Signature
				exec 'autocmd InsertEnter * iab' keyword . " " l  
						\ . "<cr> File:       " . expand('%:t')
						\ . "<cr>Tag Added:  " . datestr
						\ . "<cr>Desciption:DESCRIPTION<cr><esc>0i" . r 
						\ . "<esc>?DESCRIPTION<cr>cw"
			endif 
		else 
			" Single Line Comments
			if signature != ""
				" With Signature
				exec 'autocmd InsertEnter * iab' keyword . " " l 
												\." File:       " . expand('%:t')
						\ . "<cr>".l." Author:     " . signature
						\ . "<cr>".l." Tag Added:  " . datestr
						\ . "<cr>".l." Desciption:"
			else
				" Without Signature
				exec 'autocmd InsertEnter * iab' keyword . " " l 
												\." File:       " . expand('%:t')
						\ . "<cr>".l." Tag Added:  " . datestr
						\ . "<cr>".l." Desciption:"
			endif 
		endif 
	endfunction 

"  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+- 
" MAIN
	function! s:Main() abort
	" TESTING
	 echo &commentstring

	" GET COMMENT CHARS
		" Method changed from vim-commentary
		" https://github.com/tpope/vim-commentary
			let [l,r] = split(get(b:, 'commentary_format', 
						\substitute(&commentstring, '^$', '%s', '')), '%s', 1)

	" GET DATE STRING
		" Check if desc_dateformat, otherwise use Default (below)
			if exists('g:desc_dateformat')
				let datestr = strftime(get(g:, 'desc_dateformat'))
			else
			" Default = YYYY-mm-dd
				let datestr = strftime("%Y-%m-%d")
			endif

	" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~--~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
		" IF LIST (Type 3)
			if type(g:desc_author) == 3
				for i in g:desc_author
				" Get Keyword and Signature
					let keyword = get(i, 0, "NONE") 
					let signature = get(i, 1, "NONE")
				" Call Set iabbrev Function
					call s:SetIAB(l, r, keyword, signature, datestr)
				endfor

	" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~--~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
		" IF STRING (Type 1)
			elseif exists("g:desc_author") && type(g:desc_author) == 1
				let keyword = "desc"
				let signature = get(g:, "desc_author")
			" Call Set iabbrev Function
				call s:SetIAB(l, r, keyword, signature, datestr)

	" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~--~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
		" DEFAULT, no String or List Defined
			else 
					let signature = ""
					call s:SetIAB(l, r, keyword, signature, datestr)
			endif 

	endfunction


"  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+- 
" CALL MAIN ON AUTOCMD
	augroup DESCMAIN
		autocmd!
"	autocmd FileType,BufEnter,BufRead * echo expand('%:t')
		"BufReadPre  FileType,BufReadPre,FileReadPre
		autocmd! VimEnter,InsertEnter * call s:Main()
	augroup END
	
