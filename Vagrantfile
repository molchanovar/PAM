# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
  :pam => {
        :box_name => "centos/7",
        :ip_addr => '192.168.50.150',
		},
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|

      config.vm.define boxname do |box|

          box.vm.box = boxconfig[:box_name]
          box.vm.host_name = boxname.to_s

          box.vm.network "private_network", ip: boxconfig[:ip_addr]

          box.vm.provider :virtualbox do |vb|
            	  vb.customize ["modifyvm", :id, "--memory", "512"]
            	  vb.customize ["modifyvm", :id, "--cpus", "1"]
		      end
      
    
      box.vm.provision "shell", inline: <<-SHELL
mkdir -p ~root/.ssh; cp ~vagrant/.ssh/auth* ~root/.ssh
sed -i '65s/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd

yum install -y epel-release vim nano

# Добавляем юзеров с паролями и даем нескольким доп группу admin 
useradd user1 && useradd user2 && useradd useradmin
echo "123" | sudo passwd --stdin user1 && echo "123" | sudo passwd --stdin user2 && echo "123" | sudo passwd --stdin useradmin 
groupadd admin  
usermod -G admin useradmin
usermod -G admin user1 

# Скрипт для PAM (проверка что юзер есть в группе admin)
cat <<'EOT' > /etc/pam_script
#!/bin/bash
if [[ `grep $PAM_USER /etc/group | grep 'admin'` ]]
then
exit 0
fi
if [[ `date +%u` > 5 ]]
then
exit 1
fi
EOT

# Задаем PAM проверять юзеров скриптом
sed -i "8i account    required     pam_exec.so     /opt/pamScript.sh "  /etc/pam.d/sshd
chmod 777 /opt/pamScript.sh

SHELL

     end
  end
end
