""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" .vimrc
"
" Daniel Kudrow (dkudrow@cs.ucsb.edu)
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set this first so that Vim options are available
set nocompatible

" Play nice with tmux
set term=xterm

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Remaps
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Y should act like C, D, etc.	
noremap Y y$

" Treat line wraps like breaks
noremap j gj
noremap k gk

" $ and 0 are hard to reach
noremap <C-h> ^
noremap <C-l> $

" Make navigating tabs easier
noremap te :tabedit
noremap tn :tabnext<CR>
noremap tp :tabprevious<CR>

" Make a spelling hotkey
noremap ,s :call ToggleSpell()<CR>

" Remove trailing whitespace
noremap ,w :%s/ \+$//g

" Search for selected text in visual mode
vnoremap <silent> * :<C-U>
	\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	\gvy/<C-R><C-R>=substitute(
	\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	\gV:call setreg('"', old_reg, old_regtype)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Appearance
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=light  	" "dark" or "light", used for highlight colors
"set colorcolumn=+1		" column(s) to highlight
set cursorline	  		" highlight the screen line of the cursor
set display=lastline  	" list of flags for how to display text
set number	  			" print the line number in front of each line
set scrolloff=2	  		" minimum nr. of lines above and below cursor
set showbreak=+\ 		" ttring to use at the start of wrapped lines
set splitbelow	  		" new window from split is below the current one
set splitright	  		" new window is put right of the current one
set wrapmargin=1		" chars from the right where wrapping starts

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Status Line
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set statusline=%<\[%n\]\ %F%m\ %r%y%w%q%=%-14.(%l:%c%)\ \[%L\]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Search settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch	  		" highlight matches with last search pattern
set incsearch	  		" highlight match while typing search pattern

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Mouse Options
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set mouse=a				" enable the use of mouse clicks
set mousehide	  		" hide mouse pointer while typing

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Editing
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set backspace=indent,eol,start 	" how backspace works at start of line
set matchtime=4	  		" tenths of a second to show matching paren
set nojoinspaces		" two spaces after a period with a join command
set nostartofline		" commands move cursor to first non-blank in line
set nrformats+=alpha  	" number formats recognized for CTRL-A command
set shiftround	  		" round indent to multiple of shiftwidth
set showfulltag	  		" show full tag pattern when completing tag
set showmatch	  		" briefly jump to matching bracket if insert one

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Command line
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set confirm	  			" ask what to do about unsaved/read-only files
set debug=msg			" set to "msg" to see all error messages
set history=100	  		" number of command-lines that are remembered
set laststatus=2
set report=0			" threshold for reporting nr. of lines changed
set showcmd	  			" show (partial) command in status line
set wildmenu	  		" use menu for command line completion

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Misc
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set diffopt=filler,context:4  	" options for using diff mode
set suffixes+=.backup  	" suffixes that are ignored with multiple match
set updatecount=100  	" after this many characters flush swap file
set updatetime=2000  	" after this many milliseconds flush swap file
set virtualedit=block  	" when to use virtual editing

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Startup
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Import local settings
source ~/.vimrc.local

" Enable filetype detection and load associated plugins and indentation
filetype plugin indent on

" Pathogen runtime path manipulation
execute pathogen#infect()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Autocommands
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Only load autocommands once
if !exists('autocommands_loaded')
	let autocommands_loaded = 1

	" Assembly
	autocmd FileType asm
		\ set tabstop=8 |
		\ set shiftwidth=8 |
		\ set softtabstop=8 |
		\ retab

	" Python
	autocmd FileType python
		\ set tabstop=8 |
		\ set expandtab |
		\ set shiftwidth=4 |
		\ set softtabstop=4 |
		\ retab

	" Conque
	autocmd FileType conque_term
		\ set nocursorcolumn |
		\ set nocursorline |
		\ set colorcolumn=""

	" Scaffold files
	autocmd BufReadPost *.scaffold,*.ctqg
		\ set filetype=c

	" LaTeX files
	autocmd FileType latex,tex
		\ setlocal textwidth=80 |
		\ setlocal ignorecase |
		\ setlocal infercase |
		\ map <buffer> ,c :call CommentLine("%")<CR>|
		\ map <buffer> ,d :call UncommentLine("%")<CR>|
		\ imap <buffer> ,c <Esc>:call CommentLine("%")<CR>a|
		\ imap <buffer> ,d <Esc>:call UncommentLine("%")<CR>a

	" Bash, Python, Awk
	autocmd FileType sh,python,awk
		\ map <buffer> ,c :call CommentLine("#")<CR>|
		\ map <buffer> ,d :call UncommentLine("#")<CR>|
		\ imap <buffer> ,c <Esc>:call CommentLine("#")<CR>a|
		\ imap <buffer> ,d <Esc>:call UncommentLine("#")<CR>a

	" C/C++, PHP
	autocmd FileType cpp,c,php
		\ map <buffer> ,c :call CommentLine("//")<CR>|
		\ map <buffer> ,d :call UncommentLine("//")<CR>|
		\ imap <buffer> ,c <Esc>:call CommentLine("//")<CR>a|
		\ imap <buffer> ,d <Esc>:call UncommentLine("//")<CR>a

	" Vim files
	autocmd FileType vim
		\ setlocal keywordprg=:help |
		\ map <buffer> ,c :call CommentLine("\"")<CR>|
		\ map <buffer> ,d :call UncommentLine("\"")<CR>|
		\ imap <buffer> ,c <Esc>:call CommentLine("\"")<CR>a|
		\ imap <buffer> ,d <Esc>:call UncommentLine("\"")<CR>a

	" Help Files
	autocmd FileType help
		\ setlocal keywordprg=:help |
		\ setlocal nocursorcolumn

	" Jump to last known cursor position
	autocmd	BufReadPost *
		\ if line("'\"") > 1 && line("'\"") |
		\	exe "normal! g`\"" |
		\ endif

	" Recognize Arduino files
	autocmd BufRead, BufNewFile *.pde set filetype=arduino
	autocmd BufRead, BufNewFile *.ino set filetype=arduino
endif " !exists('autocommands_loaded')

function! CommentLine(comment)
	execute "normal mt"
	execute "normal I" . a:comment . " \<Esc>"
	execute "normal `t" . (len(a:comment)+1) . "l"
endfunction

function! UncommentLine(comment)
	execute "normal mt"
	execute "normal ^" . (len(a:comment)+1) . "x"
	execute "normal `t" . (len(a:comment)+1) . "h"
endfunction

function! ToggleSpell()
	if &spell
		setlocal nospell
	else
		setlocal spell spelllang=en_us
	endif
endfunction

function! SetTab(width)
	setlocal shiftwidth=a:width
	setlocal tabstop=a:width
	setlocal softtabstop=a:width
endfunction

function! InputChar()
	let c = getchar()
	return type(c) == type(0) ? nr2char(c) : c
endfunction
