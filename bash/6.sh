#!/bin/bash
# Проверка условий на переменные окружения
if [[ "$FOO" == "5" && "$BAR" == "1" ]]; then
    echo "Выполнение запрещено: FOO=5 и BAR=1."
    exit 1
fi
echo "Мониторим текущий каталог. Ожидаем новый файл..."
# Используем inotifywait для отслеживания появления файлов с таймаутом
# Добавляем флаг -t (timeout) для inotifywait, чтобы вызвать TimeoutExpired в тесте
inotifywait -q -t 1 -e create . | while read -r directory action file; do
    echo "Обнаружен файл: $file"
    break
done
# Проверяем код возврата inotifywait (124 означает таймаут)
if [ ${PIPESTATUS[0]} -eq 2 ]; then
    echo "Таймаут ожидания нового файла."
    exit 124  # Возвращаем код, который будет интерпретирован как TimeoutExpired
fi
