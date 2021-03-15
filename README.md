# PAM
Pluggable Authentication Modules


### Задача
Запрет для всех пользователей, кроме группы admin логин в выходные (суббота и воскресенье), без учета праздников

### Проверка работы стенда: 
Созданы 3 пользователя: user1/user2/useradmin. 
user1/useradmin добавлены в группу admin, они могут ходить на сервер всегда.
User2 только в будние дни. Чтобы не перерабатывал ;)

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

#### Тесты скрипта
Проверка производилась в ПН (date + %u = 1)
Лог событий `/var/log/secure` - user1 состоит в группе admin / user2 - нет:

```
user2 - blocked:
Mar 15 14:31:47 localhost sshd[3440]: pam_exec(sshd:account): /opt/pamScript.sh failed: exit code 1                      
Mar 15 14:31:47 localhost sshd[3440]: Failed password for user2 from 10.0.2.2 port 50199 ssh2                            
Mar 15 14:31:47 localhost sshd[3440]: fatal: Access denied for user user2 by PAM account configuration [preauth]         

user1 - passed:
Mar 15 14:32:34 localhost sshd[3450]: Accepted password for user1 from 10.0.2.2 port 50201 ssh2                          
Mar 15 14:32:34 localhost sshd[3450]: pam_unix(sshd:session): session opened for user user1 by (uid=0)  
```
