# Para baixar isso aqui execute o sequinte
# curl -Lks https://raw.githubusercontent.com/badarot/dotfiles/master/.bin/dotfiles-download.sh | /bin/bash

git clone --bare https://github.com/badarot/dotfiles.git $HOME/.dotfiles
function dotfiles {
    /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
mkdir -p .dotfiles.bk
dotfiles checkout
if [ $? = 0 ]; then
    echo "Checked out config.";
else
    echo "Backing up pre-existing dot files.";
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles.bk/{}
fi;
dotfiles checkout
dotfiles config status.showUntrackedFiles no
