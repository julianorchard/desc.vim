"  File:        desc.vim
"  Author:      Julian Orchard <hello@julianorchard.co.uk>
"  Tag Added:   2022-02-15
"  Description: Add a short comment block to files (this!)

if exists("g:loaded_desc") || v:version < 700
	finish
endif
let g:loaded_desc = 1

"  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+- 
" SETIAB
function! s:SetIAB(l, r, keyword, signature, datetime) abort 
	let [l,r] = [a:l,a:r]
	if a:signature != ""
     " Detect if comments are going to be inserted automatically or not
      let fo = &fo
      if stridx(fo,"c") == -1 && stridx(fo,"r") == -1 && stridx(fo,"o") == -1
        let lc = l . "  "
      else
        let lc = ""
      endif

     " With Signature
		if len(r) != 0
			exec 'autocmd VimEnter,InsertEnter * iab' a:keyword . " " l  
					\ . "<cr> File:        " . expand('%:t')
					\ . "<cr>Author:      " . a:signature
					\ . "<cr>Tag Added:   " . a:datetime
					\ . "<cr>Description:DESCRIPTION<cr><esc>0i" . r 
					\ . "<esc>?DESCRIPTION<cr>cw"
			return
		else 
			exec 'autocmd InsertEnter * iab' a:keyword . " " l 
					\ .         "  File:        " . expand('%:t')
          \ . "<cr>".lc."Author:      " . a:signature
					\ . "<cr>".lc."Tag Added:   " . a:datetime
					\ . "<cr>".lc."Description:"
			return
		endif 
	else 
      " Without
			exec 'autocmd VimEnter,InsertEnter * iab' a:keyword . " " l  
					\ . "<cr> File:       " . expand('%:t')
					\ . "<cr>Tag Added:   " . a:datetime
					\ . "<cr>Description:DESCRIPTION<cr><esc>0i" . r 
					\ . "<esc>?DESCRIPTION<cr>cw"
		else
			exec 'autocmd InsertEnter * iab' a:keyword . " " l 
					\ .         "  File:        " . expand('%:t')
					\ . "<cr>".lc."Tag Added:   " . a:datetime
					\ . "<cr>".lc."Description:"
		endif 
	endif 
endfunction 


"  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+- 
" MAIN
function! s:Main(gitdetails) abort

" GET COMMENT CHARS
	" Method changed from vim-commentary
	" https://github.com/tpope/vim-commentary
		let [l,r] = split(get(b:, 'commentary_format', 
					\substitute(&commentstring, '^$', '%s', '')), '%s', 1)

" GET DATE STRING
	" Check if desc_dateformat, otherwise use Default (below)
		if exists('g:desc_dateformat')
			let datetime = strftime(get(g:, 'desc_dateformat'))
		else
		" Default = YYYY-mm-dd
			let datetime = strftime("%Y-%m-%d")
		endif

" GET DESC_AUTHOR 
  " Try / Catch Desc_Author
		try 
			let sign = get(g:, 'desc_author')
		catch
			let sign = a:gitdetails
		endtry

" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~--~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
	" IF LIST (Type 3)
		if type(sign) == type([])
			for i in sign
			" Get Keyword and Signature
				let keyword = get(i, 0, "NONE") 
				let signature = get(i, 1, "NONE")
			" Call Set iabbrev Function
				call s:SetIAB(l, r, keyword, signature, datetime)
			endfor

" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~--~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
	" IF STRING (Type 1)
		elseif type(sign) == 1
			let keyword = "desc"
			let signature = get(g:, "desc_author")
		" Call Set iabbrev Function
			call s:SetIAB(l, r, keyword, signature, datetime)

" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~--~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
	" DEFAULT, no String or List Defined
		else 
			let keyword = "desc"
			let signature = a:gitdetails
			call s:SetIAB(l, r, keyword, signature, datetime)
		endif 

endfunction


"  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+-  -+- 
" CALL MAIN ON AUTOCMD
try 
	let gitdetails = substitute(system('git config --global user.name') . " <" . 
			\system('git config --global user.email') . ">", '\n', '', 'g') 
catch
	let gitdetails = ""
endtry
augroup DESCMAIN
	autocmd!
	autocmd! VimEnter,InsertEnter * call s:Main(gitdetails)
augroup END
