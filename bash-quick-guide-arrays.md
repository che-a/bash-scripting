## Массивы

```sh
#!/usr/bin/env bash

a=(1 "two" [100]="meteor" 27)

# Печать всех элементов массива
printf 'Массив: '
printf "\n\tиндексы:"
printf "\t%s " ${!a[@]}                        # 1 two meteor 27
printf "\n\tэлементы:"
printf "\t%s " ${a[@]}

printf "\nДлинна элемента:"
printf "\t%s\t%s" ${#a[0]} ${#a[1]} 

printf "\n- всего элементов: "
printf "\t%s " ${#a[@]}


# Доступ к элементу массива по индексу:
printf "\n\n[1]=%s\n" ${a[1]}               # two

# Вывод количества элементов массива:
printf "\nКол-во элементов: %s\n" ${#a[@]}  # 4

printf "\nДлинны элементов:\n"
printf "[0]=%s\n" ${#a[0]}                  # 1
printf "[1]=%s\n" ${#a[1]}                  # 3
printf "[2]=%s\n" ${#a[2]}                  # 0
printf "[3]=%s\n" ${#a[3]}                  # 0
printf "[100]=%s\n" ${#a[100]}              # 6
printf "[101]=%s\n" ${#a[101]}              # 2

```
