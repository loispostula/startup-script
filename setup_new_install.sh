# return 0 if program version is equal or greater than check version
check_version()
{
        local version=$1 check=$2
        local winner=$(echo -e "$version\n$check" | sed '/^$/d' | sort -nr | head -1)
        [[ "$winner" = "$version" ]] && return 0
            return 1
}

check_install()
{
        local package=$1
        if hash $1 2</dev/null; then
            echo "$1 already installed";
        else
            eval "zypper --non-interactive --no-gpg-checks --quiet install --auto-agree-with-licenses $1";
            echo -ne 'Installing $1... [DONE]\n';
        fi

}

#ZSH installation
check_install zsh;

ZSH_VERSION_STRING="$(zsh --version)"
IFS=' ' read -a ZSH_VERSION_ARRAY <<< "$ZSH_VERSION_STRING"
ZSH_VERSION=${ZSH_VERSION_ARRAY[1]}

if check_version $ZSH_VERSION "4.3.9"  ; then
        echo "The correct version of zsh is installed";
else
        echo "it would appear the zsh version is not correct, please update it";
        exit;
fi

#Git installation
check_install git;
#Rbenv installation
eval "sudo -u lpostula git clone https://github.com/sstephenson/rbenv.git ~/.rbenv";
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /home/lpostula/.zshrc;
echo 'eval "$(rbenv init -)"' >> /home/lpostula/.zshrc;
echo "Installing Rbenv... [DONE]";
#Homesick installation
eval "gem install homesick";
#Cloning castle
eval "sudo -u lpostula homeshick clone loispostula/dotfiles":
#Installing Vundle for git
eval "sudo -u lpostula git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim";
#installing Vundle plugin
eval "sudo -u lpostula vim +PluginInstall +qall"
#Installing tmux
check_install tmux;
#Installing python2
check_install python2
#Installing pip2
eval "wget https://bootstrap.pypa.io/get-pip.py";
eval "python2 get-pip.py";
#Installing weather_ma_jig
eval "git clone https://github.com/loispostula/weather-ma-jig.git /home/lpostula/wmj"
eval "cd /home/lpostula/wmj";
eval "pip2 install -r requirements.txt";
eval "python2 setup.py install";


#invert scrollbar
echo "Dont' forget to exexute this to change wheel direction:";
echo "pointer = 1 2 3 5 4 7 6 8 9 10 11 12 > ~/.Xmodmap && xmodmap .Xmodmap";
#to revert this simply use
#echo "pointer = 1 2 3 4 5 6 7 8 9 10 11 12" > ~/.Xmodmap && xmodmap ~/.Xmodmap
