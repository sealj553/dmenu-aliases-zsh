#!/bin/zsh

dmenu_params="dmenu -q -p '>' -s 0 -nb '#000000' -nf '#ffffff' -fn 'Tamzen-12'"
aliases_file=~/.zsh_aliases

#parse and sort aliases file, sort command list, prepend aliases to commands, pass to dmenu
cmd=$({cat $aliases_file | sed '/^#/ d;/^$/d;s/^alias\s//g;s/=/ /' | sort & print -rl ${(k)commands} | sort;} | eval "$dmenu_params")
if [ ! -z $cmd ]; then
    #if the second word starts with " it is assumed to be an alias - remove first word and remove all "s
    if [ "$(print $cmd | awk '{print $2}' | head -c 1)" = "\"" ]; then
        cmd=$(print $cmd | cut -d' ' -f2- | tr -d "\"") 
    fi
    eval "$cmd"
fi

#requires:
#  dmenu2
#  ~/.zsh_aliases

#features
#alias appears first, but original can be chosen if there are duplicate names
#you are able to see what the alias is when choosing it
#doesn't save to cache file like "dmenu-recent-aliases" and is much faster

#how it works
#parses aliases and sorts
#gets list of zsh commands and sorts
#joins streams with aliases first and passes to dmenu
#first word of output removed, the rest is executed

#that unsightly sed line:
#  remove all lines starting with #
#  remove all lines that are blank
#  remove the word "alias" from each line
#  remove the first "=" on each line
#alias cmd1="cmd2"  ->  cmd1 "cmd2"
