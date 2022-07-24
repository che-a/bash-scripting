#!/usr/bin/env bash

# Вычисление наибольшего общего делителя (НОД, greatest common divisor, GCD) 

function gcd ()
{
    if [[ $1 -eq $2 ]]
    then
        echo $1
    else
        if [[ $1 -gt $2 ]]
        then
            let "arg1 = $1 - $2"
            gcd $arg1 $2
        else
            let "arg2 = $2 - $1"
            gcd $1 $arg2
        fi
    fi
}


while :
do
    read a b
    if [[ -z $a ]]
    then
        echo "bye"
        exit
    else
        echo "GCD is "`gcd $a $b`
    fi
done
