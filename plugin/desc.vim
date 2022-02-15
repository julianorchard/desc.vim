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
	function HashLine()
		iab <expr> desc "" .
			\       "# File:       " . filename 
			\ . "<cr># Author:     " . author
			\	. "<cr># Tag Added:  " . curtime
			\ . "<cr># Desciption:"
	endfunction
	function CSSBlock()
		iab <expr> desc "/*" . 
			\   "<cr>File:       " . filename 
			\ . "<cr>Author:     " . author
			\	. "<cr>Tag Added:  " . curtime
			\ . "<cr>Desciption:DESCRIPTION<cr><esc>0i*/"
			\ . "<esc>/DESCRIPTION<cr>cw"
	endfunction
	function VIMLine() 
		iab <expr> desc "" .
			\       "\" File:       " . filename 
			\ . "<cr>\" Author:     " . author
			\	. "<cr>\" Tag Added:  " . curtime
			\ . "<cr>\" Desciption:"
	endfunction
	function LispLine()
		iab <expr> desc "" .
			\       "\; File:       " . filename 
			\ . "<cr>\; Author:     " . author
			\	. "<cr>\; Tag Added:  " . curtime
			\ . "<cr>\; Desciption:"
	endfunction
	function VBLine()
		iab <expr> desc "" .
			\       "\' File:       " . filename 
			\ . "<cr>\' Author:     " . author
			\	. "<cr>\' Tag Added:  " . curtime
			\ . "<cr>\' Desciption:"
	endfunction
	function LUALine()
		iab <expr> desc "" .
			\       "-- File:       " . filename 
			\ . "<cr>-- Author:     " . author
			\	. "<cr>-- Tag Added:  " . curtime
			\ . "<cr>-- Desciption:"
	endfunction
	function DOSLine()
		iab <expr> desc "" .
			\       ":: File:       " . filename 
			\ . "<cr>:: Author:     " . author
			\	. "<cr>:: Tag Added:  " . curtime
			\ . "<cr>:: Desciption:"
	endfunction


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
			call HashLine()

	" " These Style Comments
		elseif (&ft=='vim')
			call VIMLine()

	" ; These Style Comments
		elseif (&ft=='autohotkey' || &ft=='asm' || &ft=='lisp' || &ft=='clojure')
			call LispLine()

	" ' These Style Comments
		elseif (&ft=='vb')
			call VBLine()

	" -- These Style Comments
		elseif (&ft=='haskell' || &ft=='ada' || &ft=='eiffel' || &ft=='euphoria3' || &ft=='sql' || &ft=='applescript' || &ft=='lua')
			call LuaLine()

	" :: These Style Comments
		elseif (&ft=='dosbatch')
			call DOSLine()

" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
" DEFAULT COMMENT (FROM FILE)

	endif

" -~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-
