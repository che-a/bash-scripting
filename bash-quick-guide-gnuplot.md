# gnuplot

`gnuplot` -- это программа для построения графиков. Имеет 2 режима работы:  
- интерактивный,  
- потоковый.

Примеры: http://gnuplot.sourceforge.net/demo/

Содержимое файла `authors.txt` для примеров.
```
Year All_fields Engineering Astronomy Chemistry Physics Geosciences Mathematics Computer_sciences Agricultural_sciences Biological_sciences Medical_sciences Other_life_sciences Psychology Social_sciences
1988 3.1 2.5 2.5 3.1 3.3 2.4 1.5 1.9 2.7 3.3 3.6 2.0 2.0 1.4
1993 3.4 2.8 3.2 3.3 3.8 2.7 1.6 2.0 2.9 3.7 4.1 2.1 2.2 1.5
1998 3.8 3.1 3.6 3.6 4.2 3.2 1.8 2.3 3.3 4.2 4.5 2.4 2.5 1.6
2003 4.2 3.4 4.5 3.9 4.7 3.5 1.9 2.6 3.8 4.6 5.0 2.9 2.8 1.8
2008 4.7 3.8 5.9 4.3 5.3 4.0 2.0 3.0 4.3 5.3 5.6 3.2 3.2 1.9
```

## Интерактивный режим
```sh
# Построить один график по файлу; 
# 1 -- первая колонка в файле -- координата х, 
# 2 -- вторая колонка в файле -- координата у
plot '<файл>' using 1:2

# Построить два графика по файлу
plot '<файл>' using 1:2, '<файл>' using 1:3

```

## Потоковый режим
Создаем скрипт:
```sh
#! /usr/bin/gnuplot -persist
set terminal png enhanced
set output "plot.png"
set ...
plot ...
```
