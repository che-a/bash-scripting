Барретт Дэниел Джей.  
Linux. Командная строка. Лучшие практики. 2023

# Часть 1. Основные понятия
## Объединение команд
### Каналы
**Канал (|)** — это механизм межпроцессного взаимодействия в `Unix`, который перенаправляет стандартный вывод одной программы на стандартный вход другой программы.  
**Конвейр (pipeline)** — командная строка, содержащая каналы.  
```bash
ls -l /bin | less
```
Ниже представлен файл `animals.txt` для демонстрации действия команд и конвейеров, в котором колонки разделены символом табуляции:  
```
python  Programming Python      2010    Lutz, Mark
snail   SSH, The Secure Shell   2005    Barrett, Daniel
alpaca  Intermediate Perl       2012    Schwartz, Randal
robin   MySQL High Availability 2014    Bell, Charles
horse   Linux in a Nutshell     2009    Siever, Ellen
donkey  Cisco IOS in a Nutshell 2005    Boney, James
oryx    Writing Word Macros     1999    Roman, Steven
```
### wc
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
### head
Команда `head` выводит первые строки файла. По умолчанию выводятся первые 10 строк. Эта команда работает быстро и эффективно
даже с очень большими файлами, поскольку ей не нужно считывать весь файл.  
```sh
# Подсчет кол-ва строк в первых трех строках файла
head -n3 animals.txt | wc -w
# 20
```

### cut
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

### grep
Команда `grep` печатает строки, соответствующие заданному шаблону.  
```sh
grep Nutshell animals.txt 
# horse        Linux in a Nutshell        2009        Siever, Ellen
# donkey        Cisco IOS in a Nutshell        2005        Boney, James

# Печать строк, не соответствующих шаблону
grep -v Nutshell animals.txt 
# python	Programming Python	2010	Lutz, Mark
# snail	  SSH, The Secure Shell	2005	Barrett, Daniel
# alpaca	Intermediate Perl	2012	Schwartz, Randal
# robin	  MySQL High Availability	2014	Bell, Charles
# oryx	  Writing Word Macros	1999	Roman, Steven

```

### sort

### uniq

# Часть 2. Продвинутые навыки

# Часть 3. Дополнительные плюсы
