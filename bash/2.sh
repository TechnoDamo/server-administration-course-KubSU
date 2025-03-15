#!/bin/bash

# Проверяем, передан ли путь как аргумент
if [ "$#" -ne 1 ]; then
    echo "Использование: $0 <путь_к_каталогу>"
    exit 1
fi

directory_path=$1

# Проверяем, существует ли каталог
if [ ! -d "$directory_path" ]; then
    echo "Ошибка: Каталог '$directory_path' не существует."
    exit 1
fi

# Обрабатываем каждый подкаталог
for subdir in "$directory_path"/*/; do
    if [ -d "$subdir" ]; then
        # Получаем имя подкаталога
        subdir_name=$(basename "$subdir")
        # Создаём имя файла
        file_name="${subdir_name}.txt"
        # Считаем количество элементов в подкаталоге
        item_count=$(find "$subdir" -maxdepth 1 -type f | wc -l)
        # Записываем количество в файл
        echo "$item_count" > "$file_name"
        echo "Создали файл '$file_name' с $item_count элементами."
    fi
done
