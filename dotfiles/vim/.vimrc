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

" Change tab width
command -nargs=1 SetTab call SetTab(<f-args>)
function! SetTab(width)
    execute "setl shiftwidth=".a:width
    execute "setl softtabstop=".a:width
endfunction

" Change tab width to accommodate MULTI craziness
command Multi call MultiTab()
function! MultiTab()
    execute "setl noet"
    execute "setl ts=8"
    execute "setl sw=4"
    execute "setl sts=4"
endfunction

" Change tab width to accommodate Linux source files
command Linux call LinuxTab()
function! LinuxTab()
    execute "setl noet"
    execute "setl sw=8"
    execute "setl ts=8"
    execute "setl sts=8"
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
noremap tc :tabclose<CR>

" Open ctags in new tab
"noremap <C-]> <C-w><C-]><C-w>T

" New buffer in window
noremap <leader>n :enew<CR>

" Toggle spelling
noremap <leader>s :if &spell \| setl nospell \| else \| setl spell spelllang=en_us \| endif<CR>

" Toggle automatic paragraph formatting
noremap <leader>a :if &fo=~'a' \| setl fo-=a \| else \| setl fo+=a \| endif<CR>

" Toggle colorcolumn
noremap <leader>C :if &cc=='' \| setl cc=+1 \| else \| setl cc= \| endif<CR>

" Toggle pastemode
noremap <leader>p :set invpaste<CR>

" Toggle cursorline
noremap <leader>L :set invcursorline<CR>

" Remove trailing whitespace
"noremap <leader>w :%s/ \+$//g

" Toggle wrap
noremap <leader>w :set wrap!<CR>

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

" Format JSON
vnoremap <Leader>j :!python -m json.tool<CR>
nnoremap <Leader>j :%!python -m json.tool<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Appearance
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark     " "dark" or "light", used for highlight colors
set display=lastline    " list of flags for how to display text
set number              " print the line number in front of each line
set showbreak=\>        " ttring to use at the start of wrapped lines
set splitbelow          " new window from split is below the current one
set splitright          " new window is put right of the current one

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Highlighting and Colors
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

hi Comment ctermfg=DarkGray

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Status Line
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! GetPaste()
    if &paste | return '[paste]' | else | return '' | endif
endfunction

function! GetEt()
    if &expandtab | return '[et]' | else | return '' | endif
endfunction

function! GetSpell()
    if &spell | return '[sp='.&spelllang.']' | else | return '' | endif
endfunction

function! GetAutoP()
    if &fo =~ 'a' | return '[¶]' | else | return '' | endif
endfunction

" Highlight groups
hi StBuffer   term=bold cterm=None ctermbg=DarkGrey ctermfg=Black
hi StFilename term=bold cterm=bold ctermbg=DarkGrey ctermfg=Cyan
hi StFlags    term=bold cterm=None ctermbg=DarkGrey ctermfg=Black
hi StOptions  term=bold cterm=None ctermbg=DarkGrey ctermfg=Black
hi StPosition term=bold cterm=bold ctermbg=DarkGrey ctermfg=White

" Status flags
set statusline=        " Beginning of statusline
set statusline+=%#StBuffer#
set statusline+=[%n]   " Buffer number
set statusline+=%#StFilename#
set statusline+=\ \"   " Truncate the filename
set statusline+=%t\"\  " Filename with full path
set statusline+=%m     " Modified flag
set statusline+=%#StFlags#
set statusline+=%r     " Readonly flag
set statusline+=%y     " Filetype
set statusline+=%w     " Preview window flag

" Options values
set statusline+=%-.(%)
set statusline+=%#StOptions#
set statusline+=%-1.(%)\         " Pad
set statusline+=[tw=%{&textwidth}] " Show textwidth
set statusline+=[sw=%{&shiftwidth}]   " Show shiftwidth
set statusline+=%{GetPaste()}       " Show expandtab
set statusline+=%{GetEt()}       " Show expandtab
set statusline+=%{GetSpell()}    " Show spell check
set statusline+=%{GetAutoP()}    " Show auto paragraph formatting

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
set ignorecase          " ignore case in searches

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

function! MultiSearchNext(i)
    call search(get(g:SearchPatterns, a:i, ""))
endfunction

function! MultiSearchPrev(i)
    call search(get(g:SearchPatterns, a:i, ""), "b")
endfunction

command! -nargs=1 MSAdd   call MultiSearchAdd(<f-args>)
command! -nargs=? MSClear call MultiSearchClear(<f-args>)
command! -nargs=0 MSList  call MultiSearchList()
command! -nargs=+ MSSet   call MultiSearchSet(<f-args>)
command! -nargs=1 MSNext  call MultiSearchNext(<f-args>)
command! -nargs=1 MSPrev  call MultiSearchPrev(<f-args>)

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
set nojoinspaces        " two spaces after a period with a join command
set nostartofline       " commands move cursor to first non-blank in line
set shiftround          " round indent to multiple of shiftwidth
set showfulltag         " show full tag pattern when completing tag
set showmatch           " briefly jump to matching bracket if insert one
set textwidth=80
set tabstop=8           " tabs are 8 columns wide
set softtabstop=8
set shiftwidth=8

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

set diffopt=filler,context:3    " options for using diff mode
set suffixes+=.backup   " suffixes that are ignored with multiple match
set updatecount=100     " after this many characters flush swap file
set updatetime=1000     " after this many milliseconds flush swap file
set virtualedit=block   " when to use virtual editing

" Show the highlight rule in effect for the word under the cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" GUI options
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('gui_running')
    set bg=light

    colorscheme multi

    set guifont=Monaco\ 10

    hi StBuffer   gui=None guibg=LightGrey guifg=Black
    hi StFilename gui=Bold guibg=LightGrey guifg=Black
    hi StFlags    gui=None guibg=LightGrey guifg=Black
    hi StOptions  gui=None guibg=LightGrey guifg=Black
    hi StPosition gui=bold guibg=LightGrey guifg=Black

    " Start gvim in a reasonable location
    let hostname=substitute(system("hostname"), "\n*$", "", "")
    if hostname == "fennel"
        cd /home/fennel/dani
    endif

endif " gui_running

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Startup
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Import local settings
if filereadable("~/.vimrc.local")
    source ~/.vimrc.local
    echom "Warning: could not find ~/.vimrc.local"
endif

" Enable filetype detection and load associated plugins and indentation
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" vim-plug
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'mhinz/vim-signify'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" Autocommands
"
" Put each set of autocmds in a group and start with autocmd! so if
" the vimrc is reloaded the autocommands are not added again.
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup log
    autocmd!
    autocmd BufRead, BufNewFile *.log set filetyp=log
		\ setl nowrap |
		\ setl ignorecase
augroup END

augroup markdown
    autocmd!
    autocmd BufRead,BufNewFile *.md
		\ setl filetype=markdown
augroup END

augroup python
    autocmd!
    autocmd FileType python
                \ SetTab 4 |
		\ setl expandtab
augroup END

augroup vim
    autocmd!
    autocmd FileType vim
                \ SetTab 4 |
		\ setl expandtab
augroup END

augroup c
    autocmd!
    autocmd FileType c,cpp
                \ SetTab 4

augroup misc
    autocmd!

    " Jump to last known cursor position
    autocmd BufReadPost *
		\ if line("'\"") > 1 && line("'\"") |
		\   exe "normal! g`\"" |
		\ endif
augroup END
