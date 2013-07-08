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

execute pathogen#infect()
filetype on " enable file type detection
filetype plugin indent on " enable loading the plugin for appropriate file type 



if has("autocmd")
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    autocmd FileType c,cpp,cxx,h,hpp set foldmethod=syntax

    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType html setl ts=2 sw=2 sts=2 et
    
    autocmd FileType xml let g:xml_syntax_folding=1
    autocmd FileType xml setlocal foldmethod=syntax ts=2 sw=2 sts=2 et
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags 

    autocmd FileType python let g:pydiction_location='$HOME/.vim/ftplugin/pydiction/complete-dict'
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd bufnewfile *.py :0r ~/.vim/templates/python.py
   
    autocmd FileType javascript set dictionary+=$HOME/.vim/ftplugin/node/node.dict
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType javascript let g:javaScript_fold=1
    "autocmd FileType javascript call JavaScriptFold()
    autocmd FileType javascript setlocal foldmethod=syntax autoindent smartindent

    autocmd FileType json set formatoptions=tcq2l 
    autocmd FileType json setlocal ts=2 sw=2 sts=2 et foldmethod=syntax autoindent

    autocmd filetype jade set ts=2 sw=2 sts=2 et
endif

let vimrplugin_screenplugin = 0


map <C-n> :bnext<CR>
imap <f2> <ESC><CR>
imap zz <ESC>

