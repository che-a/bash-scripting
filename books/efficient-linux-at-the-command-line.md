```
Барретт Дэниел Джей  
Linux. Командная строка. Лучшие практики
2023
```

### Содержание
+ [Часть 1. Основные понятия](#part1)
  - [Глава 1. Объединение команд](#chapter1)
    - [Каналы](#channels)
    - [`wc`](#wc)
    - [`head`](#head)
    - [`cut`](#cut)
    - [`grep`](#grep)
    - [`sort`](#sort)
    - [`uniq`](#uniq)
    - [`tr`](#tr)
  - [Глава 2. Командная оболочка](#chapter2)
    - [Сопоставление с шаблоном (подстановка)](#globbing)
    - [Вычисление переменных](#vars)
    - [Псевнодимы](#alias)
    - [Перенаправление ввода и вывода](#redirection)
    - [Отключение вычисления с помощью кавычек и экранирования](#disable_eval)
    - [Расположение исполняемых программ](#path)
  - [Глава 3. Повторный запуск команд](#chapter3)
    - [История команд](#history)
+ [Часть 2. Продвинутые навыки](#part2)
  - [Глава 5. ](#chapter5)
    - [`date`](#date)
    - [`seq`](#seq)
    - [Расширение команд с помощью фигурных скобок](#curly_brackets)
    - [`find`](#find)
    - [`yes`](#yes)
    - [`grep`. Более глубокий взгляд](#grep_ext)
+ [Часть 3. Дополнительные плюсы](#part3)


# Часть 1. Основные понятия <a name="part1"></a>
## Глава 1. Объединение команд <a name="chapter1"></a>
### Каналы <a name="channels"></a>
**Канал (|)** — это механизм межпроцессного взаимодействия в `Unix`, который перенаправляет стандартный вывод одной программы на стандартный вход другой программы.  
Командная оболочка обрабатывает данные в каналах: она незаметно перенаправляет стандартные потоки `stdin` и `stdout`, поэтому исполняемые программы не знают, что они взаимодействуют друг с другом.   
**Конвейер (pipeline)** — командная строка, содержащая каналы.  Например, `ls -l /bin | less`.  

Ниже представлены файлы для демонстрации действия команд и конвейеров.    
`animals.txt` (колонки разделены символом табуляции):  
```
python	Programming Python	2010	Lutz, Mark
snail	SSH, The Secure Shell	2005	Barrett, Daniel
alpaca	Intermediate Perl	2012	Schwartz, Randal
robin	MySQL High Availability	2014	Bell, Charles
horse	Linux in a Nutshell	2009	Siever, Ellen
donkey	Cisco IOS in a Nutshell	2005	Boney, James
oryx	Writing Word Macros	1999	Roman, Steven
```

`essay.txt`:  
```
I'm here today to tell you that I
really love the Perl programming language, which is
one of my favorites in the world. For years, I liked
languages such as Perl, Python, PHP, and Ruby
equally, but now I'm pretty settled on my favorite.
```

### `wc` <a name="wc"></a>
Команда `wc` выводит количество строк, слов и символов в файле.  
```sh
wc animals.txt           # 7 строк, 51 слово, 379 символов (с учетом символов новой строки)

#  7  51 325 animals.txt

wc -l animals.txt        # Количество строк
# 7 animals.txt

wc -w animals.txt        # Количество слов
# 51 animals.txt

wc -c animals.txt        # Количество символов
# 325 animals.txt
```
```sh
# Подсчет количества файлов в текущем каталоге
ls -1 | wc -l
```
```sh
wc animals.txt | wc -w | wc
#      1       1       2
```
### `head` <a name="head"></a>
Команда `head` выводит первые строки файла. По умолчанию выводятся первые 10 строк. Эта команда работает быстро и эффективно
даже с очень большими файлами, поскольку ей не нужно считывать весь файл.  
```sh
# Подсчет кол-ва строк в первых трех строках файла
head -n3 animals.txt | wc -w
# 20
```

### `cut` <a name="cut"></a> 
Команда `cut` выводит одну или несколько колонок из файла и поддерживает два способа определения того, что считать колонкой:  
— разделение по полям (параметр `-f` ), когда входные данные состоят из строк(полей), каждая из которых разделена одним символом табуляции (по умолчанию) либо символом-разделителем (параметр `-d`).  
— по положению символа в строке (параметр `-c`).  

```sh
cut -f2 animals.txt | head -n3
# Programming Python
# SSH, The Secure Shell
# Intermediate Perl

cut -f1,3 animals.txt | head -n3
# python  2010
# snail   2005
# alpaca  2012

cut -f2-4 animals.txt | head -n3
# Programming Python      2010	Lutz, Mark
# SSH, The Secure Shell	  2005	Barrett, Daniel
# Intermediate Perl       2012	Schwartz, Randal

cut -c1-3 animals.txt | head -n3
# pyt
# sna
# alp

cut -f4 animals.txt | head -n3 | cut -d, -f1
# Lutz
# Barrett
# Schwartz
```

### `grep` <a name="grep"></a>
Команда `grep` печатает строки, соответствующие заданному шаблону.  
```sh
grep Nutshell animals.txt 
#  horse	Linux in a Nutshell	2009	Siever, Ellen
#  donkey	Cisco IOS in a Nutshell	2005	Boney, James

grep -v Nutshell animals.txt	# Строки, не соответствующие шаблону
#   python	Programming Python	2010	Lutz, Mark
#   snail	SSH, The Secure Shell	2005	Barrett, Daniel
#   alpaca	Intermediate Perl	2012	Schwartz, Randal
#   robin	MySQL High Availability	2014	Bell, Charles
#   oryx	Writing Word Macros	1999	Roman, Steven

grep -w a animals.txt  # Совпадение обязательно с целым словом
# horse		Linux in a Nutshell	2009	Siever, Ellen
# donkey	Cisco IOS in a Nutshell	2005	Boney, James

# Поиск без учета регистра
grep -i his animals.txt

# Печать строк, содержащих текст Perl, в файлах с расширением .txt
grep Perl *.txt
# animals.txt:alpaca	Intermediate Perl	2012	Schwartz, Randal
# essay.txt:really love the Perl programming language, which is
# essay.txt:languages such as Perl, Python, PHP, and Ruby

# Кол-во подкаталогов в каталоге /usr/lib
# ls -l помечает каталоги буквой d — эти строки и будем считать
ls -l /usr/lib | cut -c1 | grep d | wc -l
# 138
```

### `sort` <a name="sort"></a>
Команда `sort` сортирует строки файла в порядке возрастания (по умолчанию):  
```sh
sort animals.txt 
#   alpaca	Intermediate Perl	2012	Schwartz, Randal
#   donkey	Cisco IOS in a Nutshell	2005	Boney, James
#   horse	Linux in a Nutshell	2009	Siever, Ellen
#   oryx	Writing Word Macros	1999	Roman, Steven
#   python	Programming Python	2010	Lutz, Mark
#   robin	MySQL High Availability	2014	Bell, Charles
#   snail	SSH, The Secure Shell	2005	Barrett, Daniel

sort -r animals.txt	# Сортировка строк в порядке убывания
#   snail	SSH, The Secure Shell	2005	Barrett, Daniel
#   robin	MySQL High Availability	2014	Bell, Charles
#   python	Programming Python	2010	Lutz, Mark
#   oryx	Writing Word Macros	1999	Roman, Steven
#   horse	Linux in a Nutshell	2009	Siever, Ellen
#   donkey	Cisco IOS in a Nutshell	2005	Boney, James
#   alpaca	Intermediate Perl	2012	Schwartz, Randal

cat nums.txt 
# 0099
# 000200
# 100

sort nums.txt 	# Сортировка строк в алфавитном порядке
# 000200
# 0099
# 100

sort -n nums.txt # Сортировка строк в числовом порядке
# 0099
# 100
# 000200

# Год выхода самой новой книги в animals.txt
cut -f3 animals.txt | sort -nr | head -n1
# 2014
```

### `uniq` <a name="uniq"></a>
Команда `uniq` обнаруживает повторяющиеся соседние строки в файле. По умолчанию она удаляет повторы.  
```sh
cat letters.txt 
# A
# A
# A
# B
# B
# A
# C
# C
# C
# C

# uniq сократила первые три строки A до одной A, но оставила последнюю A на месте,
# потому что она не была соседней с первыми тремя.
uniq letters.txt 
# A
# B
# A
# C

# Подсчет кол-ва повторяющихся строк
uniq -c letters.txt 
#      3 A
#      2 B
#      1 A
#      4 C
```
Задача: есть разделенный табуляцией файл с итоговыми оценками студентов в диапазоне от A (лучшая) до F (худшая). Нужно вывести на экран оценку, которую получила большая часть студентов (если будет равное количество у нескольких оценок, в вывод попадет первая из них).  
```sh
cat grades
# C	Geraldine
# B	Carmine
# A	Kayla
# A	Sophia
# B	Haresh
# C	Liam
# B	Elijah
# B	Emma
# A	Olivia
# D	Noah
# F	Ava

cut -f1 grades | sort | uniq -c | sort -nr | head -n1 | cut -c9
# B
```
### `tr` <a name="tr"></a>
Команда `tr` заменяет или удалет символы.
```sh
echo 1 2 3
# 1 2 3

echo 1 2 3 | tr ' ' '\n'
# 1
# 2
# 3
```

## Глава 2. Командная оболочка <a name="chapter2"></a>
### Сопоставление с шаблоном (подстановка) <a name="globbing"></a>
Соспоставление с шаблонов (pattern matching) или подстановка (globbing) — это один из двух наиболее популярных приемов для повышенияя скорости работы в Linux.  
`*` — соответствует любой последовательности (за исключением начальной точки в именах файлов или каталогов) из любого числа символов в путях к файлам или каталогам.  
`?` — соответствует любому единичному символу (за исключением начальной точки в именах файлов или каталогов).  
`[]` — соответствует одному из символов набора.  

### Вычисление переменных <a name="vars"></a>
Предопределенные переменные традиционно записываются большими буквами.  
`printenv` — печать всех или конкретных переменных окружения.  
```sh
printenv HOME
# /home/kaban
printenv USER 
# kaban
```
Команда `echo` выводит на экран любые аргументы, которые ей передаются.
```sh
echo $HOME
# /home/kaban
echo My name is $USER and my files are in $HOME
# My name is kaban and my files are in /home/kaban
```
Значение `$HOME` вычисляет командная оболочка перед запуском команды `echo`. С точки зрения `echo` была набрана команда:
```sh
echo /home/kaban
```
### Псевнодимы <a name="alias"></a>
```sh
alias g=grep
alias ll="ls -l"

alias    # Вывод всех псевдонимов и их значений
alias g  # Вывод конкретного псевдонима

unalias g  # Удаление псевдонима

alias less="less -c"  # Определение псевдонима
less myfile           # Запуск псевдонима
\less myflie          # Запуск стандартной команды less
```

### Перенаправление ввода и вывода <a name="redirection"></a>
```sh
# Перенаправление стандартного вывода в файл вместо вывода его на экран.
grep Perl animals.txt > outfile    # Создание и перезапись файла
grep Perl animals.txt >> outfile   # Добавление записи в конец файла

wc animals.txt            # Чтение из файла
wc < animals.txt          # Чтение из перенаправленного ввода
wc < animals.txt > count  # Чтение из перенаправленного ввода и перенаправление вывода в файл

grep Perl < animals.txt | wc > count
cat count 
#      1       6      47
```
Команды Linux могут создавать более одного потока вывода. 
Стандартные потоки:
- `stdin`, стандартный поток ввода,
- `stdout`, стандартный поток вывода,
- `stderr`, стандартный поток ошибок.

```sh
# Перенаправление вывода ошибок в файл.
cp nonexistent.txt file.txt 2> errors
cat errors 
# cp: не удалось выполнить stat для 'nonexistent.txt': Нет такого файла или каталога

# Перенаправление обоих потоков `stdout` и `stderr` в один файл
echo This file exists > goodfile.txt
cat goodfile.txt nonexistent.txt &> all.output
cat all.output 
# This file exists
# cat: nonexistent.txt: Нет такого файла или каталога
```
### Отключение вычисления с помощью кавычек и экранирования <a name="disable_eval"></a>
Обычно оболочка использует пробелы в качестве разделителей между словами.  
Чтобы заставить оболочку рассматривать пробелы как часть имени файла, есть три варианта:
- одинарные кавычки `' '` сообщают командной оболочке, что каждый символ в командной строке следует обрабатывать буквально, даже если он имеет особое значение для оболочки.
- двойные кавычки `" "` указывают оболочке воспринимать все символы буквально, за исключением $ и некоторых других.
- обратная косая черта ` \ `, также называемая экранирующим символом, указывает оболочке буквально воспринимать символ, находящийся после неё.

```sh
echo \$HOME
# $HOME

echo "The value of \$HOME is $HOME"
# The value of $HOME is /home/kaban

of \$HOME is $HOME'
# The value of \$HOME is $HOME

echo "This message is \"sort of\" interesting"
# This message is "sort of" interesting

echo "This is very long message that needs to extend \
onto multiple lines"
# This is very long message that needs to extend onto multiple lines
```
### Расположение исполняемых программ <a name="path"></a>
`PATH` -- переменная, значение которой содержит список путей для поиска исполняемых программ.  
```sh
echo $PATH 
/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

echo $PATH | tr : "\n"
/usr/local/bin
/usr/bin
/bin
/usr/local/games
/usr/games
```

## Глава 3. Повторный запуск команд <a name="chapter3"></a>
### История команд <a name="history"></a>
```sh
history 5    # Показать последние 5 команд

history -c  # Очистить историю для текущего экземпляра оболочки
```
```sh
echo $HISTSIZE 
# 10000
HISTSIZE=-1    # Хранение неограниченного количества команд в истории

echo $HISTCONTROL 
# ignoreboth
HISTCONTROL=ignoredups  # Повторяющиеся команды не будут добавляться

# По завершении работы оболочки она записывает историю в файл
echo $HISTFILE
# /home/kaban/.bash_history  

# Переменная HISTFILESIZE определяет сколько строк итории записывается в файл
echo $HISTFILESIZE 
# 2000
```
```sh
!!	# (bang-bang)-- запуск предыдущей команды.
!grep	# Запуск последней команды grep
!1203	# Вызов команды на позиции 1203 в истории
!-3	# Вызов команды, которая была выполнена 3 шага назад
!-3:p	# Печать на экран команды, которая была выполнена 3 шага назад и добавление её в историю команд
```
Безопасное удаление файлов.  
```sh
# Проверка
ls *.txt

# Удаление
rm !$    # !$ -- последнее слово, которое было введено в пердыдущей команде.
```

# Часть 2. Продвинутые навыки <a name="part2"></a>
## Глава 5. <a name="chapter5"></a>
### `date` <a name="date"></a>
Команда `date` выводит текущую дату и/или время в различных форматах.
```sh
date
# Пт 25 авг 2023 10:00:52 MSK

date +%Y-%m-%d
# 2023-08-25

date +%H:%M:%S
# 10:03:18

date +"Невероятно, но сегодня уже %A!"
# Невероятно, но сегодня уже Пятница!
```
### `seq` <a name="seq"></a>
Команда `seq` печатает последовательности чисел из диапазона.
```sh
seq 1 3
# 1
# 2
# 3

# Использование шага приращения значений
seq 1 2 6
# 1
# 3
# 5

seq 3 -1 0
# 3
# 2
# 1
# 0

seq 1.1 0.1 1.5
# 1,1
# 1,2
# 1,3
# 1,4
# 1,5

# Замена разделителя по умолчанию другим символом
seq -s/ 1 5
# 1/2/3/4/5

# Приведение всех значений к одинаковой ширине при помощи добавления ведущих нулей.
seq -w 8 10
# 08
# 09
# 10
```
### Расширение команд с помощью фигурных скобок <a name="curly_brackets"></a>
Командная оболочка предоставляет собственный способ вывода последовательности чисел, известный как расширение фигурных скобок (brace expansion).  
```sh
echo {1..10}
# 1 2 3 4 5 6 7 8 9 10

echo {10..1}
# 10 9 8 7 6 5 4 3 2 1

echo {01..10}
# 01 02 03 04 05 06 07 08 09 10
```
В более общем случае выражение оболочки `{x..y..z}` генерирует значения от `x` до `y` с шагом `z`:
```sh
echo {1..1000..100}
# 1 101 201 301 401 501 601 701 801 901

echo {1000..1..100}
# 1000 900 800 700 600 500 400 300 200 100

echo {01..1000..100}
# 0001 0101 0201 0301 0401 0501 0601 0701 0801 0901

echo {A..Z}
# A B C D E F G H I J K L M N O P Q R S T U V W X Y Z

echo {A..Z} | tr -d ' '
# ABCDEFGHIJKLMNOPQRSTUVWXYZ

echo {A..Z} | tr ' ' '\n'
# A
# B
# C
# ⋮
# Z
```
### `find` <a name="find"></a>
Команда `find` рекурсивно выводит список файлов в каталоге, спускаясь по подкаталогам и выводя полные пути. Результаты выводятся не в алфавитном порядке (при необходимости нужно использовать `sort` ):
```sh
find . -print
# .
# ./letters.txt
# ./nums.txt
# ./essay.txt
# ./grades.txt
# ./animals.txt

# Вывод только каталогов
find . -type d -print  

# Вывод только файлов
find . -type f -print  

find /etc/ -type f -name "*.conf" -print | sort | head -n5
# /etc/adduser.conf
# /etc/apache2/apache2.conf
# /etc/apache2/conf-available/charset.conf
# /etc/apache2/conf-available/javascript-common.conf
# /etc/apache2/conf-available/localized-error-pages.conf
```
`find` также может выполнить команду `Linux` для всех файлов в выходных данных, используя `-exec`.  
```sh
find /etc -type f -name "a*.conf" -print 2> /dev/null | sort | head -n5
# /etc/adduser.conf
# /etc/apache2/apache2.conf
# /etc/apache2/mods-available/actions.conf
# /etc/apache2/mods-available/alias.conf
# /etc/apache2/mods-available/autoindex.conf

# Пример вывода символа @ по обеим сторонам пути к файлу:
find /etc -type f -name "a*.conf" -exec echo @ {} @ ";" 2> /dev/null | sort | head -n5
# @ /etc/adduser.conf @
# @ /etc/apache2/apache2.conf @
# @ /etc/apache2/mods-available/actions.conf @
# @ /etc/apache2/mods-available/alias.conf @
# @ /etc/apache2/mods-available/autoindex.conf @
```
### `yes` <a name="yes"></a>
Команда `yes` выводит одну и ту же строку снова и снова, пока вы ее не остановите:
```sh
yes
# y
# y
# y
# y^C

yes 234 | head -n3
# 234
# 234
# 234
```
### `grep`. Более глубокий взгляд <a name="grep_ext"></a>


# Часть 3. Дополнительные плюсы <a name="part3"></a>

