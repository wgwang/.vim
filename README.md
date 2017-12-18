
# Introduction

VIM is a powerful editor with excellent plugins support for Linux(Unix), Apple Mac and MS Windows. But the naive  vim is trivial to some degree. For more productivity in programming, it needs careful configuration. And the procedure is time-consuming and tedious.

I have created this project to share my configuration of vim. Feel free to fork it as your need.

Sharing is significant spirit of hacker world.


#dependencies

## pylint and pylint-django
for checking python3 and django. syntastic will use them

## YouCompleteMe
YouCompleteMe depends on clang, boost etc.

edit `.vim/ycm_extra_conf/cpp.py` for the include path of g++/clang++ etc

# Install instruction

The vim version is required by YouCompleteMe. See as YouCompleteMe


## Linux / Unix

* fork this repository to the home directory
```bash
    git clone https://github.com/wgwang/.vim
```

* link to vimrc and change dir to .vim
```bash
    cd $HOME
    ln -s .vim/vimrc .vimrc
    cd .vim
```

* install vundle
```bash
    mkdir bundle
    cd bundle
    git clone https://github.com/gmarik/vundle.git
```

*  install plugins via vundle
```bash
    vim +PluginInstall +qall
```

Or launch `vim` and run `:PluginInstall`


* compile YouCompleteMe

```bash
    cd bundle/YouCompleteMe
    python3 install.py --clang-completer
```

Building YCM requires cmake 2.8 or higher.
If need C# support, adding parameter --omnisharp-completer


## Mac

* upgrade vim using brew

Make sure your vim has python3 support, because YouCompleteMe requires it.

* Other steps are the same as Linux


## Windows



# Conflict resolution

If you get the error messages as following:
```
    Mapping already in use: "<LocalLeader>is", mode "n"
    Mapping already in use: "<LocalLeader>is", mode "i"
```
you could edit the file `bundle/a.vim/plugin/a.vim` and commente the following lines:
```
imap <Leader>is <ESC>:IHS<CR>:A<CR>
nmap <Leader>is :IHS<CR>:A<CR>
```




# golang (the go programming language)

Make sure you have properly installed gocode before using vim for golang.

```bash
    go get github.com/nsf/gocode
    gocode --version
```

If there is any error when running command above, please check the  envirement for golang.
Properly setting GOROOT, GOPATH and PATH=$GOROOT/bin:$GOPATH/bin:$PATH is needed.


cd $HOME/prometheus
