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


