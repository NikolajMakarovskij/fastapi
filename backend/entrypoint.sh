#!/bin/sh
if [ "$DATABASE" = "buildAndTech" ]
then
    # если база еще не запущена
    echo "Ожидание..."
    # Проверяем доступность хоста и порта
    while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
      sleep 0.1
    done
    echo "Старт!"
fi
echo "Выполняем миграции"
alembic init migrations
sleep 1
echo "Добавляем таблицы в БД"
alembic revision --autogenerate -m "Added required tables"
sleep 1
echo "Обновляем заголовки"
alembic upgrade head

exec "$@"