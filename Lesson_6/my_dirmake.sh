#!/bin/bash

usage() {
     cat << EOF
This is directory make wrapper
Usage: $0  [file(s)] [ option(s)]
Examples:
    $0 --help
    $0 -d /tmp/task_3 file.txt file.sh
EOF
    echo  "Укажите после -d путь по которому следует создать файлы, указанные после пути"
}
while [[ $# > 0 ]] ; do
    case $1 in
        --help)
	    usage
	    exit 0
        ;;
       -d)
	  ARGS+=($1)
	  shift
	  DIRECT+=($1)
	  shift
       ;;
       -*|--*|/*)
          BASKET+=($1)
          shift
      ;;
       *)
         TEXT+=($1)
         shift 
      ;;
    esac
done

(( ${#TEXT[@]} == 0 )) && echo "Files not specified" && exit 1
(( ${#BASKET[@]} != 0 )) && echo "Wrong argument" && exit 2
(( ${#DIRECT[@]} != 1 )) && echo "Use only one path!" && exit 3

arg=${DIRECT[0]}
if [ -d .$arg ]
   then
       echo ''
  else
      mkdir -p .$arg
fi

cd .$arg


for i in ${TEXT[@]}
     do
     if [ -e $i ]
         then
             echo "File $i is specified"
         else
             touch $i
      fi
 done

 find ./ -name *.sh -exec chmod ugo+x '{}' \; 
