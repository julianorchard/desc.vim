" File:       vimrc
" Author:     Julian Orchard [hello@julianorchard.co.uk]
" Tag Added:  2022-02-10
" Desciption: Main Description Adding Plugin

	let filename = expand('%:t')
	let author  = "Julian Orchard [hello@julianorchard.co.uk]"
	let curtime = strftime("%Y-%m-%d")

" <!-- These Style Comments -->
	if (&ft=='html' || &ft=='markdown')

			iab <expr> desc "<!--" .
				\   "<cr>File:       " . filename 
				\ . "<cr>Author:     " . author
				\	. "<cr>Tag Added:  " . curtime
				\ . "<cr>Desciption: DESCRIPTION<cr>-->"
				\ . "<esc>/DESCRIPTION<cr>cw"

" # These Style Comments
	elseif (&ft=='sh' || &ft=='bash' || &ft=='python')

			iab <expr> desc "" .
				\       "# File:       " . filename 
				\ . "<cr># Author:     " . author
				\	. "<cr># Tag Added:  " . curtime
				\ . "<cr># Desciption:"
			
"	/* These Style Comments */ 
	elseif (&ft=='css' || &ft=='go' || &ft=='php' || &ft=='c')

			iab <expr> desc "/*" . 
			  \   "<cr>File:       " . filename 
				\ . "<cr>Author:     " . author
				\	. "<cr>Tag Added:  " . curtime
				\ . "<cr>Desciption:DESCRIPTION<cr><esc>0i*/"
				\ . "<esc>/DESCRIPTION<cr>cw"

" " These Style Comments
	elseif (&ft=='vim')

			iab <expr> desc "" .
			  \       "\" File:       " . filename 
				\ . "<cr>\" Author:     " . author
				\	. "<cr>\" Tag Added:  " . curtime
				\ . "<cr>\" Desciption:"

" ; These Style Comments
	elseif (&ft=='autohotkey' || &ft=='asm' || &ft=='lisp' || &ft=='clojure')

			iab <expr> desc "" .
			  \       "\; File:       " . filename 
				\ . "<cr>\; Author:     " . author
				\	. "<cr>\; Tag Added:  " . curtime
				\ . "<cr>\; Desciption:"

" ' These Style Comments
	elseif (&ft=='vb')

			iab <expr> desc "" .
			  \       "\' File:       " . filename 
				\ . "<cr>\' Author:     " . author
				\	. "<cr>\' Tag Added:  " . curtime
				\ . "<cr>\' Desciption:"

" -- These Style Comments
	elseif (&ft=='haskell' || &ft=='ada' || &ft=='eiffel' || &ft=='euphoria3' || &ft=='sql' || &ft=='applescript' || &ft=='lua')

			iab <expr> desc "" .
			  \       "-- File:       " . filename 
				\ . "<cr>-- Author:     " . author
				\	. "<cr>-- Tag Added:  " . curtime
				\ . "<cr>-- Desciption:"

" :: These Style Comments
	elseif (&ft=='dosbatch')

			iab <expr> desc "" .
			  \       ":: File:       " . filename 
				\ . "<cr>:: Author:     " . author
				\	. "<cr>:: Tag Added:  " . curtime
				\ . "<cr>:: Desciption:"

	endif

