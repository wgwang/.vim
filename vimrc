set nocompatible " use vim as vim, should be put at the very start
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" alternatively, pass a path where Vundle should install plugins
"let path = '~/some/path/here'
"call vundle#rc(path)

" let Vundle manage Vundle, required
Plugin 'gmarik/vundle'

" These are some awesome colorschemes. 
" I like desert, but molokai is awesome two.
Plugin 'fugalh/desert.vim'
Plugin 'mbbill/desertEx'
Plugin 'tomasr/molokai'

" There are some project files explorer.
" I like built in netrw. You should try it too.
" Plugin 'tpope/vim-vinegar'
" Plugin 'scrooloose/nerdtree'

" There are several autocomplete plugins listing the follow. 
" All these plugins aren't prefect. Choosing the one you prefer.
" YCM is my choice, and the following config is based it.
Plugin 'Valloric/YouCompleteMe'
"Plugin 'AutoComplPop'
"Plugin 'eparreno/vim-l9'
"Plugin 'dirkwallenstein/vim-autocomplpop'
"Plugin 'othree/vim-autocomplpop'
"Plugin 'ervandew/supertab'
"Plugin 'davidhalter/jedi-vim'

" For buffers exploring, like multi-tab
Plugin 'fholgado/minibufexpl.vim'

" Files finder, supporting fuzzy, reg, etc.
" Vim built in netrw is for files explore
Plugin 'kien/ctrlp.vim' 

" For version control system, support svn, cvs, git, hg etc.
" Plugin 'wgwang/vcscommand'
" For git
Plugin 'tpope/vim-fugitive'
" Plugin 'mhinz/vim-signify'

" For source exploring via ctags, like source insight.
" It is useful when reading source files of large projects.
Plugin 'wesleyche/SrcExpl'

" Auto detecting CJK and Unicode file encodings. 
" You should not use it if all your docs are ascii only.
Plugin 'mbbill/fencview'

" Browsing the tags of source code files via a sidebar.
" It displays the ctags-generated tags of the current file, ordered by their scope. 
" Such as methods in C++ are displayed under the class they are defined in. 
Plugin 'majutsushi/tagbar'

" Some settings simple and useful.
Plugin 'tpope/vim-sensible'

" Auto-completion for quotes, parens, brackets, etc. in insert mode.
Plugin 'Raimondi/delimitMate'

" Display the indention levels with thin vertical lines
Plugin 'Yggdroot/indentLine'

" Syntax checking
" This plugin is complicated. It needs careful configuration.
Plugin 'scrooloose/syntastic'

" Snippets for several programming language
" The default settings is incompatible with YouCompleteMe, 
" because both of they use <tab> key as trigger.
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" Another options
"Plugin 'garbas/vim-snipmate'

" Handle comments for several programming languages
Plugin 'tomtom/tcomment_vim'

" Several languages plugins like c-support.
Plugin 'WolfgangMehner/vim-plugins'

" Color tool for view/pick/edit/design/scheme
" Especially for css design
" Plugin 'Rykka/colorv.vim'

" Python programming tools.
" Because of syntastic and YCM,  disable its syntax check and autocomplete
" Plugin 'klen/python-mode'
Plugin 'tmhedberg/SimpylFold'

"django template, set filetype=htmldjango
" Plugin 'django.vim'
"Jinja2 tempalte
"Plugin 'Glench/Vim-Jinja2-Syntax'

" C & C++
Plugin 'a.vim'
" Additional syntax highlighting for C++11/14
Plugin 'octol/vim-cpp-enhanced-highlight'
" Syntax for STL
Plugin 'Mizuchi/STL-Syntax'
" Autocomplete plugin alternative to YCM
"Plugin 'Rip-Rip/clang_complete'

" Go language 
" Using https://github.com/nsf/gocode as daemon
" You should check first if gocode is insalled properly.
Plugin 'Blackrush/vim-gocode'
" Another plugin for golang, but maybe conflict with vim-gocode
"Plugin 'jnwhiteh/vim-golang'

" reStructureText, syntax, folding and indent
" Plugin 'Rykka/clickable.vim'
" Plugin 'Rykka/riv.vim'
" Plugin 'vim-voom/VOoM'
" Plugin 'vim-scripts/rest.vim'
"php
"Plugin '2072/PHP-Indenting-for-VIm'
"Plugin 'StanAngeloff/php.vim'
"Plugin 'rayburgemeestre/phpfolding.vim'

" Javascript
" Ref: http://oli.me.uk/2013/06/29/equipping-vim-for-javascript/
" Plugin 'jelera/vim-javascript-syntax'
" Plugin 'pangloss/vim-javascript' "indentation and Syntax
" Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'marijnh/tern_for_vim'
"Plugin 'othree/javascript-libraries-syntax.vim'
" formatting javascript files
"Plugin 'maksimr/vim-jsbeautify'
" node project
"Plugin 'moll/vim-node'

" For json, hilight and indent etc.
Plugin 'elzr/vim-json'

" For xml, HTML&HTML5
" Plugin 'sukima/xmledit'
" Plugin 'othree/xml.vim'
" Plugin 'othree/html5.vim'
" Plugin 'Valloric/MatchTagAlways'
" Plugin 'vim-scripts/XML-Folding'

" For CSS&CSS3 and SDLs which generate css
" Plugin 'hail2u/vim-css3-syntax' "an option
" Plugin 'wavded/vim-stylus'
" Plugin 'vitalk/vim-lesscss'
" Plugin 'tpope/vim-haml'

"java, ref http://www.lucianofiandesio.com/vim-configuration-for-happy-java-coding
"Plugin 'adragomir/javacomplete'

"Ruby 
"Plugin 'vim-ruby/vim-ruby'

"Haskell 
Plugin 'dag/vim2hs'

"R language
Plugin 'jcfaria/Vim-R-plugin'

"Erlang, ref http://blog.erlware.org/2013/09/09/how-to-use-vim-for-erlang-development/
Plugin 'jimenezrick/vimerl'

"Markdown 
" Plugin 'plasticboy/vim-markdown'

"sql
Plugin 'exu/pgsql.vim'
"Plugin 'ivalkeen/vim-simpledb'
"Plugin 'SQLComplete.vim'

"misc
Plugin 'Puppet-Syntax-Highlighting'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'ekalinin/Dockerfile.vim'



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" customize vim
filetype on " enable file type detection
filetype plugin indent on " enable loading the plugin for appropriate file type 
syntax on 
"set title

set history=2048 " lines of Ex-mode commands, search history
set undofile
set undoreload=1000

" for search
set showmatch " show matching paren
set incsearch " BUT do highlight where the so far typed pattern matches
set hlsearch 
nnoremap <leader><space> :nohlsearch<CR>
set ignorecase
set smartcase

set autoindent
set smartindent
set tabstop=4 " tab spacing (settings below are just to unify it)
set softtabstop=4 " unify
set shiftwidth=4 " unify
set expandtab " real tabs please!
set smarttab " use tabs at the start of a line, spaces elsewhere

set number
set wrap "wrap lines, nowarp if not
set showcmd
set showmode 
set cursorline  

set background=dark 
"colorscheme molokai
colorscheme desert 

set fenc=utf8
set fencs=utf8,gbk,gb18030,gb2312,ascii,big5,utf16,utf32

" Remember the position of files, jump to it when reopen files.
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Configure ultisnip
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" For delimitMate
let b:delimitMate_expand_cr = 2 
let b:delimitMate_expand_space=1
let b:delimitMateBackspace=1

" For python-mode
"let g:pymode_lint = 0
"let g:pymode_rope_completion = 0
"let g:pymode_rope = 0 
"let g:pymode_options_max_line_length =100 

" Syntastic settings
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_auto_jump = 0
let g:syntastic_error_symbol = 'E'
let g:syntastic_style_error_symbol = 'S'
let g:syntastic_warning_symbol = 'W'
let g:syntastic_style_warning_symbol = 'S'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 3
let g:syntastic_enable_signs = 1
let g:syntastic_stl_format = '[%E{%feE%e}%B{ }%W{%fwW%w}]'
" nmap <silent> <leader>y :SyntasticCheck<cr>"
" For python
let g:syntastic_python_python_exec = 'python3'
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = "--ignore=E501,W391,F401,E302,E226,E228,E125,E225,E128,W293,E126,F812,E222,E203,E402,E731"
"let g:syntastic_python_flake8_args = "--max-line-length=100"
"let g:syntastic_python_pylint_args = "--disable=C0301,C0111,R0913,R0904,C0330,C0103,W0232,R0903"
"let g:syntastic_python_pylint_args = "--max-line-length=100"
" For Javascript
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_javascript_jshint_conf = "~/.vim/jshint.json"
" For html
let g:syntastic_html_checkers=['jshint']
let g:syntastic_javascript_jshint_conf = "~/.vim/jshint.json"
" For CPP
let g:syntastic_cpp_checkers = ['gcc']
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler = "g++"
let g:syntastic_cpp_compiler_options = ' -std=c++11'
" For C
let g:syntastic_c_checkers = ['gcc']
let g:syntastic_c_check_header = 1
let g:syntastic_c_compiler = 'gcc'
let g:syntastic_c_compiler_options = ' -std=c99'

" YouCompleteMe settings
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_log_level = 'info'
let g:ycm_server_keep_logfiles = 0

" colorv setting
let g:colorv_no_global_map=1

" netrw settings
let g:netrw_liststyle=3

" Json setting
let g:vim_json_syntax_conceal = 0

if has('statusline')
    set laststatus=2
    set statusline=%<%f\  " Filename
    set statusline+=%w%h%m%r " Options
    set statusline+=\ %{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y] " filetype
    set statusline+=\ [%{getcwd()}] " current dir
    "set statusline+=%#warningmsg#
    set statusline+=\ %{SyntasticStatuslineFlag()}
    "set statusline+=%*
    set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif


" For auto inserting date when newing python file
fun PythonNewfileTemplate()
    if line("$") > 8
        let l = 8
    else
        let l = line("$")
    endif
"   exe "1," . l . "g/Filename:##filename##/s/Filename:##filename##/Filename: " . expand("%:t:r")
    exe "1," . l . "g/Create:##create##/s/Create:##create##/Create: " . strftime("%Y-%m-%d")
endfun

" For auto templating rst file
fun RSTNewfileTemplate()
    if line("$") > 20
        let l = 20
    else
        let l = line("$")
    endif
    exe "1," . l . "g/:# create:##createddate##/s/:create:##createddate##/:# create: " . strftime("%Y-%m-%d")
endfun


if has("autocmd")
" for python
"    autocmd FileType python let g:pydiction_location='/home/wgwang/.vim/bundle/pydiction/complete-dict'
"    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    au bufnewfile *.py :0r ~/.vim/templates/python.py 
    au bufnewfile *.py call PythonNewfileTemplate()
    au FileType python setlocal wrap

" for c
    au FileType c,h let g:ycm_global_ycm_extra_conf ='~/.vim/ycm_extra_conf/c.py'
    au FileType c,h setlocal foldmethod=syntax

" for c++
    au FileType cpp,hpp let g:ycm_global_ycm_extra_conf ='~/.vim/ycm_extra_conf/cpp.py'
    au FileType cpp,hpp setlocal foldmethod=syntax

" for go programming language 
    au FileType go setlocal foldmethod=syntax
    au FileType go color desertEx

" For Javascript
    au FileType javascript let g:ycm_add_preview_to_completeopt=0
    au FileType javascript let g:ycm_confirm_extra_conf=0
    au FileType javascript setlocal completeopt-=preview
    au FileType javascript let b:javascript_fold=1
    au FileType javascript call JavaScriptFold()

" for markdown
"    au FileType markdown let g:instant_markdown_slow = 1
"    au FileType markdown let g:instant_markdown_autostart = 0

" For html


" For xml
    au FileType xml let b:loaded_delimitMate = 1
    au FileType xml let loaded_xmledit = 1


" For reStructuredText(rst)
    au bufnewfile *.rst :0r ~/.vim/templates/rst.rst
    au bufnewfile *.rst call RSTNewfileTemplate()
    au FileType rst setlocal  tabstop=3 softtabstop=3 shiftwidth=3 

endif


map <C-n> :bnext<CR>
imap <f2> <ESC><CR>
imap zz <ESC>

