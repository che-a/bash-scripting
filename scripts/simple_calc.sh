#!/usr/bin/env bash

while :
do
    read a opr b
    if [[ $a == 'exit' ]]
    then
        echo "bye"
        exit  
    elif [[ $opr == '+' || $opr == '-' || $opr == '*' || $opr == '/' || $opr == '%' || $opr == '**' ]]
    then
        let "result = a $opr b"
        echo $result
    else
        echo "error"
        exit 1
    fi
done
