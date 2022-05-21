# Сценарии командной оболочки bash

## Команды
Команды в `bash`:  
- внешние файлы;
  + исполняемые файлы — это файлы, состоящие из машинных команд, например, `/bin/ls`;
  + файлы скриптов — это текстовые файлы, написанные на интерпретируемом ЯП;
- встроенные функции — это часть оболочки. Они выглядят как исполняемые файлы, но в файловой системе нет файла, который загружается для исполнения того, что делают встроенные функции. Вместо этого работа выполняется внутри оболочки. Примером встроенной функции служит команда `pwd`. Применение таких функций позволит добиться результатов быстрее и с большей продуктивностью.
- ключевые слова.
```sh
# type - команда, которая определяет чем является слово
type pwd
# pwd — это встроенная команда bash

# Короткий вариант ответа
type -t if
# keyword
```
```sh
# Список доступных
compgen -c # команд
compgen -b # встроенных функций
compgen -k # ключевых слов
```
## Файловые дескрипторы
Каждый процесс в среде Unix/Linux/POSIX обладает тремя различными файловыми дескрипторами. 
- `stdin`, стандартный ввод (файловый дескриптор 0) — это ресурс ввода в программу по умолчанию. Обычно это символы, поступающие при вводе с клавиатуры. 
- `stdout`, стандартный вывод (файловый дескриптор 1) — это место, куда по умолчанию отправляется результат, выданный программой.
- `stderr`, стандартная ошибка (файловый дескриптор 2). В stderr пишутся (или должны писаться) сообщения об ошибках. Программист решает, отправить результат в stdout или
stderr.

## Перенаправление
Допустим, есть сценарий, который запрашивает с клаиватуры строку и потом выводит её два раза.
```sh
#!/usr/bin/env bash
read VAR1
echo "$VAR1$VAR1"
```
Примеры перенаправляний:
```sh
# получение данных из файла и вывод данных в файл
./script.sh < in.txt > out.txt

# Перенаправление стандартного вывода и стандартной ошибки в разные файлы
./script.sh > out.txt 2> errors.txt

# Перенаправление стандартного вывода и вывода ошибки в один файл
./script.sh > out.txt 2>&1
# или его более короткая запись:
./script.sh &> out.txt

# Отсев вывода ошибок (аргумент sd неверный)
ip sd 2> /dev/null
```

## Конвейеры
` | ` — символ «пайп» (pipe), нужен для того, чтобы результаты одной команды использовать в качестве входных данных для другой.
`tee` — читает из стандартного ввода и записывает в стандартный вывод и файлы.

```sh
# Ввод данных из файла и вывода результата в файл и на экран
./script.sh < in.txt | tee out.txt 
# то же самое, только выходной файл не перезаписывается, а дополняется
./script.sh < in.txt | tee -a out.txt 
```

## Выполнение команд в фоновом режиме
```sh
# Запуск ping в фоновом режиме и перенаправление стандартнго вывода в файл:
ping 192.168.10.56 > ping.log &
# или более правильная версия, чтобы ошибки не появлялись на экране
ping 192.168.10.56 &> ping.log &
```
`jobs` — это встроенная команда для получения списка задач, которые сейчас выполняются в фоновом режиме.
```sh
fg 1 # Вывод задачи 1 в приоритет из фонового режима
bg 1 # возобновление работы приостановленной программы в фоновом режиме.
```
`Ctrl + Z` — сочетание клвиш, которое применяется для приостановки приоритетной задачи.  

## Позиционные параметры
```sh
#!/usr/bin/env bash
echo $# # вывод количества парметров
echo $0 # вывод имени сценария
echo $1 # вывод 1-го параметра
echo $2  
echo $3
```
```sh
# Перебор всех параметров, которые передаются сценарию оболочки (или функции в сценарии), то есть $1 , $2 , $3 и т. д.
# ARG можно заменить любым именем переменной.
for ARG
do
    echo here is an argument: $ARG
done
```
## Условный оператор
`$?` — переменная, в которой содержится возвращаемое значение последней запущенной программы.  
`true` — 0 (т.е. код ошибки равн 0 — ошибки нет),  
`false` — любое ненулевое значение (код ошибки).
```sh
# В случае конвейера при проверке на успех/неудачу именно последняя команда определяет, будет ли выбрана true-ветвь.
if ls | grep pdf
then
    echo "found one or more pdf files here"
else
    echo "no pdf files found"
fi
```
```sh
# Проверка существует ли файл в файловой системе
if [[ -e $FILENAME ]]
then
    echo $FILENAME exists
fi
# Другие операторы проверки:
# -d , существует ли каталог
# -e , существует ли файл
# -r , существует ли файл и доступен ли он для чтения
# -w , существует ли файл и доступен ли он для записи
# -x , существует ли файл и является ли он исполняемым
```
```sh
# Проверка того, что переменная $VAL меньше переменной $MIN
# Оператор «меньше» использует лексическое (алфавитное) упорядочение. 
# Т.е. 12 меньше 2, потому что они сортируются в алфавитном порядке
if [[ $VAL -lt $MIN ]]
then
    echo "value is too small"
fi
# -eq Тест на равенство между числами
# -gt Проверка, больше ли одно число, чем другое
# -lt Проверка, меньше ли одно число, чем другое
```
```sh
# Численное сравнение
if (( VAL < 12 ))
then
    echo "value $VAL is too small"
fi
```
```sh
# Возвращает значение true, если переменная не установлена или установлена в пустую строку ""
if [[ -z $VAR ]] 
then 
    echo "branch then" 
else
    echo "branch else"
fi

```
```sh
# команда ls будет выполняться только в случае успешного выполнения команды cd
cd $DIR && ls

# сообщение будет напечатано только в случае сбоя команды cd
cd $DIR || echo cd failed

# возможна и такая запись
[[ -d $DIR ]] || { echo "error: no such directory: $DIR" ; exit ; }
```


## Циклы
```sh
i=0
while (( i < 1000 ))
do
    echo $i
    let i++
done

# Более сложный цикл while, который выполняет команды как часть своего условия:
while ls | grep -q pdf
do
    echo -n 'there is a file with pdf in its name here:'
    pwd
    cd ..
done

for ((i=0; i < 100; i++))
do
    echo $i
done

# Для произвольного списка значений, который зада явно:
for VAL in 20 3 dog peach 7 vanilla
do
    echo $VAL
done

# Генерация последовательности в цикле
for VAL in $(ls | grep pdf) {0..5}
do
    echo $VAL
done
```
## Последовательности
Последовательность `{090..104..2}` будет заполнена четными цифрами, находящимися в диапазоне от 090 до 104 включительно, причем каждая цифра будет представлена в виде трех чисел.

## Функции
Функции, как и команды, должны возвращать статус: 0 , если все идет хорошо, и значение, отличное от нуля, если произошла ошибка.
```sh
function myfun ()
{
    # это тело функции
}
```

## Сопоставление с шаблоном
- Шаблоны сопоставляются с файлами в файловой системе.  
- Шаблоны не являются регулярными выражениями.  
- Внутри кавычек (двойных или одинарных) не происходит сопоставления с шаблоном.  

`*` соответствetn любому количеству любых символов.  
`?` соответствует одному символу.  
`[ ]` сопоставление может быть выполнено с любым из символов, перечисленных в квадратных скобках.  

`x[abc]y` — соответствует любому или всем файлам с именами `xay`, `xby` или `xcy` при условии, что они существуют.  
`[0–9]` — соответствует одной любой цифре.  
`[aeiou]` — соответствовует гласным буквам.  
`[^aeiou]` — соответствует любым символам (включая цифры и знаки пунктуации), кроме гласных.  

### Классы символов
```
[:alnum:]  Алфавитно-цифровой
[:alpha:]  Буквенный
[:ascii:]  ASCII (американский стандартный код для обмена информацией)
[:blank:]  Пробел и символ табуляции
[:ctrl:]   Управляющий символ
[:digit:]  Число
[:graph:]  Все что угодно, кроме управляющих символов и пробела
[:lower:]  Символы в нижнем регистре
[:print:]  Все, кроме управляющих символов
[:punct:]  Символы пунктуации
[:space:]  Пробелы, включая разрывы строк
[:upper:]  Символы в верхнем регистре
[:word:]   Буквы, цифры и символ подчеркивания
[:xdigit:] Шестнадцатеричный символ
```
Классы символов указываются как `[:ctrl:]`, но в дополнительных квадратных скобках.  
Шаблон `*[[:punct:]]jpg` соответствует любому имени файла, имеющему любое количество любых символов, за которыми следуют знаки пунктуации, а за ними — буквы jpg.
