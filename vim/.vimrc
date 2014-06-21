""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" .vimrc
"
" Daniel Kudrow (dkudrow@cs.ucsb.edu)
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Functions
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Toggle spell check mode
function! ToggleSpell()
	if &spell
		setlocal nospell
	else
		setlocal spell spelllang=en_us
	endif
endfunction

" Change tab width
function! SetTab(width)
	execute "setlocal tabstop=".a:width
	execute "setlocal shiftwidth=".a:width
	execute "setlocal softtabstop=".a:width
endfunction

" Get the number of terminal colors
function! GetColor()
	let c = split(system('tput colors'))[0]
	return c
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Global configuration
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set this first so that Vim options are available
set nocompatible

" Play nice with tmux
set term=xterm

" Some terminals don't know they have 256 colors
set t_Co=256

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

function! GetEt()
	if &expandtab | return '[et]' | else | return '' | endif
endfunction

" Highlight groups
function! StatuslineSolarized()
	highlight StBuffer term=bold cterm=None ctermbg=DarkGrey  ctermfg=White
	highlight StFilename term=bold cterm=bold ctermbg=DarkGrey ctermfg=Black
	highlight StFlags term=bold cterm=None ctermbg=DarkGrey ctermfg=White
	highlight StOptions term=bold cterm=None ctermbg=DarkGrey ctermfg=Black
	highlight StPosition term=bold cterm=bold ctermbg=DarkGrey ctermfg=Black
endfunction

function! StatuslineDark()
	highlight StBuffer term=bold cterm=None ctermbg=DarkBlue ctermfg=Red
	highlight StFilename term=bold cterm=bold ctermbg=DarkBlue ctermfg=Cyan
	highlight StFlags term=bold cterm=None ctermbg=DarkBlue ctermfg=Red
	highlight StOptions term=bold cterm=None ctermbg=DarkBlue ctermfg=Cyan
	highlight StPosition term=bold cterm=bold ctermbg=DarkBlue ctermfg=Yellow
endfunction

function! StatuslineLight()
	highlight StBuffer term=bold cterm=bold ctermbg=DarkGrey ctermfg=White
	highlight StFilename term=bold cterm=bold ctermbg=DarkGrey ctermfg=Cyan
	highlight StFlags term=bold cterm=bold ctermbg=DarkGrey ctermfg=White
	highlight StOptions term=bold cterm=bold ctermbg=DarkGrey ctermfg=LightGrey
	highlight StPosition term=bold cterm=bold ctermbg=DarkGrey ctermfg=White
endfunction

function! StatuslineBrown()
	highlight StBuffer term=bold cterm=bold ctermbg=Brown ctermfg=White
	highlight StFilename term=bold cterm=bold ctermbg=Brown ctermfg=LightCyan
	highlight StModified term=bold cterm=bold ctermbg=Brown ctermfg=LightRed
	highlight StFlags term=bold cterm=bold ctermbg=Brown ctermfg=White
	highlight StOptions term=bold cterm=bold ctermbg=Brown ctermfg=LightGrey
	highlight StPosition term=bold cterm=bold ctermbg=Brown ctermfg=White
endfunction

call StatuslineSolarized()

" Status flags
set statusline=%<			" Truncate at the beginning
set statusline+=%#StBuffer#
set statusline+=[%n]	" Buffer number
set statusline+=%#StFilename#
set statusline+=\ \"%F\"\ 	" Filename with full path
set statusline+=%m		" Modified flag
set statusline+=%#StFlags#
set statusline+=%r			" Readonly flag
set statusline+=%y			" Filetype
set statusline+=%w			" Preview window flag
set statusline+=%q			" Quickfixes, locations, or empty

" Options values
set statusline+=%-.(%)
set statusline+=%#StOptions#
set statusline+=%-1.(%)				" Pad
set statusline+=[tw=%{&textwidth}]	" Show textwidth
set statusline+=[ts=%{&tabstop}]	" Show tabstop
set statusline+=%{GetEt()}			" Show expandtab

" Position
set statusline+=%=			" Separation between left- and right-align
set statusline+=%#StPosition#
set statusline+=\ %L\ lines\ 
set statusline+=%-.(--%l,%c--\ %)
"set statusline+=--%p%%--

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
set textwidth=75
call SetTab(4)

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Filetype specific commands
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

	" Assembly
	autocmd FileType asm
		\ call SetTab(8) |
		\ retab

	" Help
	autocmd FileType help
		\ setlocal keywordprg=:help

	" LaTeX
	autocmd FileType latex,tex
		\ setlocal ignorecase |
		\ setlocal infercase

	" Python
	autocmd FileType python
		\ set expandtab |
		\ retab

	" Ruby
	autocmd FileType ruby
		\ call SetTab(2) |
		\ set expandtab |
		\ retab

	" Vimscript
	autocmd FileType vim
		\ setlocal keywordprg=:help

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Miscellaneous autocommands
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

	" Jump to last known cursor position
	autocmd	BufReadPost *
		\ if line("'\"") > 1 && line("'\"") |
		\	exe "normal! g`\"" |
		\ endif

	" Recognize Arduino files
	autocmd BufRead, BufNewFile *.pde set filetype=arduino
	autocmd BufRead, BufNewFile *.ino set filetype=arduino
endif " !exists('autocommands_loaded')
