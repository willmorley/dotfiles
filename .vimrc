" Will's vimrc

"=== Vital key mappings === {{{
nnoremap ; :
" }}}

"=== Platform Dependancies === {{{
let s:path = expand('<sfile>:p:h')
let s:config_path = s:path . '/.vim'
if has('macunix') || system('uname') =~? 'Darwin'
    let g:PLATFORM = 'mac'
elseif has('win32unix')
    let g:PLATFORM = 'cygwin'
elseif system('uname') =~? 'Linux'
    let g:PLATFORM = 'linux'
elseif has('win32') || has('win64')
    let g:PLATFORM = 'win'
    let s:config_path = s:path . '/vimfiles'
else
    let g:PLATFORM = 'other'
endif
" }}}

"=== Syntax === {{{
syntax enable		" enable syntax processing

if g:PLATFORM =~ "cygwin"
    colorscheme darkblue
elseif g:PLATFORM =~ "mac"
    colorscheme badwolf

    let s:clang = '/usr/local/Cellar/clang-format/2018-01-11/share/clang/clang-format.py'
    map <C-K> :pyf s:clang<cr> " use clang format
    imap <C-K> <c-o>:pyf s:clang<cr> " TODO:add interdevice capabilities
endif
" }}}

"=== Spaces & tabs === {{{
set tabstop=4 		" makes a tab 4 spaces
set softtabstop=4	" number of spaces in tab when editing
set expandtab		" makes tabs spaces (useful for languages like python)
set modeline
set modelines=1
" }}}

"=== UI Config === {{{
set number	    	" show line numbers
set showcmd	    	" shows the command in bottom bar
"set cursorline		" highlight current line
filetype indent on 	" load filetype-specific indent files
		        	" ie. ~/vim/indent/python.vim (TODO: make this indent folder)
set wildmenu		" visual autocomplete for command menu
set lazyredraw		" redraw only when we need to
set showmatch		" highlight matching [{()}] (this might be enabled by default)
set scrolloff=4     " start scrolling 4 lines before reaching bottom
set linebreak       " break lines at words not chars
set autoindent      " indent based on above line when you add a new line
" }}}

"=== Searching === {{{
set incsearch		" search as characters are entered
set hlsearch		" highlight matches
set ignorecase		" ignore case when searching
set smartcase       " don't ignore case if there is a capital in search
" }}}

"=== Folding === {{{
set foldenable		" enable folding
set foldlevelstart=10	" open most folds by default
set foldmethod=indent	" fold based on indent level (consider setting to =syntax)
nnoremap <tab> za	" toggle open/close folds
" }}}

"=== Movement === {{{
" move vertically by visual line (ignoring wraps)
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" configure backspace key
set backspace=indent,eol,start

nnoremap gV `[v`]	" highlight last inserted text
" }}}

"=== Shortcuts === {{{
let mapleader=" "

nnoremap <leader>h :nohlsearch<CR> 	" remove search highlights
"nnoremap <leader>u :GundoToggle<CR> 	" toggle Gundo (TODO: get gundo.vim plugin)

" edit vimrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" save session
nnoremap <leader>s :mksession<CR> "super save"

" open ag.vim
"nnoremap <leader>a :Ag "(TODO: get ag.vim plugin)

" easily exit insert mode
inoremap jj <esc>
inoremap jk <esc>

" Navigate between buffers
nnoremap <return> :bn<CR>
nnoremap <bs> :bp<CR>
" }}}

"=== Backups === {{{
set backup
set writebackup
" }}}

"=== AutoGroup === {{{
augroup configgroup
	autocmd!
	autocmd BufWritePre *.c,*.cpp,*.cc,*.java,*.sh,*.txt,*.py,*.* :call <SID>StripTrailingWhitespaces()
	autocmd BufEnter Makefile setlocal noexpandtab
	autocmd BufEnter *.sh setlocal tabstop=2
	autocmd BufEnter *.sh setlocal shiftwidth=2
	autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
" }}}

"=== Functions === {{{
" removes trailing whitespace
" called on buffer write
function! <SID>StripTrailingWhitespaces()
	" save last search
	let _s=@/
	" save last cursor position
	let l = line(".")
	let c = col(".")
	" strip whitespace
	%s/\s\+$//e
	" restore cursor & search
	let @/=_s
	call cursor(l, c)
endfunction
" }}}

" vim:foldmethod=marker:foldlevel=0
