

set nocompatible " use vim as vim, should be put at the very start
set history=5000 " lines of Ex-mode commands, search history
filetype on " enable file type detection
filetype plugin indent on " enable loading the plugin for appropriate file type 

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
"set nowrap " do not wrap lines

au FileType html setl ts=2 sw=2 sts=2 et

set fenc=utf8
set fencs=utf8,gbk,gb18030,gb2312,ascii,big5,utf16,utf32

color desert
"set background=dark
"let g:solarized_termtrans=1
"let g:solarized_italic=0
"let g:solarized_bold=0
"let g:solarized_underline=0
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"
"colorscheme solarized

set nu

let g:pydiction_location='/home/wgwang/.vim/ftplugin/pydiction/complete-dict'

if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    au FileType c,cpp,cxx,h,hpp set foldmethod=syntax
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
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags 

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

let vimrplugin_screenplugin = 0

autocmd bufnewfile *.py :0r ~/.vim/templates/python.py

map <C-n> :bnext<CR>
imap <f2> <ESC><CR>
imap zz <ESC>

