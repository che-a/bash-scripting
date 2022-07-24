#!/usr/bin/env bash

# Определение типа ОС: MS-Windows/Linux/MacOS
# вывод будет одним из таких: Linux MSWin macOS

if type -t wevtutil &> /dev/null
then
    OS=MSWin
elif type -t scutil &> /dev/null
then
    OS=macOS
else
    OS=`uname -o`
fi

echo $OS
