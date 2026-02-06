#!/bin/bash

mode=$(tmux display-message -p '#{client_key_table}')

case "$mode" in
  root)
    echo "normal | C-a:pane C-t:tab C-s:scroll C-z:session M-r:renametab | "
    ;;
  pane)
    echo "pane | h/l/j/k:move p:prev n:new-h d:new-v x:kill z:zoom f:frames w:float e:menu r:rename | "
    ;;
  tab)
    echo "tab | h/l/j/k:move n:new x:kill r:rename s:sync b:break ]/[ :break 1-9:goto a:prev | "
    ;;
  scroll)
    echo "scroll | e:edit s:search G:bottom j/k:up/down C-f/C-b:page d/u:halfpage C-/:search-mode | "
    ;;
  search)
    echo "search | j/k:up/down C-f/C-b:page d/u:halfpage n/p:next/prev c:casesens w:wrap o:wholeword | "
    ;;
  session)
    echo "session | d:detach w:manager | "
    ;;
  renametab)
    echo "renametab | C-c/Escape:cancel | "
    ;;
  locked)
    echo "locked | C-g:unlock | "
    ;;
  resize)
    echo "resize | h:left+ j:down+ k:up+ l:right+ H:left- J:down- K:up- L:right- =:inc - :dec | "
    ;;
  *)
    echo "unknown | "
    ;;
esac
