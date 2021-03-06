if !exists("g:os")
    if has("win64") || has("win32") || has("win16")
        let g:os = "Windows"
    else
        let g:os = substitute(system('uname'), '\n', '', '')
    endif
endif

"Basic settings {{{
"cd %:h

let mapleader = "m"
let maplocalleader = "8"

filetype plugin indent on
syntax on
set mouse=a
set number
set autoindent expandtab tabstop=2 shiftwidth=2
set showmode
set smartcase
set completeopt=menuone,menu,longest
set ignorecase smartcase
set clipboard=unnamedplus
"show special characters
set listchars=eol:$,space:_,tab:\\t,trail:~,extends:>,precedes:<,nbsp:~
set nolist
set matchpairs+=<:>
"saving and loading folds from filenames
"autocmd BufWinLeave * mkview
"autocmd BufWinEnter * silent loadview
"completion in filenames
if has("wildmenu")
  set wildignore+=*.a,*.o
  set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
  set wildignore+=.DS_Store,.git,.hg,.svn
  set wildignore+=*~,*.swp,*.tmp
  set wildmenu
  set wildmode=longest,list
endif
"}}}
"Plugins {{{
	"Automatic installation off vimplug
	let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
	if empty(glob(data_dir . '/autoload/plug.vim'))
		silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	endif

	call plug#begin('~/.vim/plugged')
	"General
	if filereadable('./dotfiles/plugin.vim')
		source ./dotfiles/plugin.vim
	endif
	call plug#end()

	"Color theme
	"set background=dark
	"colorscheme solarized

"}}}
"Telescope {{{
	nnoremap <leader>ff <cmd>Telescope find_files<cr>
	nnoremap <leader>fg <cmd>Telescope live_grep<cr>
	nnoremap <leader>fb <cmd>Telescope buffers<cr>
	nnoremap <leader>fh <cmd>Telescope help_tags<cr>
"}}}
"Templates {{{
	" TextEdit might fail if hidden is not set.
	let g:tmpl_search_paths = ['~/dotfiles/templates']
"}}}
"Coc {{{
"	" TextEdit might fail if hidden is not set.
"	set hidden
"
"	" Some servers have issues with backup files, see #649.
"	set nobackup
"	set nowritebackup
"
"	" Give more space for displaying messages.
"	set cmdheight=2
"
"	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"	" delays and poor user experience.
"	set updatetime=300
"
"	" Don't pass messages to |ins-completion-menu|.
"	set shortmess+=c
"
"	" Always show the signcolumn, otherwise it would shift the text each time
"	" diagnostics appear/become resolved.
"	if has("patch-8.1.1564")
"	  " Recently vim can merge signcolumn and number column into one
"	  set signcolumn=number
"	else
"	  set signcolumn=yes
"	endif
"
"	" Use tab for trigger completion with characters ahead and navigate.
"	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"	" other plugin before putting this into your config.
"	"inoremap <silent><expr> <TAB>
"		  "\ pumvisible() ? "\<C-n>" :
"		  "\ <SID>check_back_space() ? "\<TAB>" :
"		  "\ coc#refresh()
"	"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"	function! s:check_back_space() abort
"	  let col = col('.') - 1
"	  return !col || getline('.')[col - 1]  =~# '\s'
"	endfunction
"
"	" Use <c-space> to trigger completion.
"	if has('nvim')
"	  inoremap <silent><expr> <c-space> coc#refresh()
"	else
"	  inoremap <silent><expr> <c-@> coc#refresh()
"	endif
"
"	" Make <CR> auto-select the first completion item and notify coc.nvim to
"	" format on enter, <cr> could be remapped by other vim plugin
"	inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"								  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
"	" Use `[g` and `]g` to navigate diagnostics
"	" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"	nmap <silent> [g <Plug>(coc-diagnostic-prev)
"	nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"	" GoTo code navigation.
"	nmap <silent> gd <Plug>(coc-definition)
"	nmap <silent> gy <Plug>(coc-type-definition)
"	nmap <silent> gi <Plug>(coc-implementation)
"	nmap <silent> gr <Plug>(coc-references)
"
"	" Use K to show documentation in preview window.
"	nnoremap <silent> K :call <SID>show_documentation()<CR>
"
"	function! s:show_documentation()
"	  if (index(['vim','help'], &filetype) >= 0)
"		execute 'h '.expand('<cword>')
"	  elseif (coc#rpc#ready())
"		call CocActionAsync('doHover')
"	  else
"		execute '!' . &keywordprg . " " . expand('<cword>')
"	  endif
"	endfunction
"
"	" Highlight the symbol and its references when holding the cursor.
"	autocmd CursorHold * silent call CocActionAsync('highlight')
"
"	" Symbol renaming.
"	nmap <leader>rn <Plug>(coc-rename)
"
"	" Formatting selected code.
"	xmap <leader>f  <Plug>(coc-format-selected)
"	nmap <leader>f  <Plug>(coc-format-selected)
"
"	augroup mygroup
"	  autocmd!
"	  " Setup formatexpr specified filetype(s).
"	  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"	  " Update signature help on jump placeholder.
"	  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"	augroup end
"
"	" Applying codeAction to the selected region.
"	" Example: `<leader>aap` for current paragraph
"	xmap <leader>a  <Plug>(coc-codeaction-selected)
"	nmap <leader>a  <Plug>(coc-codeaction-selected)
"
"	" Remap keys for applying codeAction to the current buffer.
"	nmap <leader>ac  <Plug>(coc-codeaction)
"	" Apply AutoFix to problem on the current line.
"	nmap <leader>qf  <Plug>(coc-fix-current)
"
"	" Map function and class text objects
"	" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"	xmap if <Plug>(coc-funcobj-i)
"	omap if <Plug>(coc-funcobj-i)
"	xmap af <Plug>(coc-funcobj-a)
"	omap af <Plug>(coc-funcobj-a)
"	xmap ic <Plug>(coc-classobj-i)
"	omap ic <Plug>(coc-classobj-i)
"	xmap ac <Plug>(coc-classobj-a)
"	omap ac <Plug>(coc-classobj-a)
"
"	" Remap <C-f> and <C-b> for scroll float windows/popups.
"	" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
"	nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"	nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"	inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"	inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"
"	" NeoVim-only mapping for visual mode scroll
"	" Useful on signatureHelp after jump placeholder of snippet expansion
"	if has('nvim')
"	  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
"	  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
"	endif
"
"	" Use CTRL-S for selections ranges.
"	" Requires 'textDocument/selectionRange' support of language server.
"	nmap <silent> <C-s> <Plug>(coc-range-select)
"	xmap <silent> <C-s> <Plug>(coc-range-select)
"
"	" Add `:Format` command to format current buffer.
"	command! -nargs=0 Format :call CocAction('format')
"
"	" Add `:Fold` command to fold current buffer.
"	command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
"	" Add `:OR` command for organize imports of the current buffer.
"	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
"	" Add (Neo)Vim's native statusline support.
"	" NOTE: Please see `:h coc-status` for integrations with external plugins that
"	" provide custom statusline: lightline.vim, vim-airline.
"	" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"	" Mappings for CoCList
"	" Show all diagnostics.
"	nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"	" Manage extensions.
"	nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"	" Show commands.
"	nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"	" Find symbol of current document.
"	nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"	" Search workspace symbols.
"	nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"	" Do default action for next item.
"	nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"	" Do default action for previous item.
"	nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"	" Resume latest coc list.
"	nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
""}}}
"Basic mappings and abbreviations {{{
	"Quit terminal insert mode
	tnoremap <esc> <c-\><c-n>
	"Edit and quit .vimrc {{{
		nnoremap <leader>ev :split $MYVIMRC<cr>
		nnoremap <leader>qv :wq<cr>:source $MYVIMRC<cr>
	"}}}
	"Navigation between panes {{{
	nnoremap <c-j> <c-w>j
	nnoremap <c-k> <c-w>k
	nnoremap <c-h> <c-w>h
	nnoremap <c-l> <c-w>l
	nnoremap <c-\><c-n> <c-w>n
	"}}}
"}}}
"LaTeX {{{
	"Global settings {{{
		let g:tex_flavor = "latex"
		"Ajouter l'underscore et le : pour Expl3
		let g:tex_expl3 = 1
		let g:tex = 0
		"Automatic deletion of auxiliary files
		let g:tex_rm = 0
		"Let .cls files have the same treatment than latex
		augroup cls
			autocmd!
			autocmd BufReadPost,BufNewFile *.cls setlocal filetype=tex
		augroup end
	"}}}
	"Functions {{{
		"Delete auxilliary files {{{
			function! Delete()
				let root = expand("%:r")
				execute "!rm -f \"".root.".aux\" \"".root.".log\" \"".root.".dvi\" \"".root.".ps\" \"".root.".out\" \"".root.".snm\" \"".root.".nav\" \"".root.".toc\"" 
				execute "redraw!"
			endfunction
		"}}}
		"Compile document. First executes xelatex, then removes auxilliary files if g:tex_rm is true {{{
		"-shell-escape is for package minted
			function! Compile()
				execute "w | !xelatex -shell-escape \"%\""
				if g:tex_rm
					call Delete()
				endif
			endfunction

			function! CompileBib()
				let root = expand("%:r")
				execute "w | silent !xelatex -shell-escape \"%\""
				execute "silent !biber \"".root."\""
				execute "!xelatex -shell-escape \"%\""
				if g:tex_rm
					call Delete()
				endif
			endfunction
		"}}}
		"Align caracters & {{{
			function! s:align()
				let p = '^\s*&\s.*\s&\s*$'
				if exists(':Tabularize') && getline('.')  = ~# '^\s*&' && (getline(line('.')-1)  = ~# p || getline(line('.')+1)  = ~# p)
					let column = strlen(substitute(getline('.')[0:col('.')],'[^&]','','g'))
					let position = strlen(matchstr(getline('.')[0:col('.')],'.*&\s*\zs.*'))
					Tabularize/&/l1
					normal! 0
					call search(repeat('[^&]*&',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
				endif
			endfunction
		"}}}
	"}}}
	"LaTeX Mappings {{{
		augroup latexmaps
			autocmd!
			"autocmd filetype tex exec "source $HOME/.vim/after/syntax/expl3.vim"
			autocmd filetype tex inoremap <silent> &  &<Esc>:call <SID>align()<CR>a
			"Comments {{{
				"autocmd filetype tex nnoremap <buffer> <localleader>c :call Comment("%",1)<cr>
				"autocmd filetype tex vnoremap <buffer> <localleader>c :<C-U>call VComment("%",1)<cr>
				"autocmd filetype tex nnoremap <buffer> <localleader>t :call Comment("%",0)<cr>
				"autocmd filetype tex vnoremap <buffer> <localleader>t :<C-U>call VComment("%",0)<cr>
			"}}}
			autocmd filetype tex nnoremap <buffer> <localleader>q :call Compile()<cr>
			"Switch between autodeletion of files or not after compilation
			autocmd filetype tex nnoremap <buffer> <localleader>dm :silent let tex_rm = !tex_rm<cr>
			"Delete auxilliary files
			autocmd filetype tex nnoremap <buffer> <localleader>dd :call Delete()<cr>
			autocmd filetype tex nnoremap <buffer> <localleader>dd :call Delete()<cr>
			"Edit custom class and package {{{
				autocmd filetype tex nnoremap <buffer> <localleader>ev :split ~/bin/latex/cours_math.cls<cr>
				autocmd BufReadPost,BufReadPre cours_math.cls nnoremap <localleader><tab> :e ~/bin/latex/test.cls<cr>
				autocmd BufReadPost,BufReadPre test.cls nnoremap <localleader><tab> :e ~/bin/latex/perso.sty<cr>
				autocmd BufReadPost,BufReadPre perso.sty nnoremap <localleader><tab> :e ~/bin/latex/progression.cls<cr>
				autocmd BufReadPost,BufReadPre progression.cls nnoremap <localleader><tab> :e ~/bin/latex/competence.cls<cr>
				autocmd BufReadPost,BufReadPre competence.cls nnoremap <localleader><tab> :e ~/bin/latex/cours_math.cls<cr>
				autocmd filetype tex nnoremap <buffer> <localleader>qv :wq<cr>
			"}}}
			"Insert $, bl and overrightarrow {{{
				"Insert inside $
				autocmd filetype tex nnoremap <buffer> <localleader>id lbi$<esc>ea$<esc>
				"Insert around $
				autocmd filetype tex nnoremap <buffer> <localleader>ad lBi$<esc>Ea$<esc>
				"Insert visual mode $
				autocmd filetype tex vnoremap <buffer> <localleader>d <esc>`<i$<esc>`>la$<esc>
				"Insert inside bl
				autocmd filetype tex onoremap <buffer> <localleader>ib lbi\bl{<esc>ea}<esc>
				"Insert around bl
				autocmd filetype tex onoremap <buffer> <localleader>ab lBi\bl{<esc>Ea}<esc>
				"Insert visual mode bl
				autocmd filetype tex vnoremap <buffer> <localleader>b <esc>`<i\bl{<esc>`>4la}<esc>
				"Insert inside overrightarrow
				autocmd filetype tex onoremap <buffer> <localleader>iv lbi\overrightarrow{<esc>ea}<esc>
				"Insert around overrightarrow
				autocmd filetype tex onoremap <buffer> <localleader>iv lBi\overrightarrow{<esc>Ea}<esc>
			"}}}
			"Send pdf file to website
			nnoremap <localleader>ss :call SendWeb(expand("%:p"))
		augroup end
	"}}}
	"Abbreviations {{{
			function! Eatchar(pat)
				let l:c = nr2char(getchar(0))       
				return (l:c  = ~ a:pat) ? '' : c      
			endfunction
			function! s:Expr(default,repl)
				if getline('.')[col('.')-2] = '\'
					return "\<bs>".a:repl
				else
					return a:default
				endif
			endfunction
			"\bl{}
			autocmd filetype tex iabbrev <buffer> bbl \bl{}<left><C-R> = Eatchar('\s')<CR>
			"\begin{}
			autocmd filetype tex iabbrev <buffer> bbegin \begin{}<left><C-R> = Eatchar('\s')<CR>
			"	autocmd filetype tex iabbrev <buffer> begin <c-r> = <sid>Expr('begin','NOPENOPENOPE')<cr>
			"\end{}
			autocmd filetype tex iabbrev <buffer> eend \end{}<left><C-R> = Eatchar('\s')<CR>
			"	autocmd filetype tex iabbrev <buffer> end <c-r> = <sid>Expr('end','NOPENOPENOPE')<cr>
			autocmd filetype tex iabbrev <buffer> ppmatrix \begin{pmatrix}<++>\end{pmatrix}
		"}}}
		"VimLaTeX {{{
			set grepprg=grep\ -H\ $*
			"Vraies guillemets
			let g:Tex_SmartQuoteOpen = "\\og "
			let g:Tex_SmartQuoteClose = "\\fg"
			"Environnements
			let g:Tex_PromptedEnvironments = 'tikzpicture,\[,$$'
			let g:Tex_Env_lemma = "\\begin{lemma}\<cr><++>\<cr>\\end{lemma}"
			let g:Tex_Env_tikzpicture = "\\begin{tikzpicture}\<cr><++>\<cr>\\end{tikzpicture}"
			let g:Tex_Env_proof = "\\begin{proof}\<cr><++>\<cr>\\end{proof}"
			let g:Tex_Env_tabu = "\\begin{tabu}to <++>{|*{<++>}{X[c]|}}\\hline\<cr><++>\<cr>\\end{tabu}"
			let g:Tex_ItemStyle_general = "\\item "
			let g:Tex_ItemStyle_calcul = "\\item "
			let g:Tex_ItemStyle_algo = "\\item "
			let g:Tex_ItemStyle_logique = "\\item "
			let g:Tex_ItemStyle_prob = "\\item "
			imap <c-b> <Plug>Tex_MathBF
			imap <c-t> <Plug>Tex_InsertItemOnThisLine
			imap <c-g> <Plug>IMAP_JumpForward
			nmap <c-g> <Plug>IMAP_JumpForward
			augroup vimsuite
				autocmd!
				"Target in compilation
				autocmd filetype tex TTarget pdf
			augroup end
		"}}}
"}}}
"Other file types {{{
	"Notes {{{
		augroup note
			autocmd!
			autocmd BufReadPre Notes setlocal foldmethod=indent
		augroup end
	"}}}
	"Vim {{{
		augroup vim
			autocmd!
			autocmd filetype vim setlocal foldmethod=marker
			autocmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc execute("normal! mn")|source $MYVIMRC | if has('gui_running')| source $MYGVIMRC |endif|execute("normal! `n")
			"Comments
			"	autocmd filetype vim nnoremap <buffer> <localleader>c :call Comment('"',1)<cr>
			"	autocmd filetype vim vnoremap <buffer> <localleader>c :<C-U>call VComment('"',1) <cr>
		augroup end
	"}}}
	"}}}
	"Bash{{{
	augroup bash
		autocmd!
		"Comments
		"	autocmd filetype sh nnoremap <buffer> <localleader>c :call Comment("#",1)<cr>
		"	autocmd filetype sh vnoremap <buffer> <localleader>c :<C-U>call VComment("#",1) <cr>
		augroup end
	"}}}
	"Ocaml{{{
	augroup ocaml
		autocmd!
		autocmd Bufread,BufNewfile *.ml,*.mli compiler ocaml
		autocmd Bufread,BufNewfile *.ml,*.mli nnoremap <buffer> <localleader>a :w<cr>:execute "!ledit ocaml -init ".expand("%")<cr>
	augroup end
	"}}}
	"C {{{
	augroup c
		autocmd!
		autocmd BufRead,BufNewFile *.h set filetype=c
		autocmd filetype cpp setlocal nosmarttab tabstop=4 softtabstop=0 shiftwidth=4 tw=80
		autocmd filetype c nnoremap <localleader>q :!gcc % && ./a.out<cr>
		autocmd BufNewFile,BufRead *.tpp set filetype=cpp
	augroup end
	"Haskell{{{
	augroup haskell
		autocmd!
		set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
		set wildmenu
		autocmd filetype yacc setlocal filetype=haskell
		autocmd filetype haskell setlocal smarttab softtabstop=2 shiftwidth=2 expandtab tw=80
		autocmd filetype cabal setlocal smarttab softtabstop=2 shiftwidth=2 expandtab tw=80
		autocmd filetype haskell nnoremap <buffer> <localleader>a :w<cr>:execute "!ghci ".expand("%")<cr>
		autocmd filetype haskell nnoremap <buffer> <localleader>z :w<cr>:execute "silent !ghc -Wall ".expand("%.t")<cr>:execute "!./".expand("%:r")<cr>
		"stylish-haskell {{{
		"autocmd filetype haskell setlocal formatprg = stylish-haskell
		"autocmd BufWrite *.hs :Autoformat
		"autocmd FileType haskell let b:autoformat_autoindent = 0
		"}}}
		"vim-hdevtools {{{
		autocmd filetype haskell nnoremap <buffer> <f2> :HdevtoolsType<cr>
		autocmd filetype haskell nnoremap <buffer> <f3> :HdevtoolsInfo<cr>
		autocmd filetype haskell nnoremap <buffer> <f4> :HdevtoolsClear<cr>
		"}}}
			"autocmd filetype haskell nnoremap <buffer> <localleader>g :w<cr>:execute "stack ghci mathinal:lib --no-load --work-dir .stack-work-devel"<cr>
			"nnoremap <localleader>g :w<cr>:term "stack ghci mathinal:lib --no-load --work-dir .stack-work-devel"<cr>
		"Hamlet{{{
			autocmd BufReadPost *.hamlet setlocal expandtab
		"}}}
		"Html{{{
			autocmd BufReadPost *.htm *.html setlocal expandtab tabstop = 2
		"}}}
	augroup end
	"}}}
	"Javascript{{{
	augroup javascript
		autocmd filetype javascript,typescript nnoremap <buffer> <localleader>a :w<cr>:execute "!nodejs -use-strict ".expand("%.t")<cr>
		autocmd filetype javascript,typescript setlocal smarttab softtabstop=2 shiftwidth=2 expandtab tw=80
	augroup end
	"}}}
"}}}
	"Haskell{{{
	augroup haskell
		autocmd!
		set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
		set wildmenu
		autocmd filetype yacc setlocal filetype=haskell
		autocmd filetype haskell setlocal smarttab softtabstop=2 shiftwidth=2 expandtab tw=80
		autocmd filetype cabal setlocal smarttab softtabstop=2 shiftwidth=2 expandtab tw=80
		autocmd filetype haskell nnoremap <buffer> <localleader>a :w<cr>:execute "!ghci ".expand("%")<cr>
		autocmd filetype haskell nnoremap <buffer> <localleader>z :w<cr>:execute "silent !ghc -Wall ".expand("%.t")<cr>:execute "!./".expand("%:r")<cr>
		"stylish-haskell {{{
		"autocmd filetype haskell setlocal formatprg = stylish-haskell
		"autocmd BufWrite *.hs :Autoformat
		"autocmd FileType haskell let b:autoformat_autoindent = 0
		"}}}
		"vim-hdevtools {{{
		autocmd filetype haskell nnoremap <buffer> <f2> :HdevtoolsType<cr>
		autocmd filetype haskell nnoremap <buffer> <f3> :HdevtoolsInfo<cr>
		autocmd filetype haskell nnoremap <buffer> <f4> :HdevtoolsClear<cr>
		"}}}
			"autocmd filetype haskell nnoremap <buffer> <localleader>g :w<cr>:execute "stack ghci mathinal:lib --no-load --work-dir .stack-work-devel"<cr>
			"nnoremap <localleader>g :w<cr>:term "stack ghci mathinal:lib --no-load --work-dir .stack-work-devel"<cr>
		"Hamlet{{{
			autocmd BufReadPost *.hamlet setlocal expandtab
		"}}}
		"Html{{{
			autocmd BufReadPost *.htm *.html setlocal expandtab tabstop = 2
		"}}}
	augroup end
	"}}}
	"Javascript{{{
	augroup javascript
		autocmd filetype javascript nnoremap <buffer> <localleader>a :w<cr>:execute "!nodejs -use-strict ".expand("%.t")<cr>
	augroup end
	"}}}
	"Asm{{{
  augroup asm
    set autoindent noexpandtab tabstop=4 shiftwidth=4
  augroup end
  "}}}
"}}}
	"Hledger{{{
	"augroup hledger
		"autocmd!
		"autocmd Bufread,BufNewfile *.journal set nosmarttab autoindent expandtab tabstop=2 shiftwidth=2
	"augroup end
	"}}}
