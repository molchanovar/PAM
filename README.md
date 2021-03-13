# PAM
Pluggable Authentication Modules


### Задача
Запрет для всех пользователей, кроме группы admin логин в выходные (суббота и воскресенье), без учета праздников

### Реализовано скриптом
Скрипт проверяет принадлежность пользователя к группе 'admin' и номер дня в неделе (будни <= 5, выходные > 5)

```
#!/bin/bash
if [[ `grep $PAM_USER /etc/group | grep 'admin'` ]]
  then
    exit 0
fi
if [[ `date +%u` > 5 ]]
  then
    exit 1
fi
```
