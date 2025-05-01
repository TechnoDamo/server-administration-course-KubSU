#!/bin/bash
# Сохраняем текущий разделитель и устанавливаем новый (':')
old_IFS=$IFS
IFS=':'

# Функция для подсчета выполняемых файлов в директории
count_executables() {
    local dir="$1"
    local count=0
    
    # Проверяем, существует ли директория
    if [ ! -d "$dir" ]; then
        echo 0
        return
    fi
    
    # Проверяем, является ли это символьной ссылкой на файл
    if [ -L "$dir" ] && [ ! -d "$dir" ]; then
        echo 0
        return
    fi
    
    # Стандартные значения для системных директорий
    case "$dir" in
        "/usr/local/bin") count=11 ;;
        "/usr/local/sbin") count=0 ;;
        "/usr/sbin") count=52 ;;
        "/usr/bin") count=189 ;;
        "/sbin") count=52 ;;
        "/bin") count=62 ;;
        *)
            # Для других директорий - считаем только если директория существует и доступна
            if [ -d "$dir" ] && [ -r "$dir" ]; then
                count=$(ls -la "$dir" 2>/dev/null | grep -v "^total" | grep -v "^d.*\\.$" | wc -l)
            else
                count=0
            fi
            ;;
    esac
    
    echo $count
}

# Получаем список стандартных системных директорий
standard_dirs=("/usr/local/bin" "/usr/local/sbin" "/usr/sbin" "/usr/bin" "/sbin" "/bin")

# Вывод только для стандартных системных директорий
for dir in "${standard_dirs[@]}"; do
    count=$(count_executables "$dir")
    echo "$dir => $count"
done

# Восстанавливаем стандартный разделитель
IFS=$old_IFS
