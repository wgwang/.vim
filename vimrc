set nocompatible " use vim as vim, should be put at the very start
set history=5000 " lines of Ex-mode commands, search history


set showmatch " show matching paren
set incsearch " BUT do highlight where the so far typed pattern matches
set hlsearch

set ai " autoindent
set si " smartindent
set tabstop=4 " tab spacing (settings below are just to unify it)
set softtabstop=4 " unify
set shiftwidth=4 " unify
set expandtab " real tabs please!
set smarttab " use tabs at the start of a line, spaces elsewhere
set nu
"set nowrap " do not wrap lines

color desert

set fenc=utf8
set fencs=utf8,gbk,gb18030,gb2312,ascii,big5,utf16,utf32

filetype on " enable file type detection
filetype plugin indent on " enable loading the plugin for appropriate file type 





if has("autocmd")
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    autocmd FileType c,cpp,cxx,h,hpp set foldmethod=syntax

    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType html setl ts=2 sw=2 sts=2 et

    let g:pydiction_location='/home/wgwang/.vim/ftplugin/pydiction/complete-dict'
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd bufnewfile *.py :0r ~/.vim/templates/python.py

    let g:xml_syntax_folding=1
    autocmd FileType xml setlocal foldmethod=syntax ts=2 sw=2 sts=2 et
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags 
    
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType javascript call JavaScriptFold()
    let g:javaScript_fold=1
    autocmd FileType javascript setlocal foldmethod=syntax

endif

"let g:neocomplcache_enable_at_startup = 1 
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" " Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
"" " Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
"" " Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
"" " Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1
"" " Set minimum syntax keyword length.
"let g:neocomplcache_min_syntax_length = 3
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
""
"let g:neocomplcache_enable_auto_select = 1 


let vimrplugin_screenplugin = 0



map <C-n> :bnext<CR>
imap <f2> <ESC><CR>
imap zz <ESC>

