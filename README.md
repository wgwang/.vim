
# Introduction

VIM is a powerful editor with excellent plugins support for Linux(Unix), Apple Mac and MS Windows. But the naive  vim is trivial to some degree. For more productivity in programming, it needs careful configuration. And the procedure is time-consuming and tedious. 

I have created this project to share my configuration of vim. Feel free to fork it as your need.

Sharing is significant spirit of hacker world.

# Install instruction

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

## Mac

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



