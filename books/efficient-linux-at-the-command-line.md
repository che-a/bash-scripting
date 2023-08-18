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
Файл `animals.txt` для демонстрации действия команд и конвейеров:  
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
Команда `cut` выводит одну или несколько колонок из файла.  
```sh

```
### grep

### sort

### uniq

# Часть 2. Продвинутые навыки

# Часть 3. Дополнительные плюсы
