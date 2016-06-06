#!/bin/bash
set -e

# cd home
cd ~

# Check bash version
version=$(bash -version 2>&1 | awk -F '"' '/version/ {print $2}')
echo version "$version"
if [[ "$version" > "4.1" ]]; then
    echo "Bash version is 4.2 or higher, you can use apt-cyg."
else         
    echo "Bash is older than 4.2, you need to update bash from cygwin installer to use apt-cyg"
    while true; do
    read -p" Continue anyway?" yn
    case $yn in
        [Yy]* ) echo "Continues..."
				break;;
        [Nn]* ) echo "Aborted!"
				exit;;
        * ) echo "Please answer yes[Y/y] or no[N/n].";;
    esac
done
fi

echo "Creating tmp dir for apt-cyg"

SIMPLE_BACKUP_SUFFIX=".orig"
APT_CYG="$(mktemp /tmp/apt-cyg.XXXXXXXX)"

echo "Created tmp."
echo "Remove actual tmp directory for apt-cyg, (git clone workaround for already exist)."
rm -rf ${APT_CYG} # Lazy but working implementation

echo "Cloning apt-cyg from github."
# install apt-cyg
git clone "https://github.com/transcode-open/apt-cyg" "${APT_CYG}" --progress 
chmod +x "${APT_CYG}/apt-cyg"

# install some stuff like vim and git
echo "install zsh, vim and curl"

# Install zsh
if ! which zsh >/dev/null; then
	echo "Installing zsh!"
	"${APT_CYG}/apt-cyg" install zsh
else
	echo "zsh already installed, skipping!"
fi

# Install vim
if ! which vim >/dev/null; then
	echo "Installing vim!"
	"${APT_CYG}/apt-cyg" install vim
else
	echo "vim already installed, skipping!"
fi

# Install curl
if ! which curl >/dev/null; then
	echo "Installing curl!"
	"${APT_CYG}/apt-cyg" install curl
else
	echo "curl already installed, skipping!"
fi

if [ ! -d ~/.oh-my-zsh ]; then
	# install OH MY ZSH
	echo "Cloning oh-my-zsh from github."
	git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else
	echo "~/.oh-my-zsh already exists, skipping!"
fi

echo "Installing zsh"

# Create initial /etc/zshenv
[[ ! -e /etc/zshenv ]] && echo export PATH=/usr/bin:\$PATH > /etc/zshenv

install --backup ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

echo "Configuring vim"

#setting up vim
VIMRC_EXAMPLE=`find /usr/share/vim -type f -name vimrc_example.vim | head -n 1`
if [ ! -f ~/.vimrc ] && [ -n "${VIMRC_EXAMPLE}" ]
then
  install "${VIMRC_EXAMPLE}" ~/.vimrc
fi

echo "Install apt-cyg"

# install apt-cyg
install --backup "${APT_CYG}/apt-cyg" /bin/apt-cyg

# Install curl
if ! which apt-cyg >/dev/null; then
	"${APT_CYG}/apt-cyg" install curl
else
	echo "apt-cyg already installed, skipping!"
fi

echo "Set zsh as default shell"

# setting up zsh as default
sed -i "s/$USER\:\/bin\/bash/$USER\:\/bin\/zsh/g" /etc/passwd

while true; do
    read -p "Use included .zshrc config?" yn
    case $yn in
        [Yy]* ) echo "Backuping .zshrc and symlinking included config."
				mv ~/.zshrc ~/.zshrc.backup 
				ln -s ~/.oh-my-cygwin/config/.zshrc ~/.zshrc; 
				break;;
        [Nn]* ) echo "Keeping original config.";break;;
        * ) echo "Please answer yes[Y/y] or no[N/n].";;
    esac
done

echo "Done, starting zsh shell!"

# et voila just start it
/usr/bin/env zsh
