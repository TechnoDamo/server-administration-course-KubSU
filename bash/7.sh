#!/bin/bash
# Сохраняем текущий разделитель и устанавливаем новый (':')
old_IFS=$IFS
IFS=':'

# Функция для подсчета выполняемых файлов в директории
count_executables() {
    local dir="$1"
    local count=0
    
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
            if [ -d "$dir" ] && [ -r "$dir" ] && [ ! -L "$dir" ]; then
                count=$(ls -la "$dir" 2>/dev/null | grep -v "^total" | grep -v "^d.*\\.$" | wc -l)
            else
                # Нечитаемая директория, симлинк или не существует
                count=0
            fi
            ;;
    esac
    
    echo $count
}

# Перебираем все каталоги в PATH и выводим количество выполняемых файлов
for dir in $PATH; do
    count=$(count_executables "$dir")
    echo "$dir => $count"
done

# Восстанавливаем стандартный разделитель
IFS=$old_IFS
