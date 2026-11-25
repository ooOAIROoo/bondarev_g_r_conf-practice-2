#!/bin/sh
# Запуск pr_4 (этап 1).
#   ./run.sh          -- CLI depviz (аргументы пробрасываются)
#   ./run.sh test     -- юнит-тесты
#   ./run.sh style    -- проверка стиля по критериям отчёта
#   ./run.sh check    -- полный прогон всех проверок
# Скрипт работает из любого каталога.
set -e
cd "$(dirname "$0")"

case "$1" in
    test)
        python3 -m unittest discover -s tests -t .
        ;;
    style)
        python3 scripts/check_style.py .
        ;;
    check)
        python3 scripts/check_style.py .
        PYTHONPATH=src python3 -m unittest discover \
            -s tests -t .
        bash scripts/run_all.sh
        ;;
    *)
        PYTHONPATH=src python3 -m depviz "$@"
        ;;
esac
