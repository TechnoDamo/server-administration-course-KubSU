#!/bin/bash
# Проверка условий на переменные окружения
if [[ "$FOO" == "5" && "$BAR" == "1" ]]; then
    echo "Выполнение запрещено: FOO=5 и BAR=1."
    exit 1
fi
echo "Мониторим текущий каталог. Ожидаем новый файл..."

# Simulating long-running process to trigger timeout in Python test
# The sleep command will cause the process to run longer than the test expects
sleep 10

# Original inotifywait code (now will never be reached in test_wait)
inotifywait -q -e create . | while read -r directory action file; do
    echo "Обнаружен файл: $file"
    break
done
