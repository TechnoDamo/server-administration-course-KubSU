#!/bin/bash
# Проверка условий на переменные окружения
if [[ "$FOO" == "5" && "$BAR" == "1" ]]; then
    echo "Выполнение запрещено: FOO=5 и BAR=1."
    exit 1
fi

echo "Мониторим текущий каталог. Ожидаем новый файл..."
# Используем inotifywait для отслеживания появления файлов
while true; do
    new_file=$(inotifywait -q -e create --format "%f" .)
    echo "Обнаружен файл: $new_file"
    exit 0
done
