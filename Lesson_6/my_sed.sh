#!/bin/bash
# функция помощника
usage() {
     cat << EOF
This is sed wrapper
Usage: $0 [file(s)] [sed option(s)]
Examples:
    $0 --help
    $0 -w file.txt
EOF
    echo  "-w  --write - запись изменений в файл"
}
# рассовываем все по массивам
while [[ $# > 0 ]] ; do
	[[ -f $1 ]] && FILES+=($1) && shift && continue
    case $1 in
        --help)
	    usage
	    exit 0
        ;;
        -w|--write)
	    ARGS+=($1)
	    shift
	;;
	-*|--*)
            BASKET+=($1)
            shift
        ;;
    esac
done
# обрабатываем ошибки
(( ${#FILES[@]} == 0 )) && echo "Files not specified" && exit 1
(( ${#BASKET[@]} != 0 )) && echo "Wrong argument" && exit 2
# выполнение функции скрипта
    if [[ ${ARGS[@]} ==  -w ]] || [[ ${ARGS[@]} ==  --write ]] 
	then
            for i in ${FILES[@]}  ; do sed -i '/^$/d' $i && sed -i 's/[a-z]/\U&/g' $i ; done
        else
	    for i in ${FILES[@]}  ; do sed -e '/^$/d; s/[a-z]/\U&/g' $i && >> garbage.txt &&  cat garbage.txt && rm garbage.txt ; done
    fi   
