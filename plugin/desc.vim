" File:       vimrc
" Author:     Julian Orchard [hello@julianorchard.co.uk]
" Tag Added:  2022-02-10
" Desciption: Main Description Adding Plugin

" Comment Type Sources Mainly From ~
"  https://en.wikipedia.org/wiki/Comparison_of_programming_languages_(syntax)#Comments

	let filename = expand('%:t')
	" GET FROM FILE
	let author  = "Julian Orchard [hello@julianorchard.co.uk]"
	let curtime = strftime("%Y-%m-%d")

	function HTMLBlock()
		iab <expr> desc "<!--" .
			\   "<cr>File:       " . filename 
			\ . "<cr>Author:     " . author
			\	. "<cr>Tag Added:  " . curtime
			\ . "<cr>Desciption: DESCRIPTION<cr>-->"
			\ . "<esc>/DESCRIPTION<cr>cw"
	endfunction
	function CSSBlock()
		iab <expr> desc "/*" . 
			\   "<cr>File:       " . filename 
			\ . "<cr>Author:     " . author
			\	. "<cr>Tag Added:  " . curtime
			\ . "<cr>Desciption:DESCRIPTION<cr><esc>0i*/"
			\ . "<esc>/DESCRIPTION<cr>cw"
	endfunction

" 'Line' Comments
	function! s:LineComment(comment)
		iab <expr> desc a:comment." File:       " . filename 
			   \ . "<cr>".a:comment." Author:     " . author
			   \ . "<cr>".a:comment." Tag Added:  " . curtime
			   \ . "<cr>".a:comment." Desciption:"
	endfunction


function! s:Main()

" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

" Block Comments

	" <!-- -->
		if (&ft=='html' || &ft=='markdown')
			call HTMLBlock()
	"	/* */ 
		elseif (&ft=='css' || &ft=='go' || &ft=='php' || &ft=='c')
			call CSSBlock()

" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

" Line Comments

	" # These Style Comments
		elseif (&ft=='sh' || &ft=='bash' || &ft=='python')
			call s:LineComment("#")
	" " These Style Comments
		elseif (&ft=='vim')
			let comment="\""
			call s:LineComment(comment)
	" ; These Style Comments
		elseif (&ft=='autohotkey' || &ft=='asm' || &ft=='lisp' || &ft=='clojure')
			let comment=";"
			call s:LineComment(comment)
	" ' These Style Comments
		elseif (&ft=='vb')
			let comment="'"
			call s:LineComment(comment)
	" -- These Style Comments
		elseif (&ft=='haskell' || &ft=='ada' || &ft=='eiffel' || &ft=='euphoria3' || &ft=='sql' || &ft=='applescript' || &ft=='lua')
			let comment="--"
			call s:LineComment(comment)
	" :: These Style Comments
		elseif (&ft=='dosbatch')
			let comment="::"
			call s:LineComment(comment)

" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
" DEFAULT COMMENT (FROM FILE, eventually)
		else 
			let comment="~~"
			call s:LineComment(comment)

	endif

" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-

endfunction

autocmd BufNewFile,BufRead * call s:LineComment()
