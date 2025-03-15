#!/bin/bash

output_file="logs.log"

# Очищаем файл, если он существует
> "$output_file"

# Обрабатываем каждый .log файл в /var/log
for logfile in /var/log/*.log; do
    if [ -f "$logfile" ]; then
        # Получаем последнюю строку из файла
        last_line=$(tail -n 1 "$logfile")
        # Записываем её в output_file
        echo "$logfile: $last_line" >> "$output_file"
    fi
done

echo "Последние строки сохранены в $output_file"
