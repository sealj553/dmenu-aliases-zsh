# dmenu-aliases-zsh
Simple script to use `.zsh_aliases` with dmenu as a program launcher

Change the `dmenu_params` to whatever. This is set up to use dmenu2, so the options won't work on stock dmenu.

Created because there's no dmenu alias scripts for zsh and printing all commands from zsh is way faster than using compgen. It's also less convoluted than `dmenu-run-aliases`.

#requires:
* dmenu2
* `~/.zsh_aliases` (or any file with aliases, change `aliases_file`)

#features
* alias appears first, but original can be chosen if there are duplicate names
* you are able to see what the alias is when choosing it
* doesn't save to cache file like "dmenu-recent-aliases" and is much faster

#how it works
* parses aliases and sorts
* gets list of zsh commands and sorts
* joins streams with aliases first and passes to dmenu
* first word of output removed, the rest is executed

#that unsightly sed line:
* remove all lines starting with #
* remove all lines that are blank
* remove the word "alias" from each line
* remove the first "=" on each line
* alias cmd1="cmd2"  ->  cmd1 "cmd2"
