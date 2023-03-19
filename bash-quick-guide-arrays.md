## Массивы

```sh
#!/usr/bin/env bash

a=(1 "two" [100]="meteor" 27)

printf "Индексы\t\t: "
printf "%s " ${!a[@]}

printf "\nЭлементы\t: "
printf "%s " ${a[@]}
printf "\n\t\t: "
printf "%s " ${a[0]} ${a[1]} ${a[100]} ${a[101]}

printf "\nДлины элементов\t: "
printf "%s " ${#a[0]} ${#a[1]} ${#a[2]} ${#a[3]} ${#a[100]} ${#a[101]}

printf "\nВсего элементов\t: "
printf "%s " ${#a[@]}

printf "\nПеребор всех элементов:\n\t\t"
for i in ${!a[@]}; do
    printf "%s " ${a[i]}
done
printf "\n"
```
```sh
Индексы         : 0 1 100 101 
Элементы        : 1 two meteor 27 
                : 1 two meteor 27 
Длины элементов : 1 3 0 0 6 2 
Всего элементов : 4 
Перебор всех элементов:
                1 two meteor 27 
```
Можем поместить в массив результаты выполнения какой-либо команды:
```
dir1
├── alfa
└── beta
dir2
├── delta
├── gamma
└── vega
```

```sh
printf "\n\nОбъединение массивов:\\n"
b1=$(ls ./dir1) 
printf "%s " ${b1[@]}
printf "\n"  

b2=$(ls ./dir2)
printf "%s " ${b2[@]}
printf "\n" 

b1+=(${b2})
b1+=(24 02 2022)
printf "%s " ${b1[@]}
printf "\n"
```
```
Объединение массивов:
alfa beta 
delta gamma vega 
alfa beta delta gamma vega 24 02 2022 
```
