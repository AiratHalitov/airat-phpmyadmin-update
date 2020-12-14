# airat-phpmyadmin-update
Скрипт для быстрого обновления phpmyadmin на сервере

## Установка и запуск:
```bash
git clone https://github.com/AiratHalitov/airat-phpmyadmin-update

cd airat-phpmyadmin-update

sudo ./airat-phpmyadmin-update.sh
```

**Примечания:** 
- Скрипт работает с папкой `/usr/share/phpmyadmin`, но если у тебя `phpmyadmin` установлен в другой папке - просто исправь переменную `PMADIR`
- Не забудь перед запуском скрипта обновить версию phpmyadmin в переменной `VER`
- Ключ `blowfish_secret` в файле `config.inc.php` генерируется и записывается скриптом автоматически
- Небольшая шпаргалка с объяснениями находится [тут](https://www.dmosk.ru/miniinstruktions.php?mini=phpmyadmin-update)
