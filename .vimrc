" vim has a nasty habit of adding \n at EOF by default. this prevents it
" this also takes away vim's smart behavior regarding line endings though, so comment it out if working a lot with Windows files
"set binary
"au BufNewFile * set noeol

colorscheme desert
syntax on
set title
set showcmd
set ic
"set number
"set cryptmethod=blowfish
"make file completion behave more like bash
set wildmode=longest,list,full
set wildmenu

"use regular system clipboard for copy/paste operations
"set clipboard=unnamed
vnoremap <C-c> "*y 
vnoremap <C-x> "*x 
"vnoremap <C-c> "+y 

"make yank and delete go to system clipboard by default (nice idea but doesnt work)
"set clipboard=unnamed "
"set clipboard=unnamedplus
"set clipboard=unnamedplus,unnamed,autoselect

"default to 14 pt font when printing
set printfont=:h13

"set nosi noai
set nosmartindent
set noai

"toggle autoindent mode when pasting
set paste
set pastetoggle=<Leader>i

set tabstop=4
set shiftwidth=4
set expandtab
set ruler
set incsearch
set hlsearch
" make visual mode w selection consistent with non-visual
set selection=exclusive

set nobackup
set noswapfile
set backupdir=~/.vim-tmp/backup/
set directory=~/.vim-tmp/swap/
set undodir=~/.vim-tmp/undo/


if &diff
    " colorscheme evening
    highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
    highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

    " get rid of those fucking folds in vimdiff
    " set diffopt=filler,context:1000000
    " disable folding
    au WinEnter * set nofen
    au WinLeave * set nofen

    " tell vimdiff to ignore whitespace
    set diffopt+=iwhite

    " easy vimdiff 
    nnoremap <Up> [c
    nnoremap <Down> ]c
    nnoremap <Left> <C-w>w
    nnoremap <Right> <C-w>w
    " copy the left change to both windows
    "nnoremap <Left> :diffget 2<CR><C-w>w:diffget 2<CR><C-w>w
    "nnoremap <Right> :diffget 1<CR><C-w>w:diffget 1<CR><C-w>w
endif

"idea: create a low tech "surround" mode whereby anything you type gets symmetrically added to both sides of whatever word you are on, or current visually selected text. also allows symmetrical deletion from both ends


"tell vi to respect dos line endings when already there (vim already does by default)
"set fileformats=unix,dos

"when pasting over text in visual mode, delete to black hole first to prevent replaced text from being yanked into default buffer
vnoremap p "_dp
vnoremap P "_dP

"easy way to select word without its trailing space
vnoremap ie iwh

"easy escape from insert mode
"inoremap jj <Esc> 
"cnoremap jj <Esc>

"easy way to paste from the yank buffer instead of the default " buffer (which gets overwritten by delete and x operations)
"nnoremap ,p "0p
"xnoremap ,p "0p

function! TabbedSplitsMode()
    "use tab key to switch tabs in normal mode
    nnoremap <tab> <C-w>w 
    nnoremap <S-tab> <C-w>W
    "echo 'tabbed splits mode'
endfunction

function! TabbedTabsMode()
    "use tab key to switch tabs in normal mode
    nnoremap <tab> gt
    nnoremap <S-tab> gT
    "nnoremap <tab> :tabn<CR>
    "nnoremap <S-tab> :tabp<CR>
    "echo 'tabbed tabs mode'
endfunction

function! TabbedBuffersMode()
    "use tab key to switch buffers in normal mode
    nnoremap <tab> :bn<cr> 
    nnoremap <S-tab> :bp<cr> 
    "echo 'tabbed buffers mode'
endfunction

function! TabbedWindowsMode()
    "use tab key to switch split windows in normal mode
    nnoremap <tab> <C-w>w 
    nnoremap <S-tab> <S-C-w>w 
    "echo 'tabbed windows mode'
endfunction

nnoremap <Leader>ts :call TabbedSplitsMode()<CR>
nnoremap <Leader>tt :call TabbedTabsMode()<CR>
nnoremap <Leader>tb :call TabbedBuffersMode()<CR>
nnoremap <Leader>tw :call TabbedWindowsMode()<CR>

autocmd VimEnter * call TabbedTabsMode()

" easy vimdiff 
"nnoremap <Up> [c
"nnoremap <Down> ]c
" copy the left change to both windows
"nnoremap <Left> :diffget 2<CR><C-w>w:diffget 2<CR><C-w>w
"nnoremap <Right> :diffget 1<CR><C-w>w:diffget 1<CR><C-w>w

" easily rearrange tabs
nnoremap <C-j> :execute "tabmove" tabpagenr() - 2<CR>
nnoremap <C-k> :execute "tabmove" tabpagenr()<CR>

" truly lazy :norm invoation
vnoremap <C-n> :norm 

" traditional editor cursor movement that goes to character directly above or below on screen
" nnoremap <C-j> gj
" nnoremap <C-k> gk
" nnoremap <C-h> g0
" nnoremap <C-l> g$

" scroll screen
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

"like gf but opens in a tab
"nnoremap tf <C-w>gf
nnoremap gf <C-w>gf

"double tab to autocomplete in insertion mode
" inoremap <tab><tab> <C-p>

" easy tabbed views
" noremap <C-w>ff <C-w>f<C-w>T

"quickie macros using register q. 
"qq to record, q to stop, and Q to apply over visually selected text
nnoremap Q @q
vnoremap Q :norm @q<cr>
"noremap Q q
"noremap q <Space> 


"a "no side-effect" mode where deletes and changes dont overwrite buffers
"handy for copy/paste operations
"when activated, it works by remapping x and d to use black hole register _ instead 
"noremap ,, :noremap dd "_dd\| noremap D "_D\| noremap d "_d\| noremap x "_x<cr>
"noremap ,m :noremap dd dd\| noremap D D\| noremap d d\| noremap x x<cr>

function! ToggleSideEffects()
    if mapcheck("dd", "n") == ""
        noremap dd "_dd
        noremap D "_D
        noremap d "_d
        noremap X "_X
        noremap x "_x
        echo 'side effects off'
    else
        unmap dd
        unmap D
        unmap d
        unmap X
        unmap x
        echo 'side effects on'
    endif
endfunction

nnoremap ,s :call ToggleSideEffects()<CR>
"lets you mark a spot with mi and then go anywhere in doc and paste whatever is highlighted to `i
vnoremap <C-i> y`ip`]mi`' 

"insert one character
"noremap S a<Space><Esc>r
"noremap s i<Space><Esc>r


"block comment/uncomment
"turn on vims filetype recognition
filetype on

"enable loading plugins
filetype plugin on

filetype plugin indent on

" make nerdcomment a little easier
" noremap <leader>c :call NERDComment(0,"toggle")<CR>

" Set comment characters for common languages
"let b:StartComment='#' | let b:EndComment=''
"autocmd FileType python,sh,bash,zsh,ruby,perl,muttrc let b:StartComment='#' | let b:EndComment=''
"autocmd FileType html,xml,xhtml let b:StartComment='<!--' | let b:EndComment='-->'
"autocmd FileType php,cpp,javascript,java,ceylon,groovy,gradle let b:StartComment='//' | let b:EndComment=''
"autocmd FileType c,css let b:StartComment='/\*' | let b:EndComment='\*/'
"autocmd FileType vim let b:StartComment='"' | let b:EndComment=''
"autocmd FileType ini let b:StartComment=';' | let b:EndComment=''
"autocmd FileType sql let b:StartComment='--' | let b:EndComment=''
"" Toggle comments on a visual block
"function! CommentLines()
"    try
"          execute ':s@^\(\s*\)'.b:StartComment.'\s\?\(.*\)\s\?'.b:EndComment.'\(\s*\)@\1\2\3@g'
"    catch
"        execute ':s@^@'.b:StartComment.' @g'
"        execute ':s@$@ '.b:EndComment.'@g'
"    endtry
"endfunction
" Comment/uncomment conveniently by pressing \c, assuming Leader is mapped to \
" noremap <Leader>c :call CommentLines()<CR>

"trim off last character of line (z)
noremap z mU$x`U

"useful for gf to open referenced files
set path=$PWD/**

" Search for visually selected highlighted text using *, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"dont autoinsert comment on next line
set formatoptions-=cro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
