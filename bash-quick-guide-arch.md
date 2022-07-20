# Работа с архивами
## Создание архивов
### zip
```sh
# Создать архив archive.zip из файлов (и/или директорий) file1 file2 ...
zip archive.zip file1 file2
```

### gzip
```sh
# Создать архив file.txt.gz со сжатием из одниночного файла file.txt. Исходный файл file.txt будет удалён. 
gzip file.txt

# Упаковать без сжатия перечисленные файлы и/или директории в archive.tar
tar -cvf archive.tar file1 file2 file3 ...
# Создать сжатый архив archive.tar.gz из упакованного файла archive.tar, который будет удален
gzip archive.tar

# Или то же самое сделать одной командой
tar -zcvf archive.tar.gz file1 file2 file3 ...

# Создание архивов без удаления исходный файлов
gzip -c file > file.gz
```

### bzip2
```sh
# Создать архив file.txt.bz2 со сжатием из одниночного файла file.txt. Исходный файл file.txt будет удалён. 
bzip2 file.txt

# Упаковать без сжатия перечисленные файлы и/или директории в archive.tar и создать сжатый архив archive.tar.bz2
tar -cjvf archive.tar.bz2 file1 file2 file3 ...

# Создание архивов без удаления исходный файлов
bzip2 -c file > file.bz2
```

## Распаковка архивов
```sh
# Распаковка содержимого архива archive.zip
unzip archive.zip

# Распаковка содержимого архива archive.gz (файл archive.gz будет удалён)
gunzip archive.gz

# Распаковка архива archive.tar
tar -xvf archive.tar

# Распаковка архива archive.tar.gz (с использованием gunzip)
tar -xzvf archive.tar.gz

# Распаковка архива archive.bz2. Исходный архив будет удалён.
bunzip2 archive.bz2

# Распаковка архива archive.tar.bz2 (с использованием bzip2)
tar -xjvf archive.tar.bz2

# Распаковка архивов без удаления исходного файла
gunzip -c file.gz > file
bunzip2 -c file.bz2 > file
```
