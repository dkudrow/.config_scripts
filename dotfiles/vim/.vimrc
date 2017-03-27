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

" Toggle auto paragraph formatting
function! TogglePFormat()
    if &formatoptions =~ 'a'
        setlocal formatoptions-=a
    else
        setlocal formatoptions+=a
    endif
endfunction

" Change tab width
command -nargs=1 SetTab call SetTab(<f-args>)
function! SetTab(width)
    execute "setlocal tabstop=".a:width
    execute "setlocal shiftwidth=".a:width
    "execute "setlocal softtabstop=".a:width
endfunction

" Change tab width to accommodate MULTI craziness
command Multi call MultiTab()
function! MultiTab()
	execute "set sw=4"
	execute "set ts=8"
	execute "set et"
endfunction

" Change tab width to accommodate Linux source files
command Linux call LinuxTab()
function! LinuxTab()
	execute "set sw=8"
	execute "set ts=8"
	execute "set noet"
endfunction

" Get the number of terminal colors
function! GetColor()
    let c = split(system('tput colors'))[0]
    return c
endfunction

" Toggle colorcolumn
function! ToggleCC()
        if &cc == ""
                setlocal cc=+1
        else
                setlocal cc=
        endif
endfunction

" Toggle hex editor
command -bar Hexmode call ToggleHex()
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries 
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
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

" Make ',' the leader
let mapleader = ","

" V and Y should act like C, D, etc.    
noremap Y y$
noremap V v$
noremap vv 0v$

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

" Open ctags in new tab
"noremap <C-]> <C-w><C-]><C-w>T

" New buffer in window
noremap <leader>n :enew<CR>

" Toggle spelling
noremap <leader>s :call ToggleSpell()<CR>

" Toggle automatic paragraph formatting
noremap <leader>a :call TogglePFormat()<CR>

" Toggle colorcolumn
noremap <leader>C :call ToggleCC()<CR>

" Toggle pastemode
noremap <leader>p :set invpaste<CR>

" Toggle cursorline
noremap <leader>L :set invcursorline<CR>

" Remove trailing whitespace
noremap <leader>w :%s/ \+$//g

" Indent file
noremap <leader>= mQgg=G`Q

" Search and replace word under cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

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

set background=dark     " "dark" or "light", used for highlight colors
"set colorcolumn=+1     " column(s) to highlight
set cursorline          " highlight the screen line of the cursor
set display=lastline    " list of flags for how to display text
set number              " print the line number in front of each line
set scrolloff=2         " minimum nr. of lines above and below cursor
set showbreak=+\        " ttring to use at the start of wrapped lines
set splitbelow          " new window from split is below the current one
set splitright          " new window is put right of the current one
set wrapmargin=1        " chars from the right where wrapping starts

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Status Line
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! GetPaste()
	if &paste | return '[✂]' | else | return '' | endif
endfunction

function! GetEt()
    if &expandtab | return '[⟺]' | else | return '' | endif
endfunction

function! GetSpell()
    if &spell | return '[✓'.&spelllang.']' | else | return '' | endif
endfunction

function! GetAutoP()
    if &fo =~ 'a' | return '[¶]' | else | return '' | endif
endfunction

function! GetICase()
    if &ignorecase | return '[Aa]' | else | return '' | endif
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
    highlight StBuffer term=bold cterm=None ctermbg=DarkGrey ctermfg=Black
    highlight StFilename term=bold cterm=bold ctermbg=DarkGrey ctermfg=Cyan
    highlight StFlags term=bold cterm=None ctermbg=DarkGrey ctermfg=Black
    highlight StOptions term=bold cterm=None ctermbg=DarkGrey ctermfg=Black
    highlight StPosition term=bold cterm=bold ctermbg=DarkGrey ctermfg=White
endfunction

function! StatuslineLight()
    highlight StBuffer term=bold cterm=bold ctermbg=DarkGrey ctermfg=White
    highlight StFilename term=bold cterm=bold ctermbg=DarkGrey ctermfg=Cyan
    highlight StFlags term=bold cterm=bold ctermbg=DarkGrey ctermfg=White
    highlight StOptions term=bold cterm=bold ctermbg=DarkGrey ctermfg=LightGrey
    highlight StPosition term=bold cterm=bold ctermbg=DarkGrey ctermfg=White
endfunction

function! StatuslineClear()
    highlight StBuffer term=bold cterm=bold ctermbg=Black ctermfg=DarkGrey
    highlight StFilename term=bold cterm=bold ctermbg=Black ctermfg=Red
    highlight StModified term=bold cterm=bold ctermbg=Black ctermfg=Red
    highlight StFlags term=bold cterm=bold ctermbg=Black ctermfg=DarkGrey
    highlight StOptions term=bold cterm=bold ctermbg=Black ctermfg=DarkGrey
    highlight StPosition term=bold cterm=bold ctermbg=Black ctermfg=DarkGrey
endfunction

function! StatuslineBrown()
    highlight StBuffer term=bold cterm=bold ctermbg=Brown ctermfg=White
    highlight StFilename term=bold cterm=bold ctermbg=Brown ctermfg=LightCyan
    highlight StModified term=bold cterm=bold ctermbg=Brown ctermfg=LightRed
    highlight StFlags term=bold cterm=bold ctermbg=Brown ctermfg=White
    highlight StOptions term=bold cterm=bold ctermbg=Brown ctermfg=LightGrey
    highlight StPosition term=bold cterm=bold ctermbg=Brown ctermfg=White
endfunction

call StatuslineDark()

" Status flags
set statusline=        " Beginning of statusline
set statusline+=%#StBuffer#
set statusline+=[%n]   " Buffer number
set statusline+=%#StFilename#
set statusline+=\ \"%< " Truncate the filename
set statusline+=%F\"\  " Filename with full path
set statusline+=%m     " Modified flag
set statusline+=%#StFlags#
set statusline+=%r     " Readonly flag
set statusline+=%y     " Filetype
set statusline+=%w     " Preview window flag

" Options values
set statusline+=%-.(%)
set statusline+=%#StOptions#
set statusline+=%-1.(%)\         " Pad
set statusline+=[↲%{&textwidth}] " Show textwidth
set statusline+=[⇌%{&tabstop}]   " Show tabstop
set statusline+=%{GetPaste()}       " Show expandtab
set statusline+=%{GetEt()}       " Show expandtab
set statusline+=%{GetSpell()}    " Show spell check
set statusline+=%{GetAutoP()}    " Show auto paragraph formatting
set statusline+=%{GetICase()}    " Show ignorecase

" Position
set statusline+=%=          " Separation between left- and right-align
set statusline+=%#StPosition#
set statusline+=\ %L\ lines\ 
set statusline+=%-.(--%l,%v--\ %)
"set statusline+=--%p%%--

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Search settings
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch            " highlight matches with last search pattern
set incsearch           " highlight match while typing search pattern

" Allow multiple searches at once
" Search         xxx term=reverse ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
highlight Search1  term=reverse ctermfg=0 ctermbg=9  guifg=Black guibg=Red
highlight Search2  term=reverse ctermfg=0 ctermbg=10  guifg=Black guibg=Green
highlight Search3  term=reverse ctermfg=0 ctermbg=15  guifg=Black guibg=White

let SearchPatterns = ["", "", ""]

function! MultiSearchRedraw()
	execute "match  Search1 /" . get(g:SearchPatterns, 0) . "/"
	execute "2match Search2 /" . get(g:SearchPatterns, 1) . "/"
	execute "3match Search3 /" . get(g:SearchPatterns, 2) . "/"
endfunction

" MultiSearch
function! MultiSearchAdd(pattern)
	let i = 0
	while i < 3
		if empty(get(g:SearchPatterns, i))
			let g:SearchPatterns[i] = a:pattern
			call MultiSearchRedraw()
			return
		endif
		let i += 1
	endwhile
	echo "SearchPatterns is full:"
	call MultiSearchList()
endfunction

function! MultiSearchClear(...)
	if len(a:000) == 0
		let g:SearchPatterns = ["", "", ""]
	else
		for i in a:000
			let g:SearchPatterns[i] = ""
		endfor
	endif
	call MultiSearchRedraw()
endfunction

function! MultiSearchSet(i, pattern)
	let g:SearchPatterns[i] = a:pattern
	call MultiSearchRedraw()
endfunction

function! MultiSearchList()
	let i = 0
	while i < 3
		echo i . ": " . get(g:SearchPatterns, i, "")
		let i += 1
	endwhile
endfunction

command! -nargs=1 MSAdd   call MultiSearchAdd(<f-args>)
command! -nargs=? MSClear call MultiSearchClear(<f-args>)
command! -nargs=0 MSList  call MultiSearchList()
command! -nargs=+ MSSet   call MultiSearchSet(<f-args>)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Mouse Options
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set mouse=a             " enable the use of mouse clicks
set mousehide           " hide mouse pointer while typing

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Editing
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set backspace=indent,eol,start  " how backspace works at start of line
set formatoptions+=n    " automatically reformat paragrahps, ordered lists
set matchtime=4         " tenths of a second to show matching paren
set nojoinspaces        " two spaces after a period with a join command
set nostartofline       " commands move cursor to first non-blank in line
set nrformats+=alpha    " number formats recognized for CTRL-A command
set shiftround          " round indent to multiple of shiftwidth
set showfulltag         " show full tag pattern when completing tag
set showmatch           " briefly jump to matching bracket if insert one
set textwidth=80
set softtabstop=-1
call SetTab(4)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Command line
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set confirm             " ask what to do about unsaved/read-only files
set debug=msg           " set to "msg" to see all error messages
set history=100         " number of command-lines that are remembered
set laststatus=2
set report=0            " threshold for reporting nr. of lines changed
set showcmd             " show (partial) command in status line
set wildmenu            " use menu for command line completion

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Misc
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set diffopt=filler,context:4    " options for using diff mode
set suffixes+=.backup   " suffixes that are ignored with multiple match
set updatecount=100     " after this many characters flush swap file
set updatetime=2000     " after this many milliseconds flush swap file
set virtualedit=block   " when to use virtual editing

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Startup
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Import local settings
source ~/.vimrc.local

" Enable filetype detection and load associated plugins and indentation
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" vim-plug
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Autocommands
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup log
	autocmd!
	autocmd BufRead, BufNewFile *.log set filetyp=log
	set nowrap
augroup END

augroup arduino
    autocmd!
    autocmd BufRead,BufNewFile *.pde set filetype=arduino
    autocmd BufRead,BufNewFile *.ino set filetype=arduino
augroup END

augroup asm
    autocmd!
    autocmd FileType asm
                \ call SetTab(8) |
                \ retab
augroup END

augroup c
    autocmd!
    autocmd BufRead,BufNewFile *.h set filetype=c
    autocmd FileType c
                \ call SetTab(4) |
                \ set expandtab
            
augroup END

augroup cpp
    autocmd!
    autocmd FileType cpp
                \   call SetTab(4)
augroup END

augroup help
    autocmd!
    autocmd FileType help
                \ setlocal keywordprg=:help
augroup END

augroup tex
    autocmd!
    autocmd FileType latex,tex
                \ setlocal ignorecase |
                \ setlocal infercase
augroup END

augroup markdown
    autocmd!
    autocmd BufRead,BufNewFile *.md set filetype=markdown
augroup END

augroup python
    autocmd!
    autocmd FileType python
                \ call SetTab(4) |
                \ set expandtab |
                \ retab
augroup END

augroup ruby
    autocmd!
    autocmd FileType ruby,eruby,puppet
                \ call SetTab(2) |
                \ set expandtab |
                \ retab
augroup END

augroup vim
    autocmd!
    autocmd FileType vim
                \ setlocal keywordprg=:help
augroup END

augroup misc
    autocmd!

    " Jump to last known cursor position
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") |
                \   exe "normal! g`\"" |
                \ endif

    " Read in skeleton files
    autocmd BufNewFile *.* silent! execute '0r $HOME/.vim/templates/skeleton.'.expand("<afile>:e")
    autocmd BufNewFile * silent! %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge
augroup END
