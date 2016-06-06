# OH MY CYGWIN

Looking for a real Terminal for Windows?
Relax you just found it. This sets up a working ZSH Shell powered by [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) and the [apt-cyg](https://github.com/transcode-open/apt-cyg/) package manager.

I took care of installing and configuring some packages so that you have vim, git and ssh~~ just one keystroke away.

**About this fork**
>I was working on a Raspberry python project, missed oh-my-zsh in cygwin and got sidetracked, stumbled upon the initial repo , missed the "deprecated" warning, was "just gonna" replace the apt-cyg url, didn't have wget installed in cygwin, forgot about my actual project and here we are, apparently.

- Now uses git instead of wget to get apt-cyg. 
- Add optional .zshrc config.
- Added some progress output.
- Check if packages exists **oh-my-zsh**, **vim**, **curl** and **zsh**.
- And probably something I forgot... 


# Setup

Install [cygwin](http://www.cygwin.com/) with ~~wget~~ **git** (check ~~wget~~ **git**  in the installation process) then start cygwin and execute 

~~`sh wget --no-check-certificate https://raw.github.com/haithembelhaj/oh-my-cygwin/master/oh-my-cygwin.sh -O - | sh`~~

``` sh
git clone "https://github.com/gudorian/oh-my-cygwin" "~/.oh-my-cygwin" && sh "~/.oh-my-cygwin/oh-my-cygwin.sh"
```

After installation you'll be prompted to use a customized .zshrc config, hit **Y** if you want to use it or **N** if not, then hit *(well, gently, don't actually hit your keyboard, keyboard violence is bad!)* **ENTER**.

Et Voila!
Your windows Terminal will look like this

![oh-my](https://coderwall-assets-0.s3.amazonaws.com/uploads/picture/file/1297/oh-my-cygwin.PNG "OH-MY-OH-MY")

Or like this if you use included .zshrc config

![oh-my](https://ologiskt.com/application/files/8414/6524/3741/oh-my-cygwin.jpg "OH-MY-OH-MY")