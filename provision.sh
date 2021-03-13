#!/bin/bash

yum install -y epel-release vim nano
chmod +x /vagrant/pamScript.sh

# Добавляем юзеров с паролями и даем нескольким доп группу admin 
useradd user1 && useradd user2 && useradd useradmin
echo "123" | sudo passwd --stdin user1 && echo "123" | sudo passwd --stdin user2 && echo "123" | sudo passwd --stdin useradmin 
groupadd admin  
usermod -G admin useradmin
usermod -G admin user1 

# Добавляем правило для PAM смотреть в скрипт при логине/ssh
sed -i "5i account    required     pam_exec.so     /opt/pamScript.sh "  /etc/pam.d/sshd
