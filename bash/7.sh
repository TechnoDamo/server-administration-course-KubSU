#!/bin/bash

# Разделяем PATH на отдельные каталоги
IFS=':' read -ra paths <<< "$PATH"

# Обрабатываем каждый каталог
for path in "${paths[@]}"; do
    if [ -d "$path" ]; then
        # Считаем количество файлов в каталоге
        file_count=$(find "$path" -maxdepth 1 -type f | wc -l)
        echo "$path: $file_count файлов"
    else
        echo "$path: Каталог не существует."
    fi
done
