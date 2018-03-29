#!/bin/zsh

dmenu_params="dmenu -q -p '>' -s 0 -nb '#000000' -nf '#ffffff' -fn 'Tamzen-12'"
aliases_file=~/.zsh_aliases

#parse and sort aliases file, sort command list, prepend aliases to commands, pass to dmenu
cmd=$({cat $aliases_file | sed '/^#/ d;/^$/d;s/^alias\s//g;s/=/ /' | sort & print -rl ${(k)commands} | sort;} | eval "$dmenu_params")

#if the second word starts with " it is assumed to be an alias - remove first word and remove all "s
if [ "$(print $cmd | awk '{print $2}' | head -c 1)" = "\"" ]; then
    cmd=$(print $cmd | cut -d' ' -f2- | tr -d "\"") 
fi
eval "$cmd"

# that unsightly sed line:
#* remove all lines starting with #
#* remove all lines that are blank
#* remove the word "alias" from each line
#* remove the first "=" on each line
#* alias cmd1="cmd2"  ->  cmd1 "cmd2"

