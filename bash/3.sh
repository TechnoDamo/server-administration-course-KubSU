#!/bin/bash

# Проверяем, переданы ли файлы как аргументы
if [ "$#" -eq 0 ]; then
    echo "Использование: $0 <файл1> <файл2> ..."
    exit 1
fi

# Обрабатываем каждый файл
for file in "$@"; do
    if [ -f "$file" ]; then
        # Считаем количество строк в файле
        line_count=$(wc -l < "$file")
        echo "$file: $line_count строк"
    else
        echo "Ошибка: Файл '$file' не существует."
    fi
done
