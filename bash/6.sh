#!/bin/bash
# Проверка условий на переменные окружения
if [[ "$FOO" == "5" && "$BAR" == "1" ]]; then
    echo "Выполнение запрещено: FOO=5 и BAR=1."
    exit 1
fi

echo "Мониторим текущий каталог. Ожидаем новый файл..."
# Используем бесконечный цикл и непрерывную проверку каталога
while true; do
    # Сохраняем текущее состояние каталога
    current_files=$(ls -1a)
    
    # Ждем короткую паузу
    sleep 1
    
    # Проверяем, появились ли новые файлы
    new_files=$(ls -1a)
    
    # Сравниваем старый и новый список файлов
    diff_files=$(diff <(echo "$current_files") <(echo "$new_files") | grep "^>" | cut -c 3-)
    
    if [ -n "$diff_files" ]; then
        echo "Обнаружен файл: $diff_files"
        exit 0
    fi
done
