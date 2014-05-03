""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" .vimrc
"
" Daniel Kudrow (dkudrow@cs.ucsb.edu)
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set this first so that Vim options are available
set nocompatible

" play nice with tmux
set term=xterm

""" Remaps
" Y should act like C, D, etc.	
noremap Y y$
" Treat line wraps like breaks
noremap j gj
noremap k gk
" $ and 0 are hard to reach
noremap H ^
noremap L $
" make navigating tabs easier
noremap te :tabedit 
noremap tn :tabnext<CR>
noremap tp :tabprevious<CR>
" Make a spelling hotkey
noremap ,s :call ToggleSpell()<CR>
" Remove trailing whitespace
noremap ,w :%s/ \+$//g
" Move around in insert mode
" imap <C-H> <Left>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-L> <Right>
" Search for selected text in visual mode
vnoremap <silent> * :<C-U>
	\let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
	\gvy/<C-R><C-R>=substitute(
	\escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
	\gV:call setreg('"', old_reg, old_regtype)<CR>

""" Appearance
set background=light  	" "dark" or "light", used for highlight colors
set number	  			" print the line number in front of each line
set norelativenumber  	" show relative line number in front of each line
" set colorcolumn=81		" columns to highlight
" set cursorcolumn		" highlight the screen column of the cursor
" highlight CursorColumn  cterm=NONE ctermbg=lightgrey
" set cursorline	  		" highlight the screen line of the cursor
" highlight CursorLine  cterm=NONE ctermbg=lightgrey
set display=lastline  	" list of flags for how to display text
set splitbelow	  		" new window from split is below the current one
set splitright	  		" new window is put right of the current one
set errorbells	  		" ring the bell for error messages
set visualbell	  		" use visual bell instead of beeping
set scrolloff=2	  		" minimum nr. of lines above and below cursor
set wrap				" long lines wrap and continue on the next line
set wrapmargin=1		" chars from the right where wrapping starts
set showbreak=+\ 		" string to use at the start of wrapped lines

""" Search settings
set hlsearch	  		" highlight matches with last search pattern
set incsearch	  		" highlight match while typing search pattern
set noignorecase  		" ignore case in search patterns
set nosmartcase	  		" no ignore case when pattern has uppercase

""" Indentation
set shiftround	  		" round indent to multiple of shiftwidth
set noexpandtab	  		" use spaces when <Tab> is inserted
set shiftwidth=8 		" number of spaces to use for (auto)indent step
set tabstop=8	  		" number of spaces that <Tab> in file uses

""" Mouse Options
set mouse=a				" enable the use of mouse clicks
set nomousefocus		" keyboard focus follows the mouse
set mousehide	  		" hide mouse pointer while typing
set mousemodel=extend  	" changes meaning of mouse buttons

""" Title, tabs and status line
" set icon				" let Vim set the text of the window icon
" set iconstring		" string to use for the Vim icon text
" set title				" let Vim set the title of the window
" set titlestring		" string to use for the Vim window title
" set tabline	  		" custom format for the console tab pages line
" Custom format for the status line
set statusline=%<\[%n\]\ %F%m\ %r%y%w%q%=%-14.(%l,%c%V%)\ %p%%
set laststatus=2
" Ruler has no effect when status line is set
" set ruler				" show cursor line and column in the status line
" set rulerformat		" custom format for the ruler
set showcmd	  			" show (partial) command in status line

" Editing
set textwidth=0
set backspace=indent,eol,start 	" how backspace works at start of line
" Note: doesn't play well with completeopt=longest
set showfulltag	  		" show full tag pattern when completing tag
set completeopt=menuone	" options for Insert mode completion
set nojoinspaces		" two spaces after a period with a join command
set nrformats+=alpha  	" number formats recognized for CTRL-A command
set nostartofline		" commands move cursor to first non-blank in line
set showmatch	  		" briefly jump to matching bracket if insert one
set matchtime=4	  		" tenths of a second to show matching paren
set matchpairs+=<:>		" pairs of characters that "%" can match
" set paste				" allow pasting text
" set pastetoggle		" key code that causes 'paste' to toggle

" Command line
set confirm	  			" ask what to do about unsaved/read-only files
set debug=msg			" set to "msg" to see all error messages
set history=100	  		" number of command-lines that are remembered
set report=0			" threshold for reporting nr. of lines changed
set wildmenu	  		" use menu for command line completion
set wildmode=full		" mode for 'wildchar' command-line expansion

""" Misc
set diffopt=filler,iwhite,context:4  	" options for using diff mode
" set spellfile	  		" files where |zg| and |zw| store words
" set foldclose=  		" close a fold when the cursor leaves it
set foldmethod=syntax  	" folding type
set foldlevelstart=10
set suffixes+=.backup  	" suffixes that are ignored with multiple match
" set switchbuf	  		" sets behavior when switching to another buffer
" set undodir=~/.vim  	" where to store undo files
" set undofile	  		" save undo information in a file
set virtualedit=block  	" when to use virtual editing
set updatecount=100  	" after this many characters flush swap file
set updatetime=2000  	" after this many milliseconds flush swap file

""" Import local settings
source ~/.vimrc.local

" Enable filetype detection and load associated plugins and indentation
" Execute last so that autocommands that depend on filetype can reset options
filetype plugin indent on

" Split screen
" let s=':let @z=&so:set so=0 noscb:bo vsLjzt:setl scbp:setl scb'

" pathogen runtime path manipulation
execute pathogen#infect()

""" Autocommands
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
	setlocal shiftwidth = a:width
	setlocal tabstop = a:width
endfunction

function! InputChar()
	let c = getchar()
	return type(c) == type(0) ? nr2char(c) : c
endfunction
