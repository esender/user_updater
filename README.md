**Дано:** <br />
очень большая таблица users с полями *id*, shard_id ( > 10 млн записей )
~~~
|id |shard_id|
| 1 |NULL    |
| 2 |NULL    |
|...|NULL    |
~~~

**Нужно:** <br />
Написать решение, которое назначает каждому полю shard_id случайное значение от 1 до 10, если оно  NULL.

Решение должно:
- позволять остановить обновление, поправить код в случае ошибки, и запустить заново, не обновляя уже обработанные записи.
-   быть устойчивым к исключениям в случае ошибок обновления отдельных записей.
-   масштабируемым ( позволяет запускать обновление многопоточно)
-   рассчитать примерное время завершения, исходя из количества одновременных потоков
-   работать на реальной рабочей системе без остановки приложения, использующего таблицу users

**Опционально**<br />
-    написать  API для получения количества необработанных записей
~~~
curl http://localhost:3000/api/sync/users/count
~~~

можно: пользоваться любыми библиотеками
