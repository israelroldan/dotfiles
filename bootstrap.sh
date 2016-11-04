#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
    cp zsh-history-substring-search.zsh /usr/local/share/zsh/site-functions/zsh-history-substring-search.sh
    chmod +x /usr/local/share/zsh/site-functions/zsh-history-substring-search.sh
	rsync --exclude ".git/" \
		--exclude ".idea/" \
		--exclude ".DS_Store" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude ".gitconfig" \
		--exclude "LICENSE" \
		-avh --no-perms . ~;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;