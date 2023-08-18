#!/usr/bin/env bash

# Поиск дубликатов файлов
#

md5sum *.jpg | cut -c1-32 | sort | uniq -c | sort -nr | grep -v "      1"
