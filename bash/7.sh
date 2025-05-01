#!/bin/bash
# Сохраняем текущий разделитель и устанавливаем новый (':')
old_IFS=$IFS
IFS=':'

# Массив для отслеживания уникальных каталогов (разрешаем символические ссылки)
declare -A processed_dirs

# Перебираем все каталоги в PATH
for dir in $PATH; do
    # Если каталог пустой, пропускаем
    if [ -z "$dir" ]; then
        continue
    fi
    
    # Получаем реальный путь (с разрешением символических ссылок)
    real_dir=$(readlink -f "$dir" 2>/dev/null)
    
    # Если каталог уже обработан (дубликат), пропускаем
    if [[ -n "${processed_dirs[$real_dir]}" ]]; then
        echo "$dir => ${processed_dirs[$real_dir]}"
        continue
    fi
    
    # Проверяем, существует ли каталог и доступен ли для чтения
    if [ -d "$dir" ]; then
        # Считаем файлы (включая скрытые, исключая '.' и '..')
        if [ -r "$dir" ]; then
            # Подсчет файлов, включая исполняемые символические ссылки на файлы
            count=$(find "$dir" -maxdepth 1 -type f -o -type l -exec test -x {} \; -print 2>/dev/null | wc -l)
        else
            count=0
        fi
    else
        count=0  # Если каталог не существует
    fi
    
    # Запоминаем результат для этого реального пути
    processed_dirs[$real_dir]=$count
    
    echo "$dir => $count"
done

# Восстанавливаем стандартный разделитель
IFS=$old_IFS
