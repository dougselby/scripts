#!/bin/bash

if [[ -f $1 ]]; then
 while read  line; do
  if echo $line | grep -qs '{'; then
   tab_terminal="gnome-terminal"
   prompt_command='echo -ne "\033]0;SOME TITLE HERE\007"'
   declare -a tab_array=($(eval echo "$line")) 
   for tab in "${tab_array[@]}"; do
    tab_terminal="${tab_terminal} --tab -e 'sh -c \"sshpass -f ~/.mypass  ssh -x ${tab}  \"'"
   done 
   #echo "$tab_terminal"
   export  PROMPT_COMMAND=${prompt_command}
   eval $tab_terminal
  else
   gnome-terminal --window -e "sh -c \"sshpass -f ~/.mypass  ssh -x ${line} \""
  fi
 done < $1
# for server in $(cat $1); do gnome-terminal --window -e "sh -c \"sshpass -f ~/.mypass  ssh -x ${server}\""; done
else
 echo "must be a file"
fi
